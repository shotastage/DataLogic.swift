//
//  RandStrTests.swift
//
//
//  Created by Shota Shimazu on 2023/10/18.
//

@testable import DataLogic
import XCTest

final class RandStrTests: XCTestCase {
    func testGenerateFullRandStr() throws {
        for _ in 1 ... 1_000_000 {
            print(RandStr(length: 20, conditions: [.alphabetic, .numeric, .symbolic]).idString)
        }
    }
}
