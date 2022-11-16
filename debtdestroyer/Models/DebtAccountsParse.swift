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
    @NSManaged var remaining_balance: Int
    @NSManaged var last_payment_amount: Int
    @NSManaged var title: String

    class func parseClassName() -> String {
        return "DebtAccount"
    }
    var loadedImg: UIImage?
    
    var remaining_balance_dollars: String {
        return convertToCentsToDollars(amount_in_cents: remaining_balance)
    }
    
    var last_payment_amount_dollars: String {
        return convertToCentsToDollars(amount_in_cents: last_payment_amount)
    }
    
    private func convertToCentsToDollars(amount_in_cents: Int) -> String {
        let amount_in_dollars = Double(amount_in_cents) / 100
        let amount_str_dollars = "$\(amount_in_dollars)"
        return amount_str_dollars
    }
}
