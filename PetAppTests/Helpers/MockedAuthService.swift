//
//  MockedAuthService.swift
//  PetAppTests
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation
@testable import PetApp

class MockedAuthService: AuthService {
    
    var result = Token(value: "", validUntil: .now)
    var error: Error?
    
    var requestCount = 0
    
    func getAuthToken() async throws -> Token {
        requestCount += 1
        
        if let error {
            throw error
        }
        
        return result
    }
}
