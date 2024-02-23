//
//  AnimalDetailsViewModelTests.swift
//  PetAppTests
//
//  Created by Ion Toderasco on 22.02.2024.
//

import XCTest
@testable import PetApp

class AnimalDetailsViewModelTests: XCTestCase {
    
    func test_displayedContent() {
        let smalURL = URL(string: "small-img.url")!
        let mediumURL = URL(string: "medium-img.url")!
        let largeURL = URL(string: "large-img.url")!
        
        let animal = Animal(
            id: 0,
            name: "Oreo",
            gender: "male",
            age: "adult",
            size: "medium",
            breed: "long hair",
            color: "gray",
            status: "adoptable",
            coat: "short",
            description: "Meet Oreo!",
            distance: nil,
            photo: .init(small: smalURL, medium: mediumURL, large: largeURL),
            contact: .init(address: "Huston, CA", email: nil, phone: "123-123"),
            attributes: [.houseTrained],
            environments: [.children]
        )
        
        let sut = makeSUT(animal: animal)
        
        XCTAssertEqual(sut.photoURL, largeURL)
        XCTAssertEqual(sut.petName, animal.name)
        XCTAssertEqual(sut.breed, "Long Hair")
        XCTAssertEqual(sut.description, animal.description)
        XCTAssertEqual(sut.address, animal.contact.address)
        XCTAssertEqual(sut.email, animal.contact.email)
        XCTAssertEqual(sut.phone, animal.contact.phone)
        XCTAssertEqual(sut.coat, "Short")
        XCTAssertEqual(sut.statusDetails, "Adoptable ・ N/A miles")
        XCTAssertEqual(sut.petDetails, "Adult ・ Male ・ Medium ・ Gray")
        XCTAssertEqual(sut.health, ".")
        XCTAssertEqual(sut.houseTrained, "Yes")
        XCTAssertEqual(sut.goodWith, "Children.")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(animal: Animal, file: StaticString = #filePath, line: UInt = #line) -> AnimalDetailsViewModel {
        let sut = AnimalDetailsViewModel(animal: animal)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
