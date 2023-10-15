// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Security

public struct UUID7 {

    private let VERSION_7: UInt16 = 0x7000
    private let VARIANT_RFC4122: UInt16 = 0x8000
    
    private let timestamp = Int64(Date().timeIntervalSince1970 * 1000)

    let unix_ts_ms: UInt32
    let unix_ts_ms1: UInt32
    let unix_ts_ms2: UInt32
    
    let rand_a: UInt16
    let rand_b1: UInt16
    let rand_b2: UInt16
    let rand_b3: UInt32
    
    public init() {
        unix_ts_ms = UInt32(timestamp & (1 << 48) - 1) // take 48 least significant bits of timestamp
        unix_ts_ms1 = UInt32((unix_ts_ms >> 16) & 0xffffffff) // take 32 most significant bits of timestamp
        unix_ts_ms2 = UInt32(unix_ts_ms & 0xffff) // take 16 least significant bits of timestamp
        
        var randomBytes = [UInt8](repeating: 0, count: 10)
        _ = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        
        rand_a = UInt16(bigEndian: Data(randomBytes[0..<2]).withUnsafeBytes { $0.load(as: UInt16.self) })
        rand_b1 = UInt16(bigEndian: Data(randomBytes[2..<4]).withUnsafeBytes { $0.load(as: UInt16.self) })
        rand_b2 = UInt16(bigEndian: Data(randomBytes[4..<6]).withUnsafeBytes { $0.load(as: UInt16.self) })
        rand_b3 = UInt32(bigEndian: Data(randomBytes[6..<10]).withUnsafeBytes { $0.load(as: UInt32.self) })
    }

    private func generate() -> [UInt32] {
        
        let a = rand_a & 0xfff // take 12 bits of 16
        let b1 = rand_b1 & 0x3fff // take 14 bits of 16
        
        return [
            unix_ts_ms1,
            unix_ts_ms2,
            UInt32(VERSION_7) | UInt32(a),
            UInt32(VARIANT_RFC4122) | UInt32(b1),
            UInt32(rand_b2),
            rand_b3
        ]
    }

    public func getStr() -> String {
        let uuidParts = generate()
            
            return String(format: "%08x-%04x-%04x-%04x-%04x%08x",
                          uuidParts[0],
                          UInt16(uuidParts[1]),
                          UInt16(uuidParts[2]),
                          UInt16(uuidParts[3]),
                          UInt16(uuidParts[4]),
                          uuidParts[5])
    }
}
