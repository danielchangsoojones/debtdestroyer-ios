//
//  ContactViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 2/13/23.
//

import UIKit
import SnapKit
import ContactsUI

class ContactViewController: UIViewController, OnboardingDataStoreDelegate {
    private var nextBtn = SpinningWithGradButton()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var dataStore: OnboardingDataStore!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemGray6
        setTitleLabel()
        setSubtitleLabel()
        setNextBtn()
        setSkipBtn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = OnboardingDataStore(delegate: self)
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Invite Friends"
        titleLabel.font = UIFont.MontserratBold(size: 28)
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.topMargin.equalToSuperview().offset(10)
        }
    }
    
    private func setSubtitleLabel() {
        subtitleLabel.text = "Let your friends know about Debt Destroyer by sending them an invite text."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.MontserratLight(size: 14)
        self.view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
    
    private func setNextBtn() {
        let size: CGFloat = 20
        if #available(iOS 15.0, *) {
            if nextBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Next: Invite Friends", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: size),NSAttributedString.Key.foregroundColor : UIColor.white]))
                nextBtn.configuration = configuration
                
            } else {
                nextBtn.configuration?.attributedTitle = AttributedString("Next: Invite Friends", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: size), NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
        } else {
            nextBtn.setTitleColor(.white, for: .normal)
            nextBtn.setTitle("Next: Invite Friends", for: .normal)
        }
        
        
        nextBtn.layer.cornerRadius = 30
        nextBtn.clipsToBounds = true
        nextBtn.addTarget(self, action: #selector(contactsPressed), for: .touchUpInside)
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(subtitleLabel)
            make.height.equalTo(70)
        }
    }
    
    private func setSkipBtn() {
        let skip = UIBarButtonItem(title: "Skip",
                                   style: .plain,
                                   target: self,
                                   action: #selector(skipPressed))
        navigationItem.rightBarButtonItem = skip
    }
    
    
    @objc private func skipPressed() {
        let vc = CryptoTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func contactsPressed() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            skipPressed()
        case .notDetermined:
            nextBtn.startSpinning()
            var contacts = [CNContact]()
            let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
                
            skipPressed()
            let contactStore = CNContactStore()
                do {
                    //just jump right into the home screen while it still performs this operation in the background.
                    try contactStore.enumerateContacts(with: request) {
                        (contact, stop) in
                        // Array containing all unified contacts from everywhere
                        contacts.append(contact)
                    }
                    
                    dataStore.saveContacts(contacts: contacts)
                } catch {
                    nextBtn.stopSpinning()
                    skipPressed()
                }
        case .restricted, .denied:
            skipPressed()
        @unknown default:
            skipPressed()
        }
    }
    
    func segueIntoApp() {}
    
    func showError(title: String, subtitle: String) {
        BannerAlert.show(title: title, subtitle: subtitle, type: .error)
    }
}
