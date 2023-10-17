//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2023/10/18.
//

import XCTest
@testable import SwiftID

final class RandStrTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

        for _ in 1...10000 {
            print(RandStr(length: 10).idString)
        }
    }
}
