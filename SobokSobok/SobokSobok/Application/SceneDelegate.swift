//
//  SceneDelegate.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = UINavigationController(rootViewController: SplashViewController.instanceFromNib())
        window?.makeKeyAndVisible()
    }
}

