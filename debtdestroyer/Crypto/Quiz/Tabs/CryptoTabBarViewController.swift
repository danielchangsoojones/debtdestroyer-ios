//
//  CryptoTabBarViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit

class CryptoTabBarViewController: UITabBarController {
    private var dataStore = QuizDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabs()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    private func setTabs(){
        let vc1 = NewGameStartViewController()
        let vc2 = PrizeViewController()
        let vc3 = ChampionsViewController()
        let vc4 = CryptoSettingsViewController()
        
        let controllers = [vc1,vc2,vc3,vc4]
        self.viewControllers = controllers.map { CustomNavigationViewController(rootViewController: $0)}
        
        let tabQuiz = tabBar.items![0]
        tabQuiz.image = UIImage(named: "ticketG")?.withRenderingMode(.alwaysOriginal)
        tabQuiz.selectedImage = UIImage(named: "ticketC")?.withRenderingMode(.alwaysOriginal)
        
        let tabLeadboard = tabBar.items![1]
        tabLeadboard.image = UIImage(named: "BulbG")?.withRenderingMode(.alwaysOriginal)
        tabLeadboard.selectedImage = UIImage(named: "BulbC")?.withRenderingMode(.alwaysOriginal)
        
        let tabWinner = tabBar.items![2]
        tabWinner.image = UIImage(named: "GlobeG")?.withRenderingMode(.alwaysOriginal)
        tabWinner.selectedImage = UIImage(named: "GlobeC")?.withRenderingMode(.alwaysOriginal)
        
        let tabSettings = tabBar.items![3]
        tabSettings.image = UIImage(named: "settingsG")?.withRenderingMode(.alwaysOriginal)
        tabSettings.selectedImage = UIImage(named: "settingsC")?.withRenderingMode(.alwaysOriginal)
        
        self.removeTab(at: 1)
    }
    
    private func checkHideReview() {
//        dataStore.shouldShowEarnings { shouldMakeEverythingVisible in
//            if !shouldMakeEverythingVisible {
//                //hiding from apple review the home page for now.
//                self.removeTab(at: 0)
//            }
//        }
    }
    
    private func removeTab(at index: Int) {
        if self.viewControllers?.count ?? 0 >= index {
            self.viewControllers?.remove(at: index)
        }
    }
}
