//
//  SettingsDataStore.swift
//  nbawidget
//
//  Created by Daniel Jones on 7/7/22.
//

import Foundation
import Parse

class SettingsDataStore {
    func deleteAccount(completion: @escaping (Any?, Error?) -> Void) {
  
        PFCloud.callFunction(inBackground: "sendDeleteAccountEmail", withParameters: nil) { (result, error) in
            completion(result, error)
        }
    }
}
