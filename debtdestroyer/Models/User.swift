//
//  User.swift
//  
//
//  Created by Dan Jones on 2/7/22.
//

import Parse

class User: PFUser {
    @NSManaged var phoneNumber: String
    @NSManaged var isDeleted: Bool
    @NSManaged var deviceType: String?
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var method_entity_id: String
    @NSManaged var promoCode: String?
    
    static var shouldShowEarnings = true
    static var sendMassTextNotification = false
    static var hasAccountsConnected = false
    static var forceUpdatePopUpShownInitially = false

    var quizPointCounter = 0

    var fullName: String {
        return firstName + " " + lastName
    }
    
    var isAppleTester: Bool {
        return email == "appletester@gmail.com"
    }
    
    var isAdminUser: Bool {
        return email == "messyjones@gmail.com"
    }
    
    static var isAppleTester: Bool {
        return User.current()?.email == "appletester@gmail.com"
    }
    
    static var isIpadDemo: Bool {
        return User.current()?.email == "ipaddemo@gmail.com"
    }
    
    static var isAdminUser: Bool {
        return User.current()?.email == "messyjones@gmail.com"
    }
}
