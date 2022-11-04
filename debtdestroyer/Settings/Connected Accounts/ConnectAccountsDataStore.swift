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
}
