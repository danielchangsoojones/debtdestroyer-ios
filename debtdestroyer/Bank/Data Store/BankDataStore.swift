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
    var myDict = JSON()
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
    
    func loadDebtAccounts(completion: @escaping ([DebtAccountsParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getDebtAccounts", withParameters: nil) { (result, error) in
            if let acc = result  as? [DebtAccountsParse]  {
                completion(acc)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getDebtAccounts")
            }
        }
    }
    
    func loadPastWinners() {
        PFCloud.callFunction(inBackground: "getPastWinners", withParameters: nil) { (result, error) in
            if let acc = result as? JSON {
                self.myDict = acc
                
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPastWinners")
            }
        }
    }
}
