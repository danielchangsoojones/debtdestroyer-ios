//
//  CryptoTabBarViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit

class CryptoTabBarViewController: UITabBarController {
    private var dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        self.delegate = self
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
        dataStore.getQuizData { quizData in
            self.quizDatas = quizData

            activityIndicator.stopAnimating()
            self.setTabs()

        }
        
    }
    
//    open override var childForStatusBarStyle: UIViewController? {
//        return selectedViewController
//    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    private func setTabs(){
        let vc1 = PrizeViewController()
        let vc2 = ChampionsViewController(quizTopic: self.quizDatas.first!.quizTopic)
        let vc3 = WinnersViewController(quizDatas: self.quizDatas, currentIndex: 0)//FullScreenVideoPlayerViewController()
        let vc4 = CryptoSettingsViewController(quizDatas: self.quizDatas, currentIndex: 0)

        let controllers = [vc1,vc2,vc3,vc4]
        self.viewControllers = controllers.map { CustomNavigationViewController(rootViewController: $0)}
        
        let tabQuiz = tabBar.items![0]
        tabQuiz.image = UIImage(named: "houseBW")?.withRenderingMode(.alwaysOriginal)
        tabQuiz.selectedImage = UIImage(named: "houseC")?.withRenderingMode(.alwaysOriginal)
     
        let tabLeadboard = tabBar.items![1]
        tabLeadboard.image = UIImage(named: "ticketBW")?.withRenderingMode(.alwaysOriginal)
        tabLeadboard.selectedImage = UIImage(named: "ticketC")?.withRenderingMode(.alwaysOriginal)
        
        let tabWinner = tabBar.items![2]
        tabWinner.image = UIImage(named: "giftBW")?.withRenderingMode(.alwaysOriginal)
        tabWinner.selectedImage = UIImage(named: "giftC")?.withRenderingMode(.alwaysOriginal)
        
        let tabSettings = tabBar.items![3]
        tabSettings.image = UIImage(named: "settingsBW")?.withRenderingMode(.alwaysOriginal)
        tabSettings.selectedImage = UIImage(named: "settingsC")?.withRenderingMode(.alwaysOriginal)
        
        //hiding the winners tab for now.
        viewControllers?.remove(at: 2)
    }
}

extension CryptoTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
