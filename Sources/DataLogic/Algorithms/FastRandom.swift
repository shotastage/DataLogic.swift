//
//  FastPseudorandom.swift
//
//
//  Created by Shota Shimazu on 2023/10/21.
//

import Foundation

public struct NewFastRand {
    
}

struct Xorshift128 {
    private var state: (UInt32, UInt32, UInt32, UInt32)
    
    init(seed: (UInt32, UInt32, UInt32, UInt32)) {
        self.state = seed
    }
    
    mutating func random() -> UInt32 {
        var s: (UInt32, UInt32, UInt32, UInt32) = self.state
        var t: UInt32 = s.3
        t ^= (t << 11)
        t ^= (t >> 8)
        s.3 = s.2
        s.2 = s.1
        s.1 = s.0
        s.0 = (s.0 ^ (s.0 >> 19)) ^ (t ^ (t >> 14))
        self.state = s
        return s.0
    }
}
