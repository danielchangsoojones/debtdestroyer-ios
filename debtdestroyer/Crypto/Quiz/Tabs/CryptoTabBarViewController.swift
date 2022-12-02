//
//  CryptoTabBarViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit

class CryptoTabBarViewController: UITabBarController {
    private var dataStore = QuizDataStore()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabs()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        enteredScreen()
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
        
        checkHideReview()
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

extension CryptoTabBarViewController {
    @objc private func enteredScreen() {
        dataStore.checkShowQuizPopUp { showQuizPopUp, _ in
            self.activityIndicator.stopAnimating()
            let isAlreadyShowingStartQuizVC = self.checkIfAlreadyShowingStartQuizVC()
            if showQuizPopUp && !isAlreadyShowingStartQuizVC {
                let popupSkipedTime  = UserDefaults.standard.string(forKey: "popupSkipedTime")
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yy HH:mm:ss"
                let last = formatter.date(from: popupSkipedTime ?? "01/11/21 11:11:11")
                let lastPopup = last?.toLocalTime()
                let currentDateStr = Date().today(format: "dd/MM/yy HH:mm:ss")
                let currentDate = formatter.date(from: currentDateStr)

                if lastPopup!.withAddedHours(hours: 2) <= currentDate!.toLocalTime() {
                    self.presentStartQuizVC()
                }
            }
        }
    }
    
    private func presentStartQuizVC() {        
        let startQuizVC = StartQuizViewController(showSkipButton: true)
        let navController = UINavigationController(rootViewController: startQuizVC)
        present(navController, animated: true)
    }
    
    //we don't want to present the startQuizVC if it's already showing (i.e. they leave the app and come back twice).
    private func checkIfAlreadyShowingStartQuizVC() -> Bool {
        if let topVC = Helpers.getTopViewController() as? UINavigationController, topVC.viewControllers.first is StartQuizViewController{
            return true
        }
        
        return false
    }
}
