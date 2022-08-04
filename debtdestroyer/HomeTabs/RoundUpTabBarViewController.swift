//
//  RoundUpTabBarViewController.swift
//  nbawidget
//
//  Created by Rashmi Aher on 01/08/22.
//

import UIKit

class RoundUpTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .black
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        self.delegate = self
        setTabs()
        
    }
    
    
    private func setTabs(){
        let vc1 = RoundUpViewController()//TicketsViewController()
        let tickets = UINavigationController(rootViewController: vc1)
        tickets.setNavigationBarHidden(true, animated: false)
        
        let vc2 = BankViewController()
        let bank = UINavigationController(rootViewController: vc2)
        bank.setNavigationBarHidden(true, animated: false)
        
        let vc3 = SettingsViewController()
        let settings = UINavigationController(rootViewController: vc3)
        settings.setNavigationBarHidden(true, animated: false)

        let controllers = [tickets,bank,settings]
        self.viewControllers = controllers

        let tabTickets = tabBar.items![0]
        tabTickets.title = "Tickets" // tabbar titlee
//        tabTickets.image=UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // deselect image
//        tabTickets.selectedImage = UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // select image
//        tabTickets.titlePositionAdjustment.vertical = tabTickets.titlePositionAdjustment.vertical-4 // title position change

        
        let tabBank = tabBar.items![1]
        tabBank.title = "Bank" // tabbar titlee
//        tabBank.image=UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // deselect image
//        tabBank.selectedImage = UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // select image
//        tabBank.titlePositionAdjustment.vertical = tabBank.titlePositionAdjustment.vertical-4 // title position change
//
      
        let tabSettings = tabBar.items![2]
        tabSettings.title = "Settings" // tabbar titlee
//        tabSettings.image=UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // deselect image
//        tabSettings.selectedImage = UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // select image
//        tabSettings.titlePositionAdjustment.vertical = tabSettings.titlePositionAdjustment.vertical-4 // title position change
        
        
        
    }
    
    
}
extension RoundUpTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
}
