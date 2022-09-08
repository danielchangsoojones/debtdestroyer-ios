//
//  SubscriptionDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/09/22.
//

import Foundation
import Parse

class SubscriptionDataStore {
    func upgradeToPremiumSubscription(completion: @escaping (Any?, Error?) -> Void) {
        
        PFCloud.callFunction(inBackground: "upgradeToPremiumSubscription", withParameters: nil) { (result, error) in
            completion(result, error)
        }
    }
}

