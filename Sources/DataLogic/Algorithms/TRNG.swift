//
//  TRNG.swift
//
//
//  Created by Shota Shimazu on 2023/10/21.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#elseif os(Linux)
import UnixTPM
#elseif os(Windows)
import NtTPM
#else
import OpenSSL
#endif


public struct OnChipTRNG {

    private(set) var random: String

    init?(length: Int) {
        guard let rand = OnChipTRNG.generateRandomNumber(digits: length) else {
            return nil
        }
        random = rand
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

        return String(hexString[startIndex..<endIndex])
    }
}
