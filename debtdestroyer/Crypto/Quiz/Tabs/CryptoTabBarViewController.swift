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
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAppDidBecomeActive()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        self.delegate = self
        
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
        let vc1 = PrizeViewController()
        let vc2 = StartQuizViewController(showSkipButton: false, quizDatas: nil)
        let vc3 = ChampionsViewController(quizTopic: self.quizDatas.first!.quizTopic)
        let vc4 = CryptoSettingsViewController(quizDatas: self.quizDatas, currentIndex: 0)

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
        
        checkHideReview()
    }
    
    private func checkHideReview() {
        dataStore.shouldShowEarnings { shouldMakeEverythingVisible in
            if !shouldMakeEverythingVisible {
                self.tabBarController?.tabBar.items?.remove(at: 0)
            }
        }
    }
}

extension CryptoTabBarViewController {
    private func handleAppDidBecomeActive() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enteredScreen),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    @objc private func enteredScreen() {
        dataStore.checkShowQuizPopUp { showQuizPopUp, quizDatas in
            self.quizDatas = quizDatas
            self.activityIndicator.stopAnimating()
            self.setTabs()
            let isAlreadyShowingStartQuizVC = self.checkIfAlreadyShowingStartQuizVC()
            if showQuizPopUp && !isAlreadyShowingStartQuizVC {
                self.presentStartQuizVC(quizDatas: quizDatas)
            }
        }
    }
    
    private func presentStartQuizVC(quizDatas: [QuizDataParse]) {
        let startQuizVC = StartQuizViewController(showSkipButton: true,
                                                  quizDatas: quizDatas)
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

extension CryptoTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
