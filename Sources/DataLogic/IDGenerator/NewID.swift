//
//  NewID.swift
//
//  Created by Shota Shimazu on 2023/10/17.
//  Copyright © 2023 Shota Shimazu. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


public struct NewID {

    public enum Reliability {
        case weak
        case medium
        case high
    }

    public enum Security {
        case low
        case medium
        case high
    }

    public enum Speed {
        case slow
        case medium
        case fast
    }

    let timestamp64bit = Int64(Date().timeIntervalSince1970 * 1000)

    private(set) var id: (UInt64, UInt8, UInt8)

    private(set) var idString: String

    init() {
        print("Now under construction...")
        // Create a bitmask to isolate the top 41 bits.
        // This bitmask has 41 ones at the left and the rest are zeros.
        let bitmask: Int64 = (1 << (64 - 41)) - 1

        // Shift the timestamp64bit to the right to align the top 41 bits with the right.
        let shiftedTimestamp = timestamp64bit >> (64 - 41)

        // Apply the bitmask using the bitwise AND operator.
        let top41Bits = shiftedTimestamp & bitmask

        
        id = (UInt64(top41Bits), 1, 1)

        idString = ""
    }

    /// Generates random bits of specified bit count.
    /// - Parameter bitCount: The number of random bits to generate.
    /// - Returns: A `Data` object containing the random bits, or `nil` if an error occurs.
    private static func generateFastRandomBits(bitCount: Int) -> Data? {
        guard bitCount > 0 else { return nil }

        let byteCount = (bitCount + 7) / 8
        var randomBytes = [UInt8](repeating: 0, count: byteCount)

        //- let ss = Xorshift(seed: randomBytes).random()

        return Data(randomBytes)
    }

    /// Generates random bits of specified bit count.
    /// - Parameter bitCount: The number of random bits to generate.
    /// - Returns: A `Data` object containing the random bits, or `nil` if an error occurs.
    private static func generateSecureRandomBits(bitCount: Int) -> Data? {
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
