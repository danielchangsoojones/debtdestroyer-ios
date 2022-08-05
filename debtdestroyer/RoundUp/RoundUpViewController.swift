//
//  RoundUpViewController.swift
//  nbawidget
//
//  Created by Rashmi Aher on 01/08/22.
//

import UIKit

class RoundUpViewController: UIViewController {
    
    private var backgroundCanvas1: UIView!
    private var connectAccountBtn : UIButton!
    private var backgroundCanvas2: UIView!
    private var howItWorksButton = UIButton()
    
    override func loadView() {
        super.loadView()
        let roundUpView = RoundUpView(frame: self.view.frame)
        self.view = roundUpView
        
        self.connectAccountBtn = roundUpView.connectAccountBtn
        self.howItWorksButton = roundUpView.howItWorksButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        setupNavBar()
        setNavBarBtns()
        setButtonActions()
    }
    
    fileprivate func setupNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func setNavBarBtns() {
        var rightImg = UIImage.init(systemName: "info.circle")
        rightImg = rightImg?.withRenderingMode(.alwaysOriginal)
        let info = UIBarButtonItem(image: rightImg , style: .plain, target: self, action: #selector(infoPressed))
        navigationItem.rightBarButtonItem = info
        
        let leftItem = UIBarButtonItem(title: "Round-Ups",
                                       style: UIBarButtonItem.Style.plain,
                                       target: nil,
                                       action: nil)
        leftItem.isEnabled = false
        self.navigationItem.leftBarButtonItem = leftItem
      
    }
    
    @objc private func infoPressed() {
        
    }
    
    func setButtonActions(){
        
        howItWorksButton.addTarget(self,
                                   action: #selector(howItWorksPressed),
                                   for: .touchUpInside)
        
        connectAccountBtn.addTarget(self,
                                    action: #selector(securelyCoonectMyAccountPressed),
                                    for: .touchUpInside)
        
    }
    
    @objc private func howItWorksPressed() {
        let worksVC = HowDoesRoundUpWorksViewController()
        let navController = UINavigationController(rootViewController: worksVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc private func securelyCoonectMyAccountPressed() {
        
    }
}
