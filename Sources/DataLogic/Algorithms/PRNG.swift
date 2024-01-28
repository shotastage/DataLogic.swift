//
//  PRNG.swift
//
//
//  Created by Shota Shimazu on 2023/10/25.
//

import Foundation

public struct PRNG {
    func xorshift() {
        //
    }
}

struct Xorshift {
    private var state: UInt32

    init(seed: UInt32) {
        state = seed
    }

    mutating func random() -> UInt32 {
        var x = state
        x ^= (x << 13)
        x ^= (x >> 17)
        x ^= (x << 5)
        state = x
        return x
    }
}
