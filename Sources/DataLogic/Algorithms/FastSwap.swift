//
//  FastSwap.swift
//
//
//  Created by Shota Shimazu on 2024/02/21.
//

import Foundation

// Fast Swap is a value swapping mechanism based on the XOR swap algorithm. This method allows the swapping of two variables without using a temporary variable.
struct FastSwap {
    var swapFrom: UInt64
    var swapTo: UInt64

    mutating func execute() {
        swapFrom = swapFrom ^ swapTo
        swapTo = swapFrom ^ swapTo
        swapFrom = swapFrom ^ swapTo
    }
}
