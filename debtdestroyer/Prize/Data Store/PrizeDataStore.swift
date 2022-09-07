//
//  PrizeDataStore.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/08/22.
//

import Foundation
import Parse
import SwiftyJSON

class PrizeDataStore {
    var sweepstakesInfoJSON = JSON()
    var savingsInfoJSON = JSON()

    func savingsInfo() {
        PFCloud.callFunction(inBackground: "getSavingsInfo", withParameters: nil) { (result, error) in
            if let data = result {
                self.saveSavingsToUserDefaults(savings: data as! NSDictionary)
                self.savingsInfoJSON = JSON(data)
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
    
    func loadPastWinners(completion: @escaping ([WinnerParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getPastWinners", withParameters: nil) { (result, error) in
            if let winners = result  as? [WinnerParse]  {
                completion(winners)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPastWinners")
            }
        }
    }

    func sweepstakesInfo() {
        PFCloud.callFunction(inBackground: "getSweepstakesInfo", withParameters: nil) { (result, error) in
            if let data = result {
                self.sweepstakesInfoJSON = JSON(data)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getSweepstakesInfo")
            }
        }
    }

}
