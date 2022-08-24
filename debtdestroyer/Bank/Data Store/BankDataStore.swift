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
    
    var transactionHistoryJSON = JSON()

    func transactionHistory() {
        PFCloud.callFunction(inBackground: "getTransactions", withParameters: nil) { (result, error) in
            if let transactions = result {
                print("transactions",transactions)
                self.transactionHistoryJSON = transactions as! JSON
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getTransactions")
            }
        }
    }

    
}
