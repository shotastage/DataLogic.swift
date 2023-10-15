import XCTest
@testable import UUIDv7

final class UUIDv7Tests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        
        // Example usage:
        let uuidParts = UUID7()
        
        print(uuidParts.getStr())
    }
}
