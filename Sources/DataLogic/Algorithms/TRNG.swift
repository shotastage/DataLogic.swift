//
//  TRNG.swift
//
//
//  Created by Shota Shimazu on 2023/10/21.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
    import Security
#elseif os(Linux)
    import UnixTPM
#elseif os(Windows)
    import NtTPM
#else
    import OpenSSL
#endif

enum SecureTRNGType {
    case int(Int)
    case range(ClosedRange<Double>)
}

public struct SecureTRNG: LogicProcedure {
    var input: SecureTRNGType?
    public var value: ProcedureOutput<RandomValue>

    /// String random
    public init?(length: Int) {
        guard let rand = SecureTRNG.generateRandomNumber(digits: length) else {
            return nil
        }
        value = .value(RandomValue.string(rand))
    }

    /// Double random number
    public init?(range: ClosedRange<Double>) {
        guard let randDouble = SecureTRNG.generateSecureRandomDouble() else {
            return nil
        }
        let scale = Double(UInt32.max) + 1
        let scaledRandom = randDouble / scale
        let diff = range.upperBound - range.lowerBound
        let randomInRange = (scaledRandom * diff) + range.lowerBound
        value = .value(RandomValue.double(randomInRange))
    }

    mutating func execute() -> ProcedureOutput<RandomValue>? {
        return .void
    }

    private static func generateSecureRandomDouble() -> Double? {
        var randomUInt32 = UInt32()
        let status = SecRandomCopyBytes(kSecRandomDefault, MemoryLayout.size(ofValue: randomUInt32), &randomUInt32)
        guard status == errSecSuccess else { return nil }
        return Double(randomUInt32)
    }

    private static func generateRandomNumber(digits: Int) -> String? {
        guard digits > 0 else { return nil }

        let byteCount = (digits + 1) / 2 // 1 byte can represent 2 hexadecimal digits
        var randomBytes = [UInt8](repeating: 0, count: byteCount)

        let status = SecRandomCopyBytes(kSecRandomDefault, byteCount, &randomBytes)
        guard status == errSecSuccess else { return nil }

        let hexString = randomBytes.map { String(format: "%02x", $0) }.joined()
        let startIndex = hexString.startIndex
        let endIndex = hexString.index(startIndex, offsetBy: digits)

        return String(hexString[startIndex ..< endIndex])
    }
}
