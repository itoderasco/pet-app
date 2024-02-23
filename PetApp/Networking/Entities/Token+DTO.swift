//
//  Token+DTO.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

struct Token {
    let value: String
    let validUntil: Date
    
    var isValid: Bool { validUntil > .now }
}

struct TokenDTO: Decodable {
    let tokenType: String
    let tokenValue: String
    let lifespanInSeconds: Int
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case tokenValue = "access_token"
        case lifespanInSeconds = "expires_in"
    }
}

extension TokenDTO {
    
    func map() -> Token {
        let value = String(format: "%@ %@", tokenType, tokenValue)
        
        let lifespan = Calendar.current.date(byAdding: .second, value: lifespanInSeconds, to: .now)
        let deadline = lifespan ?? Date.tenMinutes
        
        return Token(value: value, validUntil: deadline)
    }
}

fileprivate extension Date {
    
    static var tenMinutes: Date {
        let seconds: TimeInterval = 600
        let ref = Date().timeIntervalSinceReferenceDate + seconds
        return Date(timeIntervalSinceReferenceDate: ref)
    }
}
