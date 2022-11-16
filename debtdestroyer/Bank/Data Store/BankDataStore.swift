//
//  BankDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/08/22.
//

import Foundation
import Parse
import SwiftyJSON

class BankDataStore {
    func loadTransactionHistory(completion: @escaping ([TransactionParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getTransactions", withParameters: nil) { (result, error) in
            if let transactions = result as? [TransactionParse] {
                completion(transactions)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getTransactions")
            }
        }
    }
}
