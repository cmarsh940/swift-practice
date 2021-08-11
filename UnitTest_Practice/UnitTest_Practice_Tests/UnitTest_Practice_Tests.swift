//
//  UnitTest_Practice_Tests.swift
//  UnitTest_Practice_Tests
//
//  Created by Cam on 8/11/21.
//

@testable import UnitTest_Practice
import XCTest

class UnitTest_Practice_Tests: XCTestCase {
    
    var validationService: ValidationService!

    override func setUpWithError() throws {
        super.setUp()
        validationService = ValidationService()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        validationService = nil
    }

    func test_is_valid_username() throws {
        XCTAssertNoThrow(try validationService.validate(username: "cookieLife"))
    }
    
    func test_is_username_empty() throws {
        let expectedError = ValidationError.usernameEmpty
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validate(username: "")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_not_long_enough() throws {
        let expectedError = ValidationError.usernameToShort
        var error: ValidationError?
        XCTAssertThrowsError(try validationService.validate(username: "um")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_to_long() throws {
            let expectedError = ValidationError.usernameToLong
            var error: ValidationError?
            XCTAssertThrowsError(try validationService.validate(username: "cookieMonsterLovesHisCookies")) { thrownError in
                error = thrownError as? ValidationError
            }
            
            XCTAssertEqual(expectedError, error)
            XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
        }
        
        // MARK: Testing password validation
        func test_is_valid_password() throws {
            XCTAssertNoThrow(try validationService.validate(password: "cookieLife123"))
        }
        
        
        func test_password_is_empty() throws {
            let expectedError = ValidationError.passwordEmpty
            var error: ValidationError?
            
            XCTAssertThrowsError(try validationService.validate(password: "")) { thrownError in
                error = thrownError as? ValidationError
            }
            
            XCTAssertEqual(expectedError, error)
            XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
        }
        
        
        func test_password_not_long_enough() throws {
            let expectedError = ValidationError.passwordToShort
            var error: ValidationError?
            XCTAssertThrowsError(try validationService.validate(password: "yum")) { thrownError in
                error = thrownError as? ValidationError
            }
            
            XCTAssertEqual(expectedError, error)
            XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
        }
        
        
        func test_password_to_long() throws {
            let expectedError = ValidationError.passwordToLong
            var error: ValidationError?
            XCTAssertThrowsError(try validationService.validate(password: "cookieMonsterLovesHisCookies")) { thrownError in
                error = thrownError as? ValidationError
            }
            
            XCTAssertEqual(expectedError, error)
            XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
        }

}
