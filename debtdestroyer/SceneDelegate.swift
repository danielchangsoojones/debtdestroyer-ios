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
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func setStartingVC(windowScene: UIScene) {
//        if User.current() == nil {
//            let welcomeVC = WelcomeViewController()
//            let navController = UINavigationController(rootViewController: welcomeVC)
//            set(windowScene: windowScene, startingVC: navController)
//        } else {
//            let vc = HomeTabBarViewController()
//            set(windowScene: windowScene, startingVC: vc)
//        }
        
        let quizDataParse = QuizDataParse()
        let topic = QuizTopicParse()
        topic.name = "Nano"
        topic.ticker = "XNO"
        quizDataParse.quizTopic = topic
        quizDataParse.question = "Transaction fee is zero that means if you send 1 nano counter party will receive exactly 1 nano not more or less"
        let quizVC = LearnViewController(quizDatas: [quizDataParse, quizDataParse], currentIndex: 0)
        let navController = UINavigationController(rootViewController: quizVC)
        set(windowScene: windowScene, startingVC: navController)
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

