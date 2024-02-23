//
//  AnimalFactory.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

final class AnimalFactory {
    
    static func transform(dto: AnimalDTO) -> Animal {
        let photo = mapAnimalPhoto(from: dto.photos.first)
        let contact = mapAnimalContact(from: dto.contact)
        let attributes = mapAnimalAttributes(from: dto.attributes)
        let environment = mapAnimalEnvironments(from: dto.environment)
        
        return .init(
            id: dto.id,
            name: dto.name,
            gender: dto.gender,
            age: dto.age,
            size: dto.size,
            breed: dto.breeds.primary,
            color: dto.colors.primary ?? "N/A",
            status: dto.status,
            coat: dto.coat,
            description: dto.description,
            distance: dto.distance,
            photo: photo,
            contact: contact,
            attributes: attributes,
            environments: environment
        )
    }
    
    private static func mapAnimalPhoto(from dto: AnimalPhotoDTO?) -> Animal.Photo? {
        guard let dto else {
            return nil
        }
        return .init(
            small: dto.small,
            medium: dto.medium,
            large: dto.large
        )
    }
    
    private static func mapAnimalContact(from dto: AnimalContactDTO) -> Animal.Contact {
        let address = String(format: "%@, %@, %@", dto.address.city, dto.address.state, dto.address.country)
        
        return .init(
            address: address,
            email: dto.email,
            phone: dto.phone
        )
    }
    
    private static func mapAnimalAttributes(from dto: AnimalAttributesDTO) -> [Animal.Attribute] {
        var result: [Animal.Attribute] = []
        
        if let flag = dto.spayedNeutered, flag {
            result.append(.spayedNeutered)
        }
        
        if let flag = dto.houseTrained, flag {
            result.append(.houseTrained)
        }
        
        if let flag = dto.declawed, flag {
            result.append(.declawed)
        }
        
        if let flag = dto.specialNeeds, flag {
            result.append(.specialNeeds)
        }
        
        if let flag = dto.shotsCurrent, flag {
            result.append(.shotsCurrent)
        }
        
        return result
    }
    
    private static func mapAnimalEnvironments(from dto: AnimalEnvironmentDTO?) -> [Animal.Environment] {
        guard let dto else {
            return [.unknown]
        }
        
        var result: [Animal.Environment] = []
        
        if let flag = dto.children, flag {
            result.append(.children)
        }
        
        if let flag = dto.dogs, flag {
            result.append(.dogs)
        }
        
        if let flag = dto.cats, flag {
            result.append(.cats)
        }
        
        return result
    }
}
