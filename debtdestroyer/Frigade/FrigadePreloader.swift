//
//  FrigadePreloader.swift
//  debtdestroyer
//
//  Created by Christian Mathiesen on 2/8/23.
//

import Foundation
import Frigade

class FrigadePreloader {
    var welcomePage: FrigadeFlow? = nil
    var signUpFlow: FrigadeFlow? = nil
    
    static let shared = FrigadePreloader()

    func preloadFlows(completionHandler: @escaping ()->Void) {
        FrigadeProvider.load(flowId: "flow_MrRLoskD7ZI4jWyg") { result in
            switch result {
            case .success(let flow):
                self.welcomePage = flow
                completionHandler()
            case .failure(let error):
                NSLog("Error loading flow. Reason: \(error.localizedDescription)")
                completionHandler()
            }
        }
        FrigadeProvider.load(flowId: "flow_ijpI6Rf9njptzx67") { result in
            switch result {
            case .success(let flow):
                self.signUpFlow = flow
            case .failure(let error):
                NSLog("Error loading flow. Reason: \(error.localizedDescription)")
            }
        }
    }
}
