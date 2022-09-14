//
//  CryptoAddressParse.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import Foundation
import Parse

class CryptoAddressParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var crypto_address_public_key: String
    @NSManaged var quiz_topic: String
    @NSManaged var hasPaid: String
    
    class func parseClassName() -> String {
        return "CryptoAddress"
    }
}
