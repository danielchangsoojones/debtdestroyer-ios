//
//  DebtAccountsParse.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 01/09/22.
//

import Foundation
import Parse

class DebtAccountsParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var remaining_balance: String?
    @NSManaged var title: String?
    @NSManaged var logoImg: PFFileObject?

    class func parseClassName() -> String {
        return "DebtAccount"
    }
    var loadedImg: UIImage?
}
