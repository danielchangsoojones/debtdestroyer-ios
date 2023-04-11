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
    func checkLiveQuizPosition(quizData: QuizDataParse, inTieMode: Bool, completion: @escaping (Date?, Int?, Double, String?, String, Bool, [String], [String], [String], [String]) -> Void) {
        let parameters: [String : Any] = ["quizDataID" : quizData.objectId ?? "", "isInTieMode": inTieMode]
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
                let competing_tie_user_ids: [String] = json["competing_tie_user_ids"].arrayValue.map { json in
                    return json.stringValue
                }
                let won_array: [String] = json["won_tie_array"].arrayValue.map { json in
                    return json.stringValue
                }
                let lost_array: [String] = json["lost_tie_array"].arrayValue.map { json in
                    return json.stringValue
                }
                let updated_quiz_data_ids: [String] = json["updated_quiz_data_ids"].arrayValue.map { json in
                    return json.stringValue
                }
                completion(show_question_prompt_time,
                           correct_answer_index,
                           current_time_seconds,
                           video_answer_url,
                           current_quiz_data_id,
                           shouldRevealAnswer,
                           competing_tie_user_ids,
                           won_array,
                           lost_array,
                           updated_quiz_data_ids
                )
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
    
    func getSwitchQuizDatas(completion: @escaping (Any, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "getSwitchQuizDatas", withParameters: [:]) { (result, error) in
           completion(result, error)
        }
    }
    
    func getMidQuizData(completion: @escaping (Any?, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "getMidQuizData", withParameters: [:]) { (result, error) in
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
    
    func markQuizTieStatus(quizDatas: [QuizDataParse], shouldStartQuestionPrompt: Bool, total_tie_slots: Int, currentQuizData: QuizDataParse) {
        let parameters: [String : Any] = ["shouldStartQuestionPrompt" : shouldStartQuestionPrompt,
                                          "quizDataID": currentQuizData.objectId ?? "",
                                          "total_tie_slots": total_tie_slots
        ]
        
        PFCloud.callFunction(inBackground: "markTieQuizStatus", withParameters: parameters) { (result, error) in
            if let _ = result {
                if shouldStartQuestionPrompt == true {
                    BannerAlert.show(title: "", subtitle: "Question Prompt Shown Successfully!", type: .success)
                } else {
                    BannerAlert.show(title: "", subtitle: "Answer Reveled Successfully!", type: .success)
                }
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }
    
    func saveTieAnswer(chosen_answer_index: Int, quizData: QuizDataParse) {
        let quizDataID = quizData.objectId ?? ""
        
        let parameters: [String : Any] = ["chosen_answer_index": chosen_answer_index,
                                          "quizDataID": quizDataID]
        PFCloud.callFunction(inBackground: "saveTieAnswer", withParameters: parameters) { (result, error) in
            if result != nil {
                print("the answer was saved for the user")
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "shouldShowEarnings")
            }
        }
    }

    
    func assignWebReferral(completion: @escaping () -> Void) {
        PFCloud.callFunction(inBackground: "assignWebReferral", withParameters: [:]) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "assignWebReferral")
            }
        }
    }
    
    
    func getSpecialReferralInfo(completion: @escaping (String, [String]) -> Void) {
        PFCloud.callFunction(inBackground: "getSpecialReferralInfo", withParameters: [:]) { (result, error) in
            if let resultDict = result as? [String: Any],
               let title = resultDict["title"] as? String,
               let valueProps = resultDict["valueProps"] as? [String] {
                completion(title, valueProps)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getSpecialReferralInfo")
            }
        }
    }

    
    func saveSpecialReferral(socialType: String, actionType: String, completion: @escaping () -> Void) {
        let parameters: [String : Any] = ["socialType": socialType, "actionType": actionType]
        PFCloud.callFunction(inBackground: "saveSpecialReferral", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "saveSpecialReferral")
            }
        }
    }
    
    func logUserSocials(socials: [String], completion: @escaping () -> Void) {
        let parameters: [String : Any] = ["userSocials": socials]
        PFCloud.callFunction(inBackground: "logUserSocials", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "logUserSocials")
            }
        }
    }
    
    func updateMidQuiz(current_order: Int, quizDatas_length: Int, difficulty: String, completion: @escaping () -> Void) {
        let parameters: [String : Any] = ["current_order": current_order,
                                          "quizDatas_length": quizDatas_length,
                                          "difficulty": difficulty
        ]
        PFCloud.callFunction(inBackground: "updateMidQuiz", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "logUserSocials")
            }
        }
    }
}
