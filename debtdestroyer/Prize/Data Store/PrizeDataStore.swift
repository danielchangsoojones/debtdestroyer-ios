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
    var pastWinnersJSON = JSON()
    var pastWinnersJSONArr = [JSON]()

    func savingsInfo() {
        PFCloud.callFunction(inBackground: "getSavingsInfo", withParameters: nil) { (result, error) in
            if let data = result {
                self.saveSavingsToUserDefaults(savings: JSON(data))
                self.savingsInfoJSON = JSON(data)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getSavingsInfo")
            }
        }
    }
   
    private func saveSavingsToUserDefaults(savings : JSON) {
        UserDefaults.standard.set(savings["progress_meter_title"].stringValue, forKey: "progress_meter_title")
        UserDefaults.standard.synchronize()
    }
    
    func getTickets(completion: @escaping (Int) -> Void) {
        PFCloud.callFunction(inBackground: "getTickets", withParameters: nil) { (result, error) in
            if let ticketAmount = result as? Int {
                completion(ticketAmount)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getTickets")
            }
        }
    }
    
    func loadPastWinners(completion: @escaping ([WinnerParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getPastWinners", withParameters: nil) { (result, error) in
            if let winners = result  as? [WinnerParse]  {
                completion(winners)
            }
            else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getPastWinners")
            }
        }
    }

    func sweepstakesInfo() {
        PFCloud.callFunction(inBackground: "getSweepstakesInfo", withParameters: nil) { (result, error) in
            if let data = result {
                self.saveSweepstakesInfoToUserDefaults(info: JSON(data))
                self.sweepstakesInfoJSON = JSON(data)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getSweepstakesInfo")
            }
        }
    }
    
    private func saveSweepstakesInfoToUserDefaults(info : JSON) {
        
        UserDefaults.standard.set(info["deadlineTxt"].stringValue, forKey: "deadlineTxt")
        UserDefaults.standard.set(info["prizeAmountTxt"].stringValue, forKey: "prizeAmountTxt")
        UserDefaults.standard.set(info["title"].stringValue, forKey: "title")
        
        UserDefaults.standard.synchronize()
    }
    
    func checkIfMethodAuthed(completion: @escaping (Bool) -> Void) {
        PFCloud.callFunction(inBackground: "checkIfMethodAuthed", withParameters: nil) { (result, error) in
            if let isAuthed = result as? Bool {
               completion(isAuthed)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "checkIfMethodAuthed")
            }
        }
    }

}
