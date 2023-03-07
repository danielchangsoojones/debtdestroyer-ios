//
//  PromoDataStore.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/5/23.
//

import Foundation
import Parse
import SwiftyJSON

class PromoDataStore {
    func getPromoInfo(completion: @escaping ([PromoCodeUsedViewController.PromoUser], String, String) -> Void) {
        PFCloud.callFunction(inBackground: "getPromoInfo", withParameters: nil) { (results, error) in
            if let results = results {
                let json = JSON(results)
                let personalPromo = json["personal_promo"].stringValue
                let promo_info_detail = json["promo_info_detail"].stringValue
                var users: [User] = []
                if let dict = json.dictionaryObject, let usersFromDict = dict["users"] as? [User] {
                    users = usersFromDict
                }
                let promoUsers = users.map { user in
                    let promoUser = PromoCodeUsedViewController.PromoUser(user: user)
                    return promoUser
                }
                
                if !personalPromo.isEmpty {
                    User.current()?.personalPromo = personalPromo
                }
                
                completion(promoUsers, personalPromo, promo_info_detail)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPromoInfo")
            }
        }
    }
}
