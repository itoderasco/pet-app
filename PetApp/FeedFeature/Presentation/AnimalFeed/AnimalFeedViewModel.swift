//
//  AnimalFeedViewModel.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

final class AnimalFeedViewModel {

    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    let viewState = BehaviorRelay<State>(value: .idle)
    let feedItems = BehaviorRelay<[Animal]>(value: [])
    
    weak var router: AnimalFeedRouting?
    
    private let repository: AnimalRepository
    
    init(repository: AnimalRepository) {
        self.repository = repository
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.item < feedItems.value.count else {
            return
        }
        let animal = feedItems.value[indexPath.item]
        router?.routeToAnimalDetails(animal)
    }
    
    func fetchFeedItems() {
        viewState.accept(.loading)
        
        Task {
            do {
                let animals = try await repository.getAnimals()
                feedItems.accept(animals)
                viewState.accept(.loaded)
            } catch {
                viewState.accept(.failed)
            }
        }
    }
}
