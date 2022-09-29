//
//  CryptoTabBarViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit

class CryptoTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        self.delegate = self
        setTabs()
    }
    
    private func setTabs(){
        let vc1 = StartQuizNewUIViewController()
        let vc2 = CryptoSettingsViewController()
        
        let controllers = [vc1,vc2]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        let tabQuiz = tabBar.items![0]
        tabQuiz.image = UIImage(named: "quizB")?.withRenderingMode(.alwaysOriginal)
        tabQuiz.selectedImage = UIImage(named: "quizC")?.withRenderingMode(.alwaysOriginal)
        
        let tabSettings = tabBar.items![1]
        tabSettings.image = UIImage(named: "settingsBW")?.withRenderingMode(.alwaysOriginal)
        tabSettings.selectedImage = UIImage(named: "settingsC")?.withRenderingMode(.alwaysOriginal)
    }
}

extension CryptoTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
