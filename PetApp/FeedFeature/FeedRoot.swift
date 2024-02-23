//
//  FeedRoot.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit

final class FeedRoot {
    
    private let networkService: NetworkService
    
    private let navigation: UINavigationController
    
    init(networkService: NetworkService, navigation: UINavigationController) {
        self.networkService = networkService
        self.navigation = navigation
    }
    
    func start() {
        let feedController = AnimalFeedBuilder.build(withNetworkService: networkService, router: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(feedController, animated: false)
    }
}

extension FeedRoot: AnimalFeedRouting {
    
    func routeToAnimalDetails(_ animal: Animal) {
        let detailsController = AnimalDetailsBuilder.build(withModel: animal)
        navigation.pushViewController(detailsController, animated: true)
    }
}
