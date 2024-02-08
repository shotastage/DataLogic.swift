//
//  FastPseudorandom.swift
//
//
//  Created by Shota Shimazu on 2023/10/21.
//

import Foundation

public struct NewFastRand {
    
}

struct Xorshift64 {
    private var state: UInt64
}


struct Xorshift {
    private var state: UInt32

    init(seed: UInt32) {
        self.state = seed
    }

    mutating func random() -> UInt32 {
        var x = self.state
        x ^= (x << 13)
        x ^= (x >> 17)
        x ^= (x << 5)
        self.state = x
        return x
    }
}
