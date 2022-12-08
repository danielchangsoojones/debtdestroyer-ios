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
    @NSManaged var answers: [String]?
    @NSManaged var correct_answer_index: Int
    @NSManaged var order: Int
    @NSManaged var video_url_string: String
    @NSManaged var video_length_seconds: Int
    @NSManaged var start_question_prompt_seconds: Int

    class func parseClassName() -> String {
        return "QuizData"
    }
}
