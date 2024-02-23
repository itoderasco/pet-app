//
//  SceneDelegate.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var root: AppRoot?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        windowScene.delegate = self
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        root = AppRoot(window: window)
        root?.start()
    }
}
