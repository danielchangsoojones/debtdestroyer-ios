//
//  OnboardingDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import Parse
import ContactsUI

protocol OnboardingDataStoreDelegate: NSObjectProtocol {
    func segueIntoApp()
    func showError(title: String, subtitle: String)
}

class OnboardingDataStore: NSObject {
    weak var delegate: OnboardingDataStoreDelegate?
    
    init(delegate: OnboardingDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func register(email: String, password: String, completion: @escaping () -> Void) {
        let newUser = User()
        newUser.username = email.lowercased()
        newUser.password = password
        newUser.email = email.lowercased()
        newUser.deviceType = "iOS"
        
        newUser.signUpInBackground { (success, error: Error?) -> Void in
            if success {
                let installation = PFInstallation.current()
                installation?["user"] = User.current()
                installation?.saveInBackground()
                self.delegate?.segueIntoApp()
                completion()
            } else if let error = error, let code = PFErrorCode(rawValue: error._code) {
                switch code {
                case .errorInvalidEmailAddress:
                    self.delegate?.showError(title: "Invalid Email Address", subtitle: "Please enter a valid email address")
                case .errorUserEmailTaken, .errorUsernameTaken:
                    self.delegate?.showError(title: "Email Already Taken", subtitle: "Email already exists, please use a different one or log in.")
                default:
                    self.delegate?.showError(title: "Sign Up Error", subtitle: error.localizedDescription)
                }
            } else {
                self.delegate?.showError(title: "Unknown Sign Up Error", subtitle: "unknown error on sign up, please contact us at 317-690-5323")
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping () -> Void) {
        var lowerCaseEmail = email.lowercased()
        lowerCaseEmail = lowerCaseEmail.removeWhitespaces()
        User.logInWithUsername(inBackground: lowerCaseEmail, password: password) { (user, error) -> Void in
            if let currentUser = user, error == nil {
                if ((currentUser as? User)?.isDeleted ?? false) {
                    User.logOutInBackground()
                    BannerAlert.show(title: "Account Deleted",
                                     subtitle: "you can't login because your account has been deleted",
                                     type: .error)
                } else {
                    let installation = PFInstallation.current()
                    installation?["user"] = User.current()
                    installation?.saveEventually(nil)
                    completion()
                }
            } else if let error = error, let code = PFErrorCode(rawValue: error._code) {
                if code == .errorObjectNotFound {
                    self.delegate?.showError(title: "Login Failed", subtitle: error.localizedDescription)
                } else {
                    self.delegate?.showError(title: "Error", subtitle: error.localizedDescription)
                }
            } else {
                self.delegate?.showError(title: "Unknown Login Error", subtitle: "Unknown login error, please contact us at 317-690-5323")
            }
        }
    }
        
    func save(phoneNumber: String, firstName: String, lastName: String, promoCode: String?, completion: @escaping () -> Void) {
        User.current()?.phoneNumber = phoneNumber
        User.current()?.firstName = firstName
        User.current()?.lastName = lastName
        if let promoCode = promoCode, !promoCode.isEmpty {
            User.current()?.promoCode = promoCode
        }
        
        User.current()?.saveInBackground()
    }
    
    func saveContacts(contacts: [CNContact]) {
        let phones = contacts.map { contact -> [String: Any] in
            var dictionary: [String : Any] = [:]
            dictionary["firstName"] = contact.givenName
            dictionary["lastName"] = contact.familyName
            dictionary["phoneNums"] = contact.phoneNumbers.map({ label -> [String: Any] in
                var innerDictionary: [String : Any] = [:]
                innerDictionary["label"] = label.label
                innerDictionary["value"] = label.value.stringValue
                return innerDictionary
            })
            return dictionary
        }
        
        let params: [String: Any] = ["contacts" : phones]
        
        PFCloud.callFunction(inBackground: "saveContacts", withParameters: params) { (result, error) in
            if let result = result {
                print(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.show(title: "Error", subtitle: "There was an error using the saveContacts function. Please contact Daniel Jones at (317)-690-5323 for help.", type: .error)
            }
        }
    }
}
