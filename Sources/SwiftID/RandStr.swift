//
//  RandStr.swift
//
//  Created by Shota Shimazu on 2023/10/18.
//

import Foundation

// Conditionally import Security or OpenSSL based on the platform.
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif

/// `RandStr` is a struct for creating and managing random strings.
public struct RandStr {

    /// A string containing a hexadecimal representation of random bytes.
    private(set) var idString: String

    /// Initializes a new `RandStr` instance with a specified length for the random string.
    /// - Parameter length: The length of the random string in bytes.
    init(length: Int) {
        self.idString = RandStr.generateRandomString(length: length)!
    }

    /// Generates a random string of the specified length.
    /// - Parameter length: The length of the random string in bytes.
    /// - Returns: A string containing a hexadecimal representation of random bytes, or `nil` if an error occurs.
    private static func generateRandomString(length: Int) -> String? {
        var randomBytes = [UInt8](repeating: 0, count: length)
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &randomBytes)

        guard result == errSecSuccess else { return nil }

        return randomBytes.map { String(format: "%02hhx", $0) }.joined()
    }
}
