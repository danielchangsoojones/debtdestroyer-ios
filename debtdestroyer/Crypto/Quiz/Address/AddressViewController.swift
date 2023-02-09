//
//  AddressViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit
import SCLAlertView

class AddressViewController: FrigadePage {
    private var messageHelper: MessageHelper?
    var addView = AddressView()
    var addTextField: UITextField!
    var addLabel: UILabel!
    var descriptionLabel: UILabel!
    var nextButton: NextButton!
    private var dataStore: OnboardingDataStore!
    
    override func loadView() {
        super.loadView()
        let addView = AddressView(frame: self.view.frame)
        self.view = addView
    
        self.addTextField = addView.addTextField
        self.addLabel = addView.addLabel
        self.descriptionLabel = addView.descriptionLabel
        self.nextButton = addView.nextButton
        
        addTextField.addTarget(self,
                               action: #selector(textViewChanged),
                               for: .editingChanged)
        
        self.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = OnboardingDataStore(delegate: self)
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
        navTitle.text = "Promo Code"
        navTitle.font = UIFont.MontserratBold(size: 15)
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
        self.back()
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func nextBtnPressed() {
        let promoCode = self.addTextField.text?.trimmingCharacters(in: .whitespaces).lowercased()
        UserDefaults.standard.set(promoCode, forKey: OnboardingKeys.promoCode)
        self.next()
    }
    
    @objc func textViewChanged() {
        addTextField.text = addTextField.text?.lowercased()
    }
}

extension AddressViewController: OnboardingDataStoreDelegate {
    func showError(title: String, subtitle: String) {
        BannerAlert.show(title: title,
                         subtitle: subtitle,
                         type: .error)
        nextButton.stopSpinning()
    }
    
    func segueIntoApp() {
        nextButton.stopSpinning()
    }
}

