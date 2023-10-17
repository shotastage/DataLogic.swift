//
//  UUIDv7.swift
//
//  Created by Shota Shimazu on 2023/10/15.
//  Copyright © 2023 Shota Shimazu. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


/// `UUID7` is a struct for creating and managing UUID version 7 identifiers.
public struct UUID7 {

    /// A 48-bit timestamp representing the number of milliseconds since the Unix epoch.
    private var timestamp48bit: Int64

    //- public var uuid: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    /// A string representation of the UUID.
    public var uuidString: String

    /// Initializes a new UUID with a current timestamp and random bits.
    public init() {
        self.timestamp48bit = Int64(Date().timeIntervalSince1970 * 1000) & 0x0000_FFFF_FFFF
        guard let randomData = UUID7.generateRandomBits(bitCount: 60) else { fatalError() }

        // Convert randomData to UInt64
        let randomBits: UInt64 = randomData.prefix(8).reversed().enumerated().reduce(0) {
            $0 + (UInt64($1.element) << (UInt64($1.offset) * 8))
        }

        let versionAndVariantSetBits = UUID7.setVersionAndVariantBits(randomBits: randomBits)

        let timestampHex = String(format: "%012llX", timestamp48bit)
        let randomBitsHex = String(format: "%015llX", versionAndVariantSetBits)

        // Split the timestamp and random bits into the UUID 8-4-4-4-12 format
        let uuidString = "\(timestampHex.prefix(8))-\(timestampHex.dropFirst(8).prefix(4))-\(randomBitsHex.prefix(4))-\(randomBitsHex.dropFirst(4).prefix(4))-\(randomBitsHex.dropFirst(8))"

        self.uuidString = uuidString
    }

    /// Initializes a new UUID from a string representation.
    /// - Parameter uuidString: A string representation of the UUID.
    public init?(uuidString: String) {
        self.timestamp48bit = Int64(Date().timeIntervalSince1970 * 1000) & 0x0000_FFFF_FFFF

        self.uuidString = uuidString
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

    /// Generates random bits of specified bit count without utilizing secure random generators.
    /// - Parameter bitCount: The number of random bits to generate.
    /// - Returns: A `Data` object containing the random bits.
    private static func generateUnsafeRandomBits(bitCount: Int) -> Data {
        let byteCount = (bitCount + 7) / 8
        var randomBytes = [UInt8](repeating: 0, count: byteCount)

        for i in 0..<byteCount {
            randomBytes[i] = UInt8(arc4random_uniform(256))
        }

        return Data(randomBytes)
    }

    /// Sets the version and variant bits for the specified random bits.
    /// - Parameter randomBits: The random bits to set the version and variant bits for.
    /// - Returns: A new `UInt64` value with the version and variant bits set.
    private static func setVersionAndVariantBits(randomBits: UInt64) -> UInt64 {
        let versionBits: UInt64 = 7 << 56  // Version 7
        let variantBits: UInt64 = 2 << 62  // Variant 1
        return randomBits | versionBits | variantBits
    }
}
