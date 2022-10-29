//
//  SceneDelegate.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(
            rootViewController: HomeTableViewController.instance()
        )
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .white
    }
}

