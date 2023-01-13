//
//  ConfirmInfoViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit
import SCLAlertView

class ConfirmInfoViewController: UIViewController, OnboardingDataStoreDelegate {
  
    var confirmInfoView = ConfirmInfoView()
    private var firstNameTxt = UITextField()
    private var lastNameTxt = UITextField()
    private var phNumberTxt = UITextField()
    private var firstNameEditBtn = UIButton()
    private var lastNameEditBtn = UIButton()
    private var phNumberEditBtn = UIButton()
    private var nextBtn = SpinningWithGradButton()
    private var messageHelper: MessageHelper?
    var dataStore : OnboardingDataStore!

    override func loadView() {
        super.loadView()
        confirmInfoView = ConfirmInfoView(frame: self.view.bounds)
        self.view = confirmInfoView
        self.nextBtn = confirmInfoView.nextBtn
        self.firstNameTxt = confirmInfoView.firstNameTxt
        self.lastNameTxt = confirmInfoView.lastNameTxt
        self.phNumberTxt = confirmInfoView.phNumberTxt
        self.firstNameEditBtn = confirmInfoView.firstNameEditBtn
        self.lastNameEditBtn = confirmInfoView.lastNameEditBtn
        self.phNumberEditBtn = confirmInfoView.phNumberEditBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = OnboardingDataStore(delegate: self)

        self.firstNameTxt.text = User.current()?.firstName.capitalized
        self.lastNameTxt.text = User.current()?.lastName.capitalized
        self.phNumberTxt.text = User.current()?.phoneNumber

        self.nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        self.firstNameEditBtn.addTarget(self, action: #selector(editButtonClicked(sender:)), for: .touchUpInside)
        self.lastNameEditBtn.addTarget(self, action: #selector(editButtonClicked(sender:)), for: .touchUpInside)
        self.phNumberEditBtn.addTarget(self, action: #selector(editButtonClicked(sender:)), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
        
        setNavBarBtns()
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        self.navigationController?.setStatusBar(backgroundColor: .white)
        
        let navBtn = UIButton()
        let attStr = NSMutableAttributedString(string: "Questions?", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15)])
        
        attStr.append(NSMutableAttributedString(string: " Message us.", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor:UIColor.black]))
        
        navBtn.setAttributedTitle(attStr, for: .normal)
        navBtn.addTarget(self, action: #selector(questionsPressed), for: .touchUpInside)
        let helpButton = UIBarButtonItem(customView: navBtn)
        navigationItem.rightBarButtonItem = helpButton
        
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func questionsPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func nextBtnPressed() {
        nextBtn.startSpinning()
        if isComplete {
            let bottomText = phNumberTxt.text ?? "1111111111"
            let phoneNumber = NumberFormatter().number(from: bottomText.numbersOnly) ?? 1111111111
            

            self.dataStore.save(phoneNumber:  String(describing: phoneNumber), firstName: firstNameTxt.text ?? "", lastName: lastNameTxt.text ?? "", promoCode: nil){
                    print("success")
                }
            nextBtn.stopSpinning()
        } else {
            nextBtn.stopSpinning()
        }
    }
    
    var isComplete: Bool {
        guard let fNameStr = firstNameTxt.text else {
            return false
        }
        
        if fNameStr.removeWhitespaces().isEmpty {
            BannerAlert.show(title: "First Name Needed", subtitle: "Please input your first name", type: .error)
            return false
        }
        guard let lNameStr = lastNameTxt.text else {
            return false
        }
        
        if lNameStr.removeWhitespaces().isEmpty {
            BannerAlert.show(title: "Last Name Needed", subtitle: "Please input your last name", type: .error)
            return false
        }
        
        guard let phoneStr = phNumberTxt.text else {
            return false
        }
        
        if phoneStr.isEmpty {
            BannerAlert.show(title: "Phone Number Needed", subtitle: "Please input your phone number", type: .error)
            return false
        }
        
        return true
    }

    @objc private func editButtonClicked(sender : UIButton) {
        if sender == firstNameEditBtn {
//            firstNameTxt.isUserInteractionEnabled = true
//            lastNameTxt.isUserInteractionEnabled = false
//            phNumberTxt.isUserInteractionEnabled = false
//            firstNameTxt.becomeFirstResponder()
            
            let appearance = SCLAlertView.SCLAppearance(
                kTextFieldHeight: 60,
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("Enter first name")
            _ = alert.addButton("Update") {
                self.firstNameTxt.text = txt.text
            }
            
            _ = alert.addButton("Cancel") {

            }
            
            let kInfoTitle = "Info"
            _ = alert.showEdit(kInfoTitle, subTitle:"")
            
        } else if sender == lastNameEditBtn {
//            firstNameTxt.isUserInteractionEnabled = false
//            lastNameTxt.isUserInteractionEnabled = true
//            phNumberTxt.isUserInteractionEnabled = false
//            lastNameTxt.becomeFirstResponder()
            
            let appearance = SCLAlertView.SCLAppearance(
                kTextFieldHeight: 60,
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("Enter last name")
            _ = alert.addButton("Update") {
                self.lastNameTxt.text = txt.text
            }
            
            _ = alert.addButton("Cancel") {
                
            }
            
            let kInfoTitle = "Info"
            _ = alert.showEdit(kInfoTitle, subTitle:"")
            
        } else {
//            firstNameTxt.isUserInteractionEnabled = false
//            lastNameTxt.isUserInteractionEnabled = false
//            phNumberTxt.isUserInteractionEnabled = true
//            phNumberTxt.becomeFirstResponder()

            let appearance = SCLAlertView.SCLAppearance(
                kTextFieldHeight: 60,
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("Enter phone number")
            _ = alert.addButton("Update") {
                self.phNumberTxt.text = txt.text
            }
            
            _ = alert.addButton("Cancel") {
                
            }
            
            let kInfoTitle = "Info"
            _ = alert.showEdit(kInfoTitle, subTitle:"")
            
        }
        
    }
    
    func segueIntoApp() {
        nextBtn.stopSpinning()
        // TODO: where to head this view
    }
    
    func showError(title: String, subtitle: String) {
        BannerAlert.show(title: title, subtitle: subtitle, type: .error)

    }
}
