//
//  SceneDelegate.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let launch = LaunchViewController()   
        
        let navigationController = UINavigationController(rootViewController: launch)
        _ = KeyChainProvider()
        
        let coreDataManager = CoreDataManager(moc: CoreDataStack.shared.persistentContainer.viewContext)
        launch.viewModel = LaunchViewModel(apiProvider: ApiProvider(),
                                           keyChainProvider: KeyChainProvider(),
                                           coreDataManager:  coreDataManager)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}

