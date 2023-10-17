//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2023/10/18.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


public struct RandStr {
    
    private(set) var idString: String
    
    init(length: Int) {
        self.idString = RandStr.generateRandomString(length: length)!
    }
    
    private static func generateRandomString(length: Int) -> String? {
        var randomBytes = [UInt8](repeating: 0, count: length)
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &randomBytes)
        
        guard result == errSecSuccess else { return nil }

        return randomBytes.map { String(format: "%02hhx", $0) }.joined()
    }
}
