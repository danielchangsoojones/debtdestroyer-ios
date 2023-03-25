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
    @NSManaged var amountWon: Double
    @NSManaged var quizTopic: QuizTopicParse

    class func parseClassName() -> String {
        return "Winner"
    }
}
