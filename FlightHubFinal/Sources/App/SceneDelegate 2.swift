//
//  SceneDelegate.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let builder = ModuleFactory()
        let router = Router(navigationController: navigationController, assemblyBuilder: builder)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        let apiKey = "0d267fa0-8092-49a1-ac4a-845de4d64905"
        saveAPIKeyToKeychain(apiKey: apiKey)
    }
}
