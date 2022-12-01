//
//  SceneDelegate.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 8/3/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        setStartingVC(windowScene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "StartQuizLoadData"), object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }

    private func setStartingVC(windowScene: UIScene) {
        if User.current() == nil {
            let welcomeVC = WelcomeViewController()
            let navController = UINavigationController(rootViewController: welcomeVC)
            set(windowScene: windowScene, startingVC: navController)
        } else {
            let vc = CryptoTabBarViewController()
            set(windowScene: windowScene, startingVC: vc)
        }
    }

    private func set(windowScene: UIScene, startingVC: UIViewController) {
        if let windowScene = windowScene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = startingVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    
}

