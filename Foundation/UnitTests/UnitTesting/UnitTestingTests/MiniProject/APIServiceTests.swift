//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let expectation = expectation(description: "fetchUsers completion")
        
        sut.fetchUsers(urlString: "") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, APIError.invalidUrl)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
            [
                { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
                { "id": 2, "name": "Jane Doe", "username": "janedoe", "email": "janedoe@gmail.com" }
            ]
            """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let expectation = expectation(description: "fetchUsers completion")
        
        let expectedUsers = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@gmail.com"),
            User(id: 2, name: "Jane Doe", username: "janedoe", email: "janedoe@gmail.com")
        ]
        
        sut.fetchUsers(urlString: "https://valid-url.com") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, expectedUsers.count)
                XCTAssertEqual(users[0].id, expectedUsers[0].id)
                XCTAssertEqual(users[0].name, expectedUsers[0].name)
                XCTAssertEqual(users[1].id, expectedUsers[1].id)
                XCTAssertEqual(users[1].name, expectedUsers[1].name)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let invalidResponse = "invalid json".data(using: .utf8)
        mockURLSession.mockData = invalidResponse
        
        let sut = makeSut()
        let expectation = expectation(description: "fetchUsers completion")
        
        sut.fetchUsers(urlString: "https://valid-url.com") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, APIError.parsingError)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        mockURLSession.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        let sut = makeSut()
        let expectation = expectation(description: "fetchUsers completion")
        
        sut.fetchUsers(urlString: "https://valid-url.com") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, APIError.unexpected)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: Fetch Users Async
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "")
        
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, APIError.invalidUrl)
        }
    }
    
    // add other tests for fetchUsersAsync
    func test_apiService_fetchUsersAsync_whenValidSuccessfulResponse_completesWithSuccess() async {
        let response = """
            [
                { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
            ]
            """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://valid-url.com")
        
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users[0].name, "John Doe")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
