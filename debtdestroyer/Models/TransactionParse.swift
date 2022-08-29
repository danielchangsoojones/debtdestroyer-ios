//
//  TransactionParse.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/08/22.
//

import Foundation
import Parse

class TransactionParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var amountPaidToLoan: String?
    @NSManaged var ticketsEarned: String?
    @NSManaged var title: String?

    class func parseClassName() -> String {
        return "Transaction"
    }
}
