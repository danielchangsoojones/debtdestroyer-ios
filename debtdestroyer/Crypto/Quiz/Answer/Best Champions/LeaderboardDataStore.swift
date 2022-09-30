//
//  LeaderboardDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/29/22.
//

import Foundation
import Parse
import SwiftyJSON

class LeaderboardDataStore {
    func getLeaderBoard(quizTopicID: String, completion: @escaping ([QuizScoreParse], String) -> Void) {
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID]
        PFCloud.callFunction(inBackground: "getLeaderboard", withParameters: parameters) { (result, error) in
            if let dict = result as? [String : Any] {
                let json = JSON(dict)
                let deadlineMessage = json["deadlineMessage"].stringValue
                var quizScores: [QuizScoreParse] = []
                if let quizScoresParse = dict["quizScores"] as? [QuizScoreParse] {
                    quizScores = quizScoresParse
                }
                completion(quizScores, deadlineMessage)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getQuizData")
            }
        }
    }
}
