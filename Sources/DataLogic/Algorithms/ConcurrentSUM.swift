//
//  ConcurrentSUM.swift
//
//
//  Created by Shota Shimazu on 2024/02/02.
//

import Foundation

public struct ConcurrentSUM: LogicProcedure {
    typealias Input = [Double]
    typealias Output = Double

    var input: Input?
    var value: Output

    init(input: Input) {
        self.input = input
        value = 0.0
    }

    mutating func execute() -> Output? {
        // If input is nil
        guard let numbers = input else { return nil }

        // If input is empty
        guard !numbers.isEmpty else { return 0.0 }

        // Decide how many chunks to use (based on number of available processors and array length)
        let processorCount = ProcessInfo.processInfo.activeProcessorCount
        let chunkSize = max(1, numbers.count / processorCount)
        let chunks = numbers.count / chunkSize + (numbers.count % chunkSize > 0 ? 1 : 0)

        var partialSums = [Double](repeating: 0.0, count: chunks)

        DispatchQueue.concurrentPerform(iterations: chunks) { index in
            let start = index * chunkSize
            let end = min(start + chunkSize, numbers.count)
            let chunkRange = start ..< end
            let chunkSum = numbers[chunkRange].reduce(0.0, +)
            partialSums[index] = chunkSum
        }

        // Aggregate partial totals
        return partialSums.reduce(0.0, +)
    }
}
