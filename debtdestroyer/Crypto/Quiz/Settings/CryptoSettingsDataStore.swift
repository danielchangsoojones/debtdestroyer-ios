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
    func markQuizStatus(shouldStartQuestionPrompt: Bool, shouldRevealAnswer: Bool, currentQuizData: QuizDataParse, completion: @escaping (Any?) -> Void) {
        let parameters: [String : Any] = ["shouldStartQuestionPrompt" : shouldStartQuestionPrompt,
                                          "shouldRevealAnswer" : shouldRevealAnswer,
                                          "quizDataID": currentQuizData.objectId ?? ""
        ]
        PFCloud.callFunction(inBackground: "markQuizStatus", withParameters: parameters) { (result, error) in
            if let result = result {
                
                if shouldStartQuestionPrompt == true {
                    BannerAlert.show(title: "", subtitle: "Question Prompt Shown Successfully!", type: .success)

                } else {
                    BannerAlert.show(title: "", subtitle: "Answer Reveled Successfully!", type: .success)
                }

                let json = JSON(result)
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }
    
    func finishQuizTime(completion: @escaping (Any?) -> Void) {
        
        PFCloud.callFunction(inBackground: "finishQuizTime", withParameters: nil) { (result, error) in
            if let result = result {
                
                BannerAlert.show(title: "", subtitle: "finish Quiz Time called Successfully!", type: .success)
                
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }
}
