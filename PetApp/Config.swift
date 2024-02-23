//
//  Config.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import Foundation

@dynamicMemberLookup
struct Config {
    
    let baseStringUrl = "https://api.petfinder.com/"
    
    let apiKey = "8FvB92COL3loJkRHBozGPLOVKZTG4CgXal6Dou6EjsH5lj2SXB"
    let apiSecret = "zcYSA3CrhG6yW1dc539o8rAVgj7ecwLUaYHTSe3s"
    
    /// Prevent outside construction
    private init() { }
    
    static subscript<T>(dynamicMember keyPath: KeyPath<Config, T>) -> T {
        Config()[keyPath: keyPath]
    }
}
