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
        let parameters: [String : Any] = ["version_str" : versionStr, "deviceType": "ios"]
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
    
    func shouldShowNextQuiz(completion: @escaping (Bool, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "checkNewQuiz", withParameters: [:]) { (result, error) in
            if let shouldShowNewQuiz = result as? Bool {
                completion(shouldShowNewQuiz, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
