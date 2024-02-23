//
//  AuthService.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

protocol AuthService {
    func getAuthToken() async throws -> Token
}

final class MainAuthService: AuthService {

    private let config: AuthConfig
    
    init(config: AuthConfig) {
        self.config = config
    }
    
    func getAuthToken() async throws -> Token {
        guard let url = URL(string: config.baseStringUrl + "v2/oauth2/token") else {
            throw ApiError.invalidURL
        }
        
        var bodyComponents = URLComponents()
        bodyComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "client_credentials"),
            URLQueryItem(name: "client_id", value: config.clientId),
            URLQueryItem(name: "client_secret", value: config.clientSecret)
        ]

        guard let httpBody = bodyComponents.query?.data(using: .utf8) else {
            throw ApiError.invalidBody
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let dtoToken = try JSONDecoder().decode(TokenDTO.self, from: data)
            return dtoToken.map()
        } catch {
            throw error
        }
    }
}
