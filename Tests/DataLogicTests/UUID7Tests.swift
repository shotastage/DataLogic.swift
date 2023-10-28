import XCTest
@testable import DataLogic

final class UUID7Tests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

        for _ in 1...10000 {
            let uuidParts = UUID7().uuidString

            print(uuidParts)
        }
    }
}
