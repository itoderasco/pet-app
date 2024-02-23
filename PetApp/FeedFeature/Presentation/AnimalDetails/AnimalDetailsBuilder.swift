//
//  AnimalDetailsBuilder.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

final class AnimalDetailsBuilder {

    static func build(withModel animal: Animal) -> AnimalDetailsViewController {
        let viewModel = AnimalDetailsViewModel(animal: animal)
        return AnimalDetailsViewController(viewModel: viewModel)
    }
}
