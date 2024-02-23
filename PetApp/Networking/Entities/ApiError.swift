//
//  ApiError.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidBody
    case unauthorized
}
