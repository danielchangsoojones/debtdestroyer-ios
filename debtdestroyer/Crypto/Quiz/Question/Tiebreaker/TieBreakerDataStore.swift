//
//  TieBreakerDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/17/23.
//

import Foundation
import Parse

class TieBreakerDataStore {
    func getTiebreakerQuestions(completion: @escaping ([QuizDataParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getTiebreakerQuestions", withParameters: nil) { (results, error) in
            if let quizDatas = results as? [QuizDataParse] {
                completion(quizDatas)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getTiebreakerQuestions")
            }
        }
    }
}

