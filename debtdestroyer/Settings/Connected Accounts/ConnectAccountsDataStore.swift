//
//  ConnectAccountsDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 11/4/22.
//

import Foundation
import Parse
import SwiftyJSON

class ConnectAccountsDataStore {
    struct DebtAccount {
        let debtAccountParse: DebtAccountsParse
        let last_payment_ticket_amount: Int
    }
    
    func createMethodEntityAndAuthToken(completion: @escaping (String?, String?, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "createMethodEntityAndAuthToken", withParameters: [:]) { (result, error) in
            if let result = result {
                let json = JSON(result)
                let entity_id = json["entity_id"].string
                let auth_element_url = json["auth_element_url"].string
                completion(entity_id, auth_element_url, nil)
            } else {
                completion(nil, nil, error)
            }
        }
    }
    
    func loadDebtAccounts(completion: @escaping ([DebtAccount]) -> Void) {
        PFCloud.callFunction(inBackground: "getDebtAccounts", withParameters: nil) { (results, error) in
            if let results = results {
                let json = JSON(results)
                let array = json.arrayValue
                let debtAccounts = array.map { json in
                    let last_payment_ticket_amount = json["last_payment_ticket_amount"].intValue
                    let dict = json.dictionaryObject
                    let debtAccountParse = (dict?["debtAccount"] as? DebtAccountsParse) ?? DebtAccountsParse()
                    let debtAccount = DebtAccount(debtAccountParse: debtAccountParse,
                                                  last_payment_ticket_amount: last_payment_ticket_amount)
                    return debtAccount
                }
                completion(debtAccounts)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getDebtAccounts")
            }
        }
    }
}
