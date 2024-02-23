//
//  Factory.swift
//  PetAppTests
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation
@testable import PetApp

final class Factory {
    
    static func makeAnimal(id: Int) -> Animal {
        return .init(
            id: id,
            name: "name_\(id)",
            gender: "-",
            age: "1",
            size: "Big",
            breed: "Short Hair",
            color: "Brown",
            status: "Status",
            coat: nil,
            description: nil,
            distance: nil,
            photo: nil,
            contact: .init(address: "Address", email: nil, phone: nil),
            attributes: [.houseTrained],
            environments: [.children]
        )
    }
    
    static func makeToken(value: String, date: Date) -> Token {
        return Token(value: value, validUntil: date)
    }
}
