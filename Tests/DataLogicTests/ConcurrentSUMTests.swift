//
//  ConcurrentSUMTests.swift
//
//
//  Created by Shota Shimazu on 2024/02/02.
//

@testable import DataLogic
import XCTest

final class ConcurrentSUMTests: XCTestCase {

    func testBasicConccurentSumFunctionality() throws {
        let numbers = [
            0.533,
            1.049,
            5.121,
            0.331,
            4.902,
            5.909,
        ]

        for _ in 1 ... 100 {
            var calculator = ConcurrentSUM(input: numbers)
            let res = calculator.execute()
            print("Result: \(String(describing: res))")
        }
    }

    func testConcurrentSum() throws {
        let numbers = [Double](repeating: 1.0, count: 100_000_0)

        var calculator = ConcurrentSUM(input: numbers)
        _ = calculator.execute()
        print("Result: \(String(describing: calculator.value))")
    }
}
