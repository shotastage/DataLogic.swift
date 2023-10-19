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

    init() {
        print("Now under construction...")
    }

    private func generateRandomMap(length: Int, reliability: Reliability, speed: Speed) -> String? {
        // An array to hold the random byte values.
        var randomBytes = [UInt8](repeating: 0, count: length)

        // Generating random bytes using the Security framework.
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &randomBytes)

        // Checking the result of the random bytes generation.
        guard result == errSecSuccess else { return nil }

        return String(result) 
    }
}
