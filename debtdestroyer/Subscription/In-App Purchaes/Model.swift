//
//  Model.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/09/22.
//

import Foundation
import StoreKit

class Model {

    var products = [SKProduct]()
    struct SubscriptionData: Codable, SettingsManageable {
   
        var didUnlockDiamondSubscription = false
    }

    var subscriptionData = SubscriptionData()
    
    init() {
        _ = subscriptionData.load()

    }
    
    func getProduct(containing keyword: String) -> SKProduct? {
        return products.filter { $0.productIdentifier.contains(keyword) }.first
    }
}
