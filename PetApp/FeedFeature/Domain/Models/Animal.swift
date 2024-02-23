//
//  Animal.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

struct Animal {
    let id: Int
    
    let name: String
    let gender: String
    let age: String
    let size: String
    let breed: String
    let color: String
    let status: String
    let coat: String?
    let description: String?
    let distance: Double?
    
    let photo: Photo?
    let contact: Contact
    
    let attributes: [Attribute]
    
    let environments: [Environment]
    
    // MARK: - Embeds
    
    struct Contact {
        let address: String
        let email: String?
        let phone: String?
    }
    
    struct Photo {
        let small: URL
        let medium: URL
        let large: URL
    }
    
    enum Attribute: String {
        case spayedNeutered = "spayed / neutered"
        case houseTrained
        case declawed = "declawed"
        case specialNeeds = "special needs"
        case shotsCurrent = "vaccinations up to date"
    }
    
    enum Environment: String {
        case children
        case dogs
        case cats
        case unknown = "N/A"
    }
}
