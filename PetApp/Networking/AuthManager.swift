//
//  AuthManager.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

actor AuthManager {
    
    private let service: AuthService
    
    private var authToken: Token?
    private var refreshTask: Task<Token, Error>?
    
    init(service: AuthService) {
        self.service = service
    }

    ///
    /// Returns a valid `Token`.
    /// Can `throw` during refresh token request.
    ///
    func validToken() async throws -> Token {
        if let refreshTask {
            /// Refresh token operation is in progress. Await the value.
            return try await refreshTask.value
        }
        
        guard let authToken else {
            /// Request new token if token is missing.
            return try await refreshToken()
        }
        
        if authToken.isValid {
            return authToken
        }
        
        /// Request new token if existed token is expired.
        return try await refreshToken()
    }
    
    private func refreshToken() async throws -> Token {
        if let refreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> Token in
            defer {
                refreshTask = nil
            }
            return try await service.getAuthToken()
        }
        refreshTask = task
        
        return try await task.value
    }
}
