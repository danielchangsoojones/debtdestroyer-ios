//
//  PrizeDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/08/22.
//

import Foundation
import Parse

class PrizeDataStore {
    func savingsInfo() {
        PFCloud.callFunction(inBackground: "getSavingsInfo", withParameters: nil) { (result, error) in
            if let savings = result {
                self.saveSavingsToUserDefaults(savings: savings as! NSDictionary)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getSavingsInfo")
            }
        }
    }
   
    private func saveSavingsToUserDefaults(savings : NSDictionary) {
        
        UserDefaults.standard.set(savings.value(forKey: "progress_meter_title") as! String, forKey: "progress_meter_title")
        UserDefaults.standard.set(savings.value(forKey: "ticketCount"), forKey: "ticketCount")
        UserDefaults.standard.set(savings.value(forKey: "totalAmountPaidToLoan"), forKey: "totalAmountPaidToLoan")
        
        UserDefaults.standard.synchronize()
    }

}
