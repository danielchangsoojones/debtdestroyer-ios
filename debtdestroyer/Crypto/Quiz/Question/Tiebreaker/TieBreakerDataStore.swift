//
//  TieBreakerDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/17/23.
//

import Foundation
import Parse

class TieBreakerDataStore {
    func getTieQuizDatas(completion: @escaping ([QuizDataParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getTieBreakerQuestions", withParameters: [:]) { (result, error) in
            if let quizDatas = result as? [QuizDataParse] {
                completion(quizDatas)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getTieQuizDatas")
            }
        }
    }
}

