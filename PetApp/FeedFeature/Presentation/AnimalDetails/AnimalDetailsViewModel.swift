//
//  AnimalDetailsViewModel.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

final class AnimalDetailsViewModel {
    
    private let animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    var photoURL: URL? { animal.photo?.large }
    
    var petName: String { animal.name }
    
    var breed: String { animal.breed.capitalized }
    
    var description: String? { animal.description }
    
    var address: String { animal.contact.address }
    
    var email: String? { animal.contact.email }
    
    var phone: String? { animal.contact.phone }
    
    var coat: String { animal.coat?.capitalized ?? "N/A" }
    
    var statusDetails: String {
        animal.status.capitalized + " ・ " + distance.appending(" miles")
    }
    
    private var distance: String {
        if let d = animal.distance {
            return String(d)
        }
        return "N/A"
    }
    
    var petDetails: String {
        let attributes = [
            animal.age,
            animal.gender,
            animal.size,
            animal.color
        ]
        
        return attributes
            .map { $0.capitalized }
            .joined(separator: " ・ ")
    }
    
    var health: String {
        animal.attributes
            .filter { $0 != .houseTrained }
            .map { $0.rawValue }
            .joined(separator: ", ")
            .appending(".")
            .capitalized
    }
    
    var houseTrained: String {
        animal.attributes.contains(where: { $0 == .houseTrained }) ? "Yes" : "No"
    }
    
    var goodWith: String {
        animal.environments
            .map { $0.rawValue }
            .joined(separator: ", ")
            .appending(".")
            .capitalized
    }
}
