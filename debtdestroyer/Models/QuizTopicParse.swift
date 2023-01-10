//
//  QuizTopicParse.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import Foundation
import Parse

class QuizTopicParse: SuperParseObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var ticker: String
    @NSManaged var prize_amount: Double
    @NSManaged var start_time: Date
    @NSManaged var currentQuizDataID: String

    class func parseClassName() -> String {
        return "QuizTopic"
    }
}
