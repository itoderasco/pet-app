//
//  FeedRepository.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

final class FeedRepository: AnimalRepository {
    
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getAnimals() async throws -> [Animal] {
        let response: FeedPageDTO = try await network.getRequest(endpoint: Endpoint.feed)
        return response.animals.map(AnimalFactory.transform)
    }
}
