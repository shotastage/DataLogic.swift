//
//  main.swift
//
//
//  Created by Shota Shimazu on 2023/10/25.
//

import Benchmark
import DataLogic

let N = 10000
var stringWithNoCapacity: String = ""
var stringWithReservedCapacity: String = ""

benchmark("Random Text Generation") {
    for _ in 1 ... 10000 {
        let rand = RandStr(length: 20, conditions: [.alphabetic, .numeric, .symbolic]).idString

        print(rand)
    }
}

Benchmark.main()

guard stringWithNoCapacity == stringWithReservedCapacity else {
    fatalError("Unexpected Result.")
}
