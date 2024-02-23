//
//  AnimalRepository.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

protocol AnimalRepository {
    func getAnimals() async throws -> [Animal]
}
