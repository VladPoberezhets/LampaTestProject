//
//  SceneDelegate.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var appCoordinator: ApplicationCoordinator = self.makeCoordinator()
    
    private func makeCoordinator() -> ApplicationCoordinator {
        return ApplicationCoordinator(
            router: Router(rootController: UINavigationController()),
            with: ApplicationCoordinatorFactory()
        )
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = appCoordinator.tabBarVC
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


}

