import Foundation
import XCTest
@testable import SwiftEnvKit

final class EnvironmentTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        unsetenv("TEST_KEY")
        unsetenv("TEST_INT")
        unsetenv("TEST_BOOL")
    }

    func testLoadWithAndWithoutDefault() {
        setenv("TEST_KEY", "custom_value", 1)
        XCTAssertEqual(Environment.load("TEST_KEY"), "custom_value")
        XCTAssertEqual(Environment.load("TEST_KEY", default: "fallback"), "custom_value")

        unsetenv("TEST_KEY")
        XCTAssertNil(Environment.load("TEST_KEY"))
        XCTAssertEqual(Environment.load("TEST_KEY", default: "fallback"), "fallback")
    }

    func testRequireSuccess() throws {
        setenv("TEST_KEY", "required_val", 1)
        let value = try Environment.require("TEST_KEY")
        XCTAssertEqual(value, "required_val")
    }

    func testRequireThrowsMissing() {
        unsetenv("TEST_KEY")
        XCTAssertThrowsError(try Environment.require("TEST_KEY")) { error in
            XCTAssertEqual(error as? EnvironmentError, .missing("TEST_KEY"))
        }
    }

    func testCoerceTypes() throws {
        setenv("TEST_INT", "42", 1)
        XCTAssertEqual(try Environment.loadInt("TEST_INT"), 42)

        setenv("TEST_INT", "not_int", 1)
        XCTAssertThrowsError(try Environment.loadInt("TEST_INT")) { error in
            XCTAssertEqual(error as? EnvironmentError, .invalidType(key: "TEST_INT", expected: "Int"))
        }

        setenv("TEST_BOOL", "true", 1)
        XCTAssertEqual(try Environment.loadBool("TEST_BOOL"), true)
    }
}
