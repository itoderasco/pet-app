//
//  AnimalDTO.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

struct FeedPageDTO: Decodable {
    let animals: [AnimalDTO]
}

struct AnimalDTO: Decodable {
    let id: Int
    
    let name: String
    let age: String
    let gender: String
    let size: String
    let status: String
    
    let distance: Double?
    let coat: String?
    let description: String?
    
    let photos: [AnimalPhotoDTO]
    let contact: AnimalContactDTO
    
    let breeds: AnimalBreedDTO
    let colors: AnimalColorDTO
    let attributes: AnimalAttributesDTO
    let environment: AnimalEnvironmentDTO?
}

struct AnimalBreedDTO: Decodable {
    let primary: String
}

struct AnimalColorDTO: Decodable {
    let primary: String?
}

struct AnimalPhotoDTO: Decodable {
    let small: URL
    let medium: URL
    let large: URL
}

struct AnimalEnvironmentDTO: Decodable {
    let children: Bool?
    let dogs: Bool?
    let cats: Bool?
}

struct AnimalContactDTO: Decodable {
    let email: String?
    let phone: String?
    let address: Address
    
    struct Address: Decodable {
        let city: String
        let state: String
        let country: String
    }
}

struct AnimalAttributesDTO: Decodable {
    let spayedNeutered: Bool?
    let houseTrained: Bool?
    let declawed: Bool?
    let specialNeeds: Bool?
    let shotsCurrent: Bool?
    
    enum CodingKeys: String, CodingKey {
        case spayedNeutered = "spayed_neutered"
        case houseTrained = "house_trained"
        case declawed = "declawed"
        case specialNeeds = "special_needs"
        case shotsCurrent = "shots_current"
    }
}
