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
    @NSManaged var competing_tie_user_ids: [String]
    @NSManaged var winner_tie_spots: Int
    @NSManaged var mux_playback_id: String?

    class func parseClassName() -> String {
        return "QuizTopic"
    }
}
