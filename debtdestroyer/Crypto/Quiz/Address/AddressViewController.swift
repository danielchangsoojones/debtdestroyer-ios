//
//  AddressViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit
import SCLAlertView

class AddressViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var dataStore = QuizDataStore()
    var addView = AddressView()
    private let quizTopicDatas: QuizTopicParse
    var addTextField: UITextField!
    var addLabel: UILabel!
    var descriptionLabel: UILabel!
    var nextButton: SpinningWithGradButton!

    init(quizTopicDatas: QuizTopicParse) {
        self.quizTopicDatas = quizTopicDatas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let addView = AddressView(frame: self.view.frame)
        self.view = addView
    
        self.addTextField = addView.addTextField
        self.addLabel = addView.addLabel
        self.descriptionLabel = addView.descriptionLabel
        self.nextButton = addView.nextButton

        self.addLabel.text = "Enter Your " + quizTopicDatas.name + " Address"
        self.addTextField.placeholder = quizTopicDatas.name + "_sfjlsdfisdlfjsljfls"
        self.descriptionLabel.text = "This is the address where you would like to have your " + quizTopicDatas.name + " sent. It takes us up to 24 hours to send you your coin rewards since we currently have to manually send out the rewards."
        
        self.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        messageHelper = MessageHelper(currentVC: self, delegate: nil)
        self.addTextField.becomeFirstResponder()
        setNavBarBtns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
       setGradientNavigationTitle()
    }
    
    private func setGradientNavigationTitle() {
        let navTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: 120, height: 25))
        navTitle.text = "You’ve Earned 2 " + quizTopicDatas.name + "!"
        navTitle.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        navTitle.textAlignment = .center
        let gradientLabel = addView.getGradientLayer(bounds: navTitle.bounds)
        navTitle.textColor = addView.gradientColor(bounds: navTitle.bounds, gradientLayer: gradientLabel)
        self.navigationItem.titleView = navTitle
    }
    
    private func setNavBarBtns() {
        navigationItem.backButtonTitle = ""
        
        var helpImg = UIImage.init(named: "Help")
        helpImg = helpImg?.withRenderingMode(.alwaysOriginal)
        let help = UIBarButtonItem(image: helpImg , style: .plain, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
        
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    private func showAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            self.addTextField.becomeFirstResponder()
        })
        alertView.showInfo("", subTitle: "Please enter your " + quizTopicDatas.name + " address!")
    }
    
    @objc private func nextBtnPressed() {
        let address = self.addTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if address == "" {
            showAlert()
            self.addTextField.text = ""
            return
        }
        
        dataStore.saveCryptoAddress(crypto_address: self.addTextField.text ?? "", quizTopicID: quizTopicDatas.objectId!) { response in
            let phoneVC = CreateProfileViewController()
            phoneVC.quizTopicDatas = self.quizTopicDatas
            phoneVC.crypto_address = self.addTextField.text
            self.navigationController?.pushViewController(phoneVC, animated: true)
        }
        
        
        
    }
}

