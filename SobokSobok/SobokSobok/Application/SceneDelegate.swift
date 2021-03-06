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
        window?.rootViewController = UINavigationController(rootViewController: SplashView.instanceFromNib())
        let navigationController = window?.rootViewController as? UINavigationController
        navigationController?.isNavigationBarHidden = true
        self.window?.backgroundColor = Color.white
        window?.makeKeyAndVisible()
    }
}
