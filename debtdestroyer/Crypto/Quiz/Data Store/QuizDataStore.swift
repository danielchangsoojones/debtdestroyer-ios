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
    func checkLiveQuizPosition(quizData: QuizDataParse, completion: @escaping (Date?, Bool, Double) -> Void) {
        let parameters: [String : Any] = ["quizDataID" : quizData.objectId ?? ""]
        PFCloud.callFunction(inBackground: "checkLiveQuizPosition", withParameters: parameters) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let dict = json.dictionaryObject
                let show_question_prompt_time = dict?["show_question_prompt_time"] as? Date
                let should_reveal_answer = json["should_reveal_answer"].boolValue
                let current_time_seconds = json["current_time_seconds"].doubleValue
                completion(show_question_prompt_time, should_reveal_answer, current_time_seconds)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "checkLiveQuizPosition")
            }
        }
    }
    
    func saveQuizCurrentTime(current_time_seconds: Int) {
        let parameters: [String : Any] = ["current_time_seconds" : current_time_seconds]
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
    
    func getQuizData(completion: @escaping ([QuizDataParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getQuizData", withParameters: nil) { (result, error) in
            if let quizData = result as? [QuizDataParse] {
                completion(quizData)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getQuizData")
            }
        }
    }
    
    func saveCryptoAddress(crypto_address: String, quizTopicID: String , completion: @escaping (CryptoAddressParse) -> Void) {
        let parameters: [String : Any] = ["crypto_address_public_key" : crypto_address, "quizTopicID": quizTopicID]
        PFCloud.callFunction(inBackground: "saveCryptoAddress", withParameters: parameters) { (result, error) in
            if let cryptoAddress = result as? CryptoAddressParse{
                completion(cryptoAddress)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "saveCryptoAddress")
            }
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
    
    func saveAnswer(for quizTopic: QuizTopicParse, answerStatus: QuestionViewController.AnswerStatus, quizData: QuizDataParse) {
        let questionStatus = answerStatus.rawValue
        let quizDataID = quizData.objectId ?? ""
        let quizTopicID = quizTopic.objectId ?? ""
        
        let parameters: [String : Any] = ["quizTopicID" : quizTopicID,
                                          "questionStatus":questionStatus,
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

}
