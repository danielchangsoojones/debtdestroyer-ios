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
    
    static var shouldShowEarnings = true
    
    var fullName: String {
        return firstName + " " + lastName
    }
}
