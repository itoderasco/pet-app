//
//  AuthManagerTests.swift
//  PetAppTests
//
//  Created by Ion Toderasco on 22.02.2024.
//

import XCTest
@testable import PetApp

class AuthManagerTests: XCTestCase {
    
    func test_init_doesNotRequestToken() {
        let (_, service) = makeSUT()
        XCTAssertEqual(service.requestCount, 0)
    }
    
    func test_getToken_whenMissing_requestsFromRemote() async {
        let (sut, service) = makeSUT()
        _ = try? await sut.validToken()
        
        XCTAssertEqual(service.requestCount, 1)
    }
    
    func test_getToken_failedRequest_deliversError() async {
        let (sut, service) = makeSUT()
        
        let error = NSError(domain: "test", code: 0)
        service.error = error
        
        var receivedToken: Token?
        var receivedError: NSError?
        
        do {
            receivedToken = try await sut.validToken()
        } catch {
            receivedError = error as NSError
        }
        
        XCTAssertNil(receivedToken)
        XCTAssertEqual(receivedError, error)
    }
    
    func test_getToken_successRequest_deliversValidToken() async {
        let (sut, service) = makeSUT()
        
        let token = Factory.makeToken(
            value: "token-1",
            date: Date(timeIntervalSince1970: 1)
        )
        service.result = token
        
        let receivedToken = try? await sut.validToken()
        
        XCTAssertEqual(receivedToken?.value, token.value)
        XCTAssertEqual(receivedToken?.validUntil, token.validUntil)
    }
    
    func test_getToken_multipleRequest_deliversSameToken() async {
        let (sut, service) = makeSUT()
        
        let token = Factory.makeToken(
            value: "token-1",
            date: Date(timeIntervalSince1970: 2)
        )
        service.result = token
        
        var receivedTokens = [Token]()
        
        for _ in 1...3 {
            if let receivedToken = try? await sut.validToken() {
                receivedTokens.append(receivedToken)
            }
        }
        
        XCTAssertEqual(receivedTokens.count, 3)
        
        XCTAssertEqual(receivedTokens[0].value, token.value)
        XCTAssertEqual(receivedTokens[1].value, token.value)
        XCTAssertEqual(receivedTokens[2].value, token.value)
        
        XCTAssertEqual(receivedTokens[0].validUntil, token.validUntil)
        XCTAssertEqual(receivedTokens[1].validUntil, token.validUntil)
        XCTAssertEqual(receivedTokens[2].validUntil, token.validUntil)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: AuthManager, service: MockedAuthService) {
        let service = MockedAuthService()
        let sut = AuthManager(service: service)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(service, file: file, line: line)
        
        return (sut, service)
    }
}
