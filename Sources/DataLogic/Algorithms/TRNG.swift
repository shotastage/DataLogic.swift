//
//  TRNG.swift
//
//
//  Created by Shota Shimazu on 2023/10/21.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


public struct OnDeviceRandom {
    
    private(set) random: UInt64
    
    init(length: UInt64) {
        random = 0
    }

    /// Generates random bits of specified bit count.
    /// - Parameter bitCount: The number of random bits to generate.
    /// - Returns: A `Data` object containing the random bits, or `nil` if an error occurs.
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
}
