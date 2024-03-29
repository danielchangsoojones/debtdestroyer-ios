//
//  RoundUpTabBarViewController.swift
//  nbawidget
//
//  Created by Rashmi Aher on 01/08/22.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        self.delegate = self
        setTabs()
    }
    
    private func setTabs(){
        let vc1 = PrizeViewController()
        let vc2 = BankViewController()//RoundUpViewController()
        let vc3 = SettingsViewController()
     
        let controllers = [vc1,vc2,vc3]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        let tabTickets = tabBar.items![0]
        tabTickets.image = UIImage(named: "ticketG")?.withRenderingMode(.alwaysOriginal)
        tabTickets.selectedImage = UIImage(named: "ticketC")?.withRenderingMode(.alwaysOriginal)
        
        let tabBank = tabBar.items![1]
        tabBank.image = UIImage(named: "bankG")?.withRenderingMode(.alwaysOriginal)
        tabBank.selectedImage = UIImage(named: "bankC")?.withRenderingMode(.alwaysOriginal)
        
        let tabSettings = tabBar.items![2]
        tabSettings.image = UIImage(named: "settingsG")?.withRenderingMode(.alwaysOriginal)
        tabSettings.selectedImage = UIImage(named: "settingsC")?.withRenderingMode(.alwaysOriginal)
    }
}

extension HomeTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
