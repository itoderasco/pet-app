//
//  NetworkService.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

protocol NetworkService {
    func getRequest<T: Decodable>(endpoint: BaseEndpoint) async throws -> T
}

final class MainNetworkService: NetworkService {
    
    private let baseStringUrl: String
    private let authManager: AuthManager
    
    init(baseStringUrl: String, authManager: AuthManager) {
        self.baseStringUrl = baseStringUrl
        self.authManager = authManager
    }
    
    func getRequest<T: Decodable>(endpoint: BaseEndpoint) async throws -> T {
        guard let url = URL(string: baseStringUrl + endpoint.path) else {
            throw ApiError.invalidURL
        }
        let urlRequest = try await authorizedURLRequest(for: url)
        return try await performRequest(urlRequest)
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest, retryOnFail: Bool = true) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if response.isStatusCode(401) {
            if retryOnFail {
                _ = try await authManager.validToken()
                return try await performRequest(request, retryOnFail: false)
            }
            throw ApiError.unauthorized
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func authorizedURLRequest(for url: URL) async throws -> URLRequest {
        let token = try await authManager.validToken()
        var request = URLRequest(url: url)
        request.setValue(token.value, forHTTPHeaderField: "Authorization")
        return request
    }
}

fileprivate extension URLResponse {
    
    func isStatusCode(_ code: Int) -> Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }
        return response.statusCode == code
    }
}
