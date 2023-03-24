//
//  QuizManagerDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/11/22.
//

import Foundation
import SwiftyJSON
import Parse

class CryptoSettingsDataStore {
    func markQuizStatus(quizDatas: [QuizDataParse], shouldStartQuestionPrompt: Bool, currentIndex: Int?, currentQuizData: QuizDataParse, completion: @escaping (QuizTopicParse) -> Void) {
        var parameters: [String : Any] = ["shouldStartQuestionPrompt" : shouldStartQuestionPrompt,
                                          "quizDataID": currentQuizData.objectId ?? "",
                                          "quizDatas_length": quizDatas.count
        ]
        
        //is revealing answer
        if let currentIndex = currentIndex {
            parameters["correct_answer_index"] = AnswerKeysViewController.correct_indices[currentIndex]
            parameters["video_answer_url"] = AnswerKeysViewController.answer_video_urls[currentIndex]
        }
        
        PFCloud.callFunction(inBackground: "markQuizStatus", withParameters: parameters) { (result, error) in
            if let result = result {
                if shouldStartQuestionPrompt == true {
                    BannerAlert.show(title: "", subtitle: "Question Prompt Shown Successfully!", type: .success)

                } else {
                    BannerAlert.show(title: "", subtitle: "Answer Reveled Successfully!", type: .success)
                }
                
                if let quizTopic = result as? QuizTopicParse {
                    completion(quizTopic)
                }
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }

    func getPromoCodeRightAnswers(promoCode: String , completion: @escaping (Any?) -> Void) {
        var parameters: [String : Any] = ["promoCode" : promoCode]
       
        PFCloud.callFunction(inBackground: "getPromoCodeRightAnswers", withParameters: parameters) { (result, error) in
            if let result = result {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPromoCodeRightAnswers")
            }
        }
    }
    
    func sendMassNotification(completion: @escaping () -> Void) {
        PFCloud.callFunction(inBackground: "sendNotification", withParameters: nil) { (result, error) in
            if let msg = result as? String {
                BannerAlert.show(title: "Sent", subtitle: msg, type: .success)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }
}
