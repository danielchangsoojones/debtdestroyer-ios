//
//  FriendContactParse.swift
//  debtdestroyer
//
//  Created by DK on 3/23/23.
//

import UIKit
import Parse

class FriendContactParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var profPic: PFFileObject?
    @NSManaged var hasTexted: Bool
    
    class func parseClassName() -> String {
        return "FriendContact"
    }
}
