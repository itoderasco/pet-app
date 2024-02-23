//
//  AnimalFeedBuilder.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

protocol AnimalFeedRouting: AnyObject {
    func routeToAnimalDetails(_ animal: Animal)
}

final class AnimalFeedBuilder {
    
    static func build(withNetworkService network: NetworkService, router: AnimalFeedRouting) -> AnimalFeedViewController {
        let repository = FeedRepository(network: network)
        let viewModel = AnimalFeedViewModel(repository: repository)
        viewModel.router = router
        
        return AnimalFeedViewController(viewModel: viewModel)
    }
}
