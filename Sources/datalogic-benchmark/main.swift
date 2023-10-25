//
//  main.swift
//
//
//  Created by Shota Shimazu on 2023/10/25.
//

import Benchmark

let N = 10000
var stringWithNoCapacity: String = ""
var stringWithReservedCapacity: String = ""



benchmark("Random Text Generation") {
    let randomText = (0..<N).map { _ in
        String((0..<10).map { _ in
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
        })
    }.joined()
    precondition(randomText.count == N * 10)
}

Benchmark.main()

guard stringWithNoCapacity == stringWithReservedCapacity else {
  fatalError("Unexpected Result.")
}
