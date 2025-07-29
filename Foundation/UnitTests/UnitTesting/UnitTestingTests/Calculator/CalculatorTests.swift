//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let result = try calculator.divide(10.0, 2.0)
        XCTAssertEqual(5.0, result, accuracy: 0.001)
        
        let result2 = try calculator.divide(15.5, 3.1)
        XCTAssertEqual(5.0, result2, accuracy: 0.001)
    }
    
    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(10.0, 0.0)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, Calculator.CalculatorError.divisionByZero)
        }
    }
    
    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        // Test number less than 10
        XCTAssertFalse(calculator.isGreaterThanTen(5))
        XCTAssertFalse(calculator.isGreaterThanTen(0))
        XCTAssertFalse(calculator.isGreaterThanTen(-5))
        
        // Test number equal to 10
        XCTAssertFalse(calculator.isGreaterThanTen(10))
        
        // Test number greater than 10
        XCTAssertTrue(calculator.isGreaterThanTen(15))
        XCTAssertTrue(calculator.isGreaterThanTen(11))
        XCTAssertTrue(calculator.isGreaterThanTen(100))
    }
    
    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let result1 = calculator.safeSquareRoot(25.0)
        XCTAssertNotNil(result1)
        XCTAssertEqual(result1!, 5.0, accuracy: 0.001)
        
        let result2 = calculator.safeSquareRoot(0.0)
        XCTAssertNotNil(result2)
        XCTAssertEqual(result2!, 0.0, accuracy: 0.001)
        
        let result3 = calculator.safeSquareRoot(16.0)
        XCTAssertNotNil(result3)
        XCTAssertEqual(result3!, 4.0, accuracy: 0.001)
    }
    
    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let result1 = calculator.safeSquareRoot(-1.0)
        XCTAssertNil(result1)
        
        let result2 = calculator.safeSquareRoot(-25.0)
        XCTAssertNil(result2)
        
        let result3 = calculator.safeSquareRoot(-0.1)
        XCTAssertNil(result3)
    }
}
