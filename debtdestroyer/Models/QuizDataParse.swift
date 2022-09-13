//
//  QuizDataParse.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import Foundation
import Parse

class QuizDataParse: SuperParseObject, PFSubclassing {
    @NSManaged var quizTopic: QuizTopicParse
    @NSManaged var question: String
    @NSManaged var title: String?
    @NSManaged var logoImg: PFFileObject?

    class func parseClassName() -> String {
        return "QuizData"
    }
}
