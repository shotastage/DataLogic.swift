//
//  RandStrTests.swift
//
//
//  Created by Shota Shimazu on 2023/10/18.
//

import XCTest
@testable import DataLogic

final class RandStrTests: XCTestCase {
    func testGenerateFullRandStr() throws {
        for _ in 1...1000000 {
            print(RandStr(length: 20, conditions: [.alphabetic, .numeric, .symbolic]).idString)
        }
    }
}
