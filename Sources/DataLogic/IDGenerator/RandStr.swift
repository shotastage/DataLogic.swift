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

    /// An enumeration defining the types of characters that can be included in the random string.
    public enum TextConditions {
        case numeric        // Allow numeric characters.
        case alphabetic     // Allow alphabetic characters.
        case symbolic       // Allow symbolic characters.
    }

    /// A string containing a hexadecimal representation of random bytes.
    private(set) public var idString: String

    /// Initializes a new `RandStr` instance with a specified length for the random string.
    /// - Parameter length: The length of the random string in bytes.
    public init(length: Int) {
        self.idString = RandStr.generateRandomString(length: length, conditions: [.alphabetic, .numeric])!
    }

    /// Initializes a new `RandStr` instance with a specified length and conditions for the random string.
    /// - Parameters:
    ///   - length: The length of the random string in bytes.
    ///   - conditions: The types of characters to be included in the random string.
    public init(length: Int, conditions: [TextConditions]) {
        self.idString = RandStr.generateRandomString(length: length, conditions: conditions)!
    }

    public func getAsNumber() -> Int? {
        Int(self.idString) ?? 0
    }

    /// Generates a random string of the specified length based on the specified conditions.
    /// - Parameters:
    ///   - length: The length of the random string in bytes.
    ///   - conditions: The types of characters to be included in the random string.
    /// - Returns: A string containing a hexadecimal representation of random bytes, or `nil` if an error occurs.
    private static func generateRandomString(length: Int, conditions: [TextConditions]) -> String? {
        let alphabets = Array("abcdefghijklmnopqrstuvwxyz")  // Array of alphabetic characters.

        let numerics = Array("0123456789")  // Array of numeric characters.

        let symbols = Array("!@#$%&*()-_+=^[]{}\\|;:'\"?/.>,<")  // Array of symbolic characters.

        var charList = Array("")

        for condition in conditions {
            switch condition {
            case .alphabetic:
                charList += alphabets
            case .numeric:
                charList += numerics
            case .symbolic:
                charList += symbols
            }
        }

        // An array to hold the random byte values.
        var randomBytes = [UInt8](repeating: 0, count: length)

        // Generating random bytes using the Security framework.
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &randomBytes)

        // Checking the result of the random bytes generation.
        guard result == errSecSuccess else { return nil }

        // Mapping the random bytes to alphabetic characters and joining them to form a string.
        return randomBytes.map { String(charList[Int($0) % charList.count]) }.joined()
    }
}
