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
    @NSManaged var personalPromo: String?
    @NSManaged var notificationStatus: String?
    @NSManaged var notificationDesire: String?
    @NSManaged var showConnectAccount: Bool
    @NSManaged var personalPromoImg: PFFileObject?
    @NSManaged var socials: [String]?
    
    static var shouldShowEarnings = true
    static var sendMassTextNotification = false
    static var hasAccountsConnected = false

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
    
    static var isSemiAdmin: Bool {
        return User.current()?.email == "tylerjpflowers@gmail.com"
    }
}
