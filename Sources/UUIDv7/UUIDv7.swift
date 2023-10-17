// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


public struct UUID7 {

    private let timestamp48bit: Int64

    public let str: String

    public init?() {
        timestamp48bit = Int64(Date().timeIntervalSince1970 * 1000) & 0x0000_FFFF_FFFF

        guard let randomData = UUID7.generateRandomBits(bitCount: 60) else { return nil }

        // Convert randomData to UInt64
        let randomBits: UInt64 = randomData.prefix(8).reversed().enumerated().reduce(0) {
            $0 + (UInt64($1.element) << (UInt64($1.offset) * 8))
        }

        let versionAndVariantSetBits = UUID7.setVersionAndVariantBits(randomBits: randomBits)

        let timestampHex = String(format: "%012llX", timestamp48bit)
        let randomBitsHex = String(format: "%015llX", versionAndVariantSetBits)

        // Split the timestamp and random bits into the UUID 8-4-4-4-12 format
        let uuidString = "\(timestampHex.prefix(8))-\(timestampHex.dropFirst(8).prefix(4))-\(randomBitsHex.prefix(4))-\(randomBitsHex.dropFirst(4).prefix(4))-\(randomBitsHex.dropFirst(8))"

        str = uuidString
    }

    private static func generateRandomBits(bitCount: Int) -> Data? {
        guard bitCount > 0 else { return nil }

        let byteCount = (bitCount + 7) / 8
        var randomBytes = [UInt8](repeating: 0, count: byteCount)

        #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
        // On Apple device, use Security framework to enforce SecureEnclave random generation
        let result = SecRandomCopyBytes(kSecRandomDefault, byteCount, &randomBytes)
        guard result == errSecSuccess else { return nil }
        #else
        // On the other platform, use OpenSSL to generate random
        let result = RAND_bytes(&randomBytes, Int32(byteCount))
        guard result == 1 else { return nil }
        #endif

        return Data(randomBytes)
    }

    private static func setVersionAndVariantBits(randomBits: UInt64) -> UInt64 {
        let versionBits: UInt64 = 7 << 56  // Version 7
        let variantBits: UInt64 = 2 << 62  // Variant 1
        return randomBits | versionBits | variantBits
    }
}
