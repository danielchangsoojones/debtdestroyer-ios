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
    
    func getLeaderBoard(completion: @escaping ([QuizScore], String) -> Void) {
        PFCloud.callFunction(inBackground: "getLeaderboard", withParameters: [:]) { (result, error) in
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
                BannerAlert.showUnknownError(functionName: "getLeaderboard")
            }
        }
    }
    
    func loadPastWinners(completion: @escaping ([WinnerParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getPastWinners", withParameters: nil) { (result, error) in
            if let winners = result  as? [WinnerParse]  {
                completion(winners)
            }
            else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPastWinners")
            }
        }
    }


    func didShareToInstagramStory(quizTopicID: String, completion: @escaping () -> Void) {
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID]
        PFCloud.callFunction(inBackground: "didShareToInstagramStory", withParameters: parameters) { (result, error) in
            if let result = result {
                let json = JSON(result)
                print(json)
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "didShareToInstagramStory")
            }
        }
    }

}
