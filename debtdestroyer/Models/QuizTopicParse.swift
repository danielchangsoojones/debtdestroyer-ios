//
//  QuizTopicParse.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import Foundation
import Parse

class QuizTopicParse: SuperParseObject, PFSubclassing {
    @NSManaged var remaining_balance: String?
    @NSManaged var title: String?
    @NSManaged var logoImg: PFFileObject?

    class func parseClassName() -> String {
        return "QuizTopic"
    }
}
