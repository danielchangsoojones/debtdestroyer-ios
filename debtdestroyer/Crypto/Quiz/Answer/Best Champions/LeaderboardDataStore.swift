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
    struct QuizScore {
        let user: User
        let total_time_str: String
        let points: Int
    }
    
    func getLeaderBoard(quizTopicID: String, completion: @escaping ([QuizScore], String) -> Void) {
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID]
        PFCloud.callFunction(inBackground: "getLeaderboard", withParameters: parameters) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let deadlineMessage = json["deadlineMessage"].stringValue
                let quizScoresJSON = json["quizScores"].arrayValue
                let quizScores: [QuizScore] = quizScoresJSON.map { quizScoreJSON in
                    let total_time_str = quizScoreJSON["total_time_str"].stringValue
                    let points = quizScoreJSON["points"].intValue
                    if let dict = quizScoreJSON.dictionaryObject, let user = dict["user"] as? User {
                        let quizScore = QuizScore(user: user,
                                                  total_time_str: total_time_str,
                                                  points: points)
                        return quizScore
                    } else {
                        //shouldn't reach here.
                        let quizScore = QuizScore(user: User(),
                                                  total_time_str: total_time_str,
                                                  points: points)
                        return quizScore
                    }
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
