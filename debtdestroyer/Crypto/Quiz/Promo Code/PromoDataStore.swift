//
//  PromoDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/5/23.
//

import Foundation
import Parse
import SwiftyJSON
import Contacts

struct RetrievedContact {
    let contact: FriendContactParse
    let count: Int
}

class PromoDataStore {
    func setTextedFriend(textedContactObjectId: String, completion: @escaping () -> Void) {
        let parameters: [String: Any] = ["textedContactObjectId": textedContactObjectId]
        PFCloud.callFunction(inBackground: "setTextedFriend", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "setTextedFriend")
            }
        }
    }
    
    func loadFriendContacts(contacts: [CNContact], completion: @escaping ([InviteFriendViewController.PromoUser], String, String, [RetrievedContact]) -> Void) {
        let contactData = contacts.map { contact -> [String: Any] in
            let firstName = contact.givenName
            let lastName = contact.familyName
            let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
            
            var contactDict: [String: Any] = [:]
            contactDict["firstName"] = firstName
            contactDict["lastName"] = lastName
            contactDict["phoneNumbers"] = phoneNumbers
            return contactDict
        }
        
        let parameters: [String: Any] = ["contacts": contactData]
        
        PFCloud.callFunction(inBackground: "loadFriendContacts", withParameters: parameters) { (results, error) in
            if let results = results {
                let json = JSON(results)
                let personalPromo = json["personal_promo"].stringValue
                let promo_info_detail = json["promo_info_detail"].stringValue
                var users: [User] = []
                var overlappingContacts = [RetrievedContact]()
                if let dict = json.dictionaryObject, let usersFromDict = dict["users"] as? [User],
                   let overlapInfo = dict["overlap_info"] as? [[String: Any]] {
                    users = usersFromDict
                    for contactDict in overlapInfo {
                        if let contact = contactDict["contact"] as? FriendContactParse,
                           let count = contactDict["count"] as? Int {
                            let overlappingContact = RetrievedContact(contact: contact, count: count)
                            overlappingContacts.append(overlappingContact)
                        }
                    }
                }
                let promoUsers = users.map { user in
                    let promoUser = InviteFriendViewController.PromoUser(user: user)
                    return promoUser
                }
                
                if !personalPromo.isEmpty {
                    User.current()?.personalPromo = personalPromo
                }
                
                completion(promoUsers, personalPromo, promo_info_detail, overlappingContacts)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "uploadFriendContacts")
            }
        }
    }
}
