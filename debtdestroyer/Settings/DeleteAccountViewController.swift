//
//  DeleteAccountViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/08/22.
//

import UIKit
import SCLAlertView

class DeleteAccountViewController: UIViewController {
    var deleteAccButton = UIButton()
    var infoLabel = UILabel()
    var color1 = UIColor()
    private let dataStore = SettingsDataStore()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deleteAccountView = DeleteAccountView(frame: self.view.bounds)
        self.view = deleteAccountView
        
        color1 = deleteAccountView.color1
        deleteAccButton = deleteAccountView.deleteAccButton
        infoLabel = deleteAccountView.infoLabel
        deleteAccButton.tag = 1111
        deleteAccButton.addTarget(self, action: #selector(deleteAccBtnPressed), for: .touchUpInside)
        
        
        self.navigationItem.title = "Delete Account"
        self.navigationController?.navigationBar.tintColor = color1
        navigationItem.backButtonTitle = ""
        
        setNavBarBtns()
    }
    
    private func setNavBarBtns() {
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }

    @objc private func backPressed() {
        if self.deleteAccButton.tag == 1122 {
            self.segueToWelcomeVC()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func deleteAccBtnPressed() {
        if self.deleteAccButton.tag == 1122 {
            User.logOutInBackground { error in
                if let error = error {
                    BannerAlert.show(with: error)
                } else {
                    //successfully logged out
                    self.segueToWelcomeVC()
                }
            }
        } else {
            //deleteAccBtnPressed
            showAlert()
        }
        
    }
   
    func showAlert() {
        let alertView = SCLAlertView()
        alertView.addButton("Delete") {
            self.dataStore.deleteAccount { result, error in
                if result != nil {
                    // account successfully deleted
                    self.setLastMsg()
                } else {
                    BannerAlert.show(with: error)
                }
            }
        }
        
        alertView.showError("Delete Account", subTitle: "Are you sure that you want to delete your account?", closeButtonTitle: "Cancel")
    }
    
    private func setLastMsg() {
        self.infoLabel.text = "We are currently processing your DELETE ACCOUNT REQUEST. Account deletions take up to 48 hours. If you need to contact us, please go to the CONTACT US button on the Settings tab."
        self.deleteAccButton.tag = 1122
        self.deleteAccButton.setTitle("OK", for: .normal)
       
    }
    
    private func segueToWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }

}
