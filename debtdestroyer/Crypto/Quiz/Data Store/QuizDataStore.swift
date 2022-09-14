//
//  QuizDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import Foundation
import Parse

class QuizDataStore {
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
    
    func saveCryptoAddress(completion: @escaping ([CryptoAddressParse]) -> Void) {
        PFCloud.callFunction(inBackground: "saveCryptoAddress", withParameters: nil) { (result, error) in
            if let cryptoAddress = result as? [CryptoAddressParse] {
                completion(cryptoAddress)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "saveCryptoAddress")
            }
        }
    }
}
