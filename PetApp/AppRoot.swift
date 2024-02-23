//
//  AppRoot.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit

final class AppRoot {
    
    private let window: UIWindow
    
    private let authManager: AuthManager
    private let navigation: UINavigationController
    
    private enum Feature {
        case feed
    }
    private var childs = [Feature: AnyObject]()
    
    init(window: UIWindow) {
        self.window = window
        authManager = AuthManagerBuilder.build()
        navigation = UINavigationController()
    }
    
    func start() {
        let service = MainNetworkService(
            baseStringUrl: Config.baseStringUrl,
            authManager: authManager
        )
        
        let feed = FeedRoot(networkService: service, navigation: navigation)
        childs[.feed] = feed
        
        feed.start()
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

final class AuthManagerBuilder {
    
    static func build() -> AuthManager {
        let authConfig = AuthConfig(
            baseStringUrl: Config.baseStringUrl,
            clientId: Config.apiKey,
            clientSecret: Config.apiSecret
        )
        let authService = MainAuthService(config: authConfig)
        
        return AuthManager(service: authService)
    }
}
