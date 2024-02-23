//
//  AnimalFeedViewModelTests.swift
//  PetAppTests
//
//  Created by Ion Toderasco on 22.02.2024.
//

import XCTest
@testable import PetApp

import RxSwift
import RxCocoa

class AnimalFeedViewModelTests: XCTestCase {
    
    func test_init_doesNotRequestData() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(sut.viewState.value, .idle)
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, repository) = makeSUT()
        repository.error = NSError(domain: "test", code: 0)
        expect(finalState: .failed, sut: sut)
    }
    
    func test_RequestData() {
        let (sut, repository) = makeSUT()
        
        let animals = [Factory.makeAnimal(id: 0)]
        repository.result = animals
        
        expect(finalState: .loaded, sut: sut)
        
        XCTAssertEqual(sut.feedItems.value.count, animals.count)
        XCTAssertEqual(sut.feedItems.value.first?.id, animals.first?.id)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: AnimalFeedViewModel, repository: MockedAnimalRepository) {
        let repository = MockedAnimalRepository()
        let sut = AnimalFeedViewModel(repository: repository)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)
        
        return (sut, repository)
    }
    
    private func expect(finalState: AnimalFeedViewModel.State, sut: AnimalFeedViewModel, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "wait for load completion")
        sut.fetchFeedItems()
        XCTAssertEqual(sut.viewState.value, .loading)
        
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(sut.viewState.value, finalState)
    }
}

class MockedAnimalRepository: AnimalRepository {
    
    var result: [Animal] = []
    var error: Error?
    
    func getAnimals() async throws -> [Animal] {
        if let error {
            throw error
        }
        return result
    }
}
