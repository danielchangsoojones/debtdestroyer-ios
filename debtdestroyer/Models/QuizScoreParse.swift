//
//  QuizScoreParse.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/29/22.
//

import Foundation
import Parse

class QuizScoreParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var score: Int

    class func parseClassName() -> String {
        return "QuizScore"
    }
}
