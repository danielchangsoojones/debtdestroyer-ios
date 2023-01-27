//
//  QuizDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import Foundation
import Parse
import SwiftyJSON

class QuizDataStore {
    func checkLiveQuizPosition(quizData: QuizDataParse, completion: @escaping (Date?, Int?, Double, String?, String, Bool) -> Void) {
        let parameters: [String : Any] = ["quizDataID" : quizData.objectId ?? ""]
        PFCloud.callFunction(inBackground: "checkLiveQuizPosition", withParameters: parameters) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let dict = json.dictionaryObject
                let show_question_prompt_time = dict?["show_question_prompt_time"] as? Date
                let correct_answer_index = json["correct_answer_index"].int
                let current_time_seconds = json["current_time_seconds"].doubleValue
                let current_quiz_data_id = json["current_quiz_data_id"].stringValue
                let video_answer_url = json["video_answer_url"].string
                let shouldRevealAnswer = json["should_reveal_answer"].boolValue
                completion(show_question_prompt_time,
                           correct_answer_index,
                           current_time_seconds,
                           video_answer_url,
                           current_quiz_data_id,
                           shouldRevealAnswer)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "checkLiveQuizPosition")
            }
        }
    }
    
    func saveQuizCurrentTime(current_time_seconds: Double, currentQuizDataID: String) {
        let parameters: [String : Any] = ["current_time_seconds" : current_time_seconds,
                                          "currentQuizDataID": currentQuizDataID
        
        ]
        PFCloud.callFunction(inBackground: "saveQuizCurrentTime", withParameters: parameters) { (result, error) in
            if let result = result as? String {
                BannerAlert.show(title: "Success",
                                 subtitle: result,
                                 type: .success)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "checkLiveQuizPosition")
            }
        }
    }
    
    func getQuizData(completion: @escaping (Any, Error?) -> Void) {
        let version_str = Helpers.getVersionStr()
        let parameters: [String: Any] = ["app_version" : version_str ?? "", "deviceType": "ios"]
        PFCloud.callFunction(inBackground: "getQuizData", withParameters: parameters) { (result, error) in
           completion(result, error)
        }
    }
    
    func shouldShowEarnings(completion: @escaping (Bool) -> Void) {
        let versionStr = Helpers.getVersionStr() ?? ""
        let parameters: [String : Any] = ["app_version" : versionStr, "deviceType": "ios"]
        PFCloud.callFunction(inBackground: "shouldShowEarnings", withParameters: parameters) { (result, error) in
            if let shouldShowEarnings = result as? Bool {
                completion(shouldShowEarnings)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "shouldShowEarnings")
            }
        }
    }
    
    func saveAnswer(for quizTopic: QuizTopicParse, chosen_answer_index: Int, quizData: QuizDataParse) {
        let quizDataID = quizData.objectId ?? ""
        let quizTopicID = quizTopic.objectId ?? ""
        
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID,
                                          "chosen_answer_index": chosen_answer_index,
                                          "quizDataID": quizDataID]
        PFCloud.callFunction(inBackground: "saveAnswer", withParameters: parameters) { (result, error) in
            if result != nil {
                print("the answer was saved for the user")
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "shouldShowEarnings")
            }
        }
    }
    
    func checkIfAlreadyTakenQuiz(for quizTopic: QuizTopicParse, completion: @escaping (Any?, Error?) -> Void) {
        let quizTopicID = quizTopic.objectId ?? ""
        let ios_version = Helpers.getVersionStr() ?? ""
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID, "ios_version": ios_version]
        PFCloud.callFunction(inBackground: "checkIfAlreadyTakenQuiz", withParameters: parameters) { (result, error) in
            completion(result, error)
        }
    }
        
    func checkShowQuizPopUp(completion: @escaping (Bool, [QuizDataParse]) -> Void) {
        PFCloud.callFunction(inBackground: "checkShowQuizPopUp", withParameters: [:]) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let showQuizPopUp = json["showQuizPopUp"].boolValue
                let dict = json.dictionaryObject
                let quizDatas: [QuizDataParse] = (dict?["quizDatas"] as? [QuizDataParse]) ?? []
                completion(showQuizPopUp, quizDatas)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "shouldShowEarnings")
            }
        }
    }
        
    func sendMassTextNotification(completion: @escaping ()-> Void) {
        PFCloud.callFunction(inBackground: "sendMassText", withParameters: [:]) { (result, error) in
            if let result = result {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "sendMassTextNotification")
            }
        }
    }
    
    func getDemoQuizData(completion: @escaping ([QuizDataParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getDemoQuizData", withParameters: nil) { (result, error) in
            if let quizData = result as? [QuizDataParse] {
                completion(quizData)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getDemoQuizData")
            }
        }
    }
    
    func loadVideoAnswer(video_answer_id: String, completion: @escaping (VideoAnswerParse) -> Void) {
        let parameters: [String : Any] = ["video_answer_id" : video_answer_id]
        PFCloud.callFunction(inBackground: "loadVideoAnswer", withParameters: parameters) { (result, error) in
            if let videoAnswer = result as? VideoAnswerParse {
                completion(videoAnswer)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getDemoQuizData")
            }
        }
    }
    
    func checkWaitlist(completion: @escaping (Bool, String, String) -> Void) {
        PFCloud.callFunction(inBackground: "checkWaitlist", withParameters: [:]) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let title = json["title"].stringValue
                let subtitle = json["subtitle"].stringValue
                let isOnWaitlist = json["isOnWaitlist"].boolValue
                completion(isOnWaitlist, title, subtitle)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "checkWaitlist")
            }
        }
    }
    
    func officiallyEndQuiz(for quizTopic: QuizTopicParse) {
        let quizTopicID = quizTopic.objectId ?? ""
        
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID]
        PFCloud.callFunction(inBackground: "officiallyEndQuiz", withParameters: parameters) { (result, error) in
            if result != nil {
                print("Officially End Quiz called Successfully.")
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "officiallyEndQuiz")
            }
        }
    }


}
