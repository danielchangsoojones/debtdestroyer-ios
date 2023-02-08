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
    func markQuizStatus(shouldStartQuestionPrompt: Bool, currentIndex: Int?, currentQuizData: QuizDataParse, completion: @escaping (Any?) -> Void) {
        var parameters: [String : Any] = ["shouldStartQuestionPrompt" : shouldStartQuestionPrompt,
                                          "quizDataID": currentQuizData.objectId ?? ""
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

                let json = JSON(result)
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "markQuizStatus")
            }
        }
    }
}
