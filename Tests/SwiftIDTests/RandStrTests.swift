//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2023/10/18.
//

import XCTest
@testable import SwiftID

final class RandStrTests: XCTestCase {
    func testGenerateCommonRandStr() throws {
        for _ in 1...1000 {
            print(RandStr(length: 10).idString)
        }
    }
    
    func testGenerateFullRandStr() throws {
        for _ in 1...1000 {
            print(RandStr(length: 20, conditions: [.alphabetic, .numeric, .symbolic]).idString)
        }
    }
}
