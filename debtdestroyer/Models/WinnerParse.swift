//
//  WinnerParse.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 06/09/22.
//

import Foundation
import Parse

class WinnerParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var winning_date: String?
    @NSManaged var amount_won_dollars: String?
    @NSManaged var video: PFFileObject?
    
    class func parseClassName() -> String {
        return "Winner"
    }
}
