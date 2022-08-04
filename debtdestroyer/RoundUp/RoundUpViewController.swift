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
        
        setButtonActions()
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
//        navController.modalPresentationStyle = .fullScreen
//        self.present(navController, animated: true, completion: nil)
        self.navigationController?.pushViewController(worksVC, animated: true)
    }
    
    @objc private func securelyCoonectMyAccountPressed() {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
