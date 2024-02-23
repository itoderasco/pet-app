//
//  Endpoint.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

struct Endpoint {
    static let feed = FeedEndpoint()
}

struct FeedEndpoint: BaseEndpoint {
    let path: String = "v2/animals"
}
