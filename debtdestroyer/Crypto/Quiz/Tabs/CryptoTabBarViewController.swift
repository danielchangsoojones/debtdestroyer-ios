//
//  CryptoTabBarViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit
import UXCam

class CryptoTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private var dataStore = QuizDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setTabs()
        tabBar.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UXCam.setUserIdentity(User.current()?.objectId ?? "")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    private func setTabs(){
        let vc1 = NewGameStartViewController()
        let vc2 = ChampionsViewController()
        let vc3 = AppleTesterViewController()
        
        let controllers: [UIViewController] = User.isAppleTester || User.isIpadDemo ? [vc3, vc2] : [vc1, vc2]
        
        self.viewControllers = controllers.map { CustomNavigationViewController(rootViewController: $0)}
        
        let tabQuiz = tabBar.items![0]
        tabQuiz.image = UIImage(named: "ticketG")?.withRenderingMode(.alwaysOriginal)
        tabQuiz.selectedImage = UIImage(named: "ticketC")?.withRenderingMode(.alwaysOriginal)
        
        let tabWinner = tabBar.items![1]
        tabWinner.image = UIImage(named: "GlobeG")?.withRenderingMode(.alwaysOriginal)
        tabWinner.selectedImage = UIImage(named: "GlobeC")?.withRenderingMode(.alwaysOriginal)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Haptics.shared.play(.medium)
    }
}
