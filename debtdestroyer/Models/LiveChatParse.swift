//
//  LiveChatParse.swift
//  debtdestroyer
//
//  Created by DK on 4/19/23.
//

import Foundation
import Parse

class LiveChatParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var quizTopic: QuizTopicParse
    @NSManaged var message: String
    @NSManaged var shouldShow: Bool

    class func parseClassName() -> String {
        return "LiveChat"
    }
}
