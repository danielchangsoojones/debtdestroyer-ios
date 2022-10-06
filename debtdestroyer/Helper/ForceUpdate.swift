//
//  ForceUpdate.swift
//  lookbook
//
//  Created by Daniel Jones on 2/12/22.
//

import Foundation
import Parse
import SCLAlertView

class ForceUpdate {
    static func checkIfForceUpdate() {
        let version_str = Helpers.getVersionStr()
        if let version_str = version_str {
            let parameters: [String : Any] = ["app_version" : version_str, "deviceType": "ios"]
            PFCloud.callFunction(inBackground: "checkForceUpdate", withParameters: parameters) { (result, error) in
                if let mustUpdate = result as? Bool {
                    if mustUpdate {
                        showAlert()
                    }
                } else if let error = error {
                    print(error)
                } else {
                    print("unknown error with the checkForceUpdate call")
                }
            }
        }
    }
    
    private static func showAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Update", action: {
            //TODO: a bitly link for now until we get the actual app link
            Helpers.open(urlString: "https://apps.apple.com/us/app/lavadrop/id1639968618")
        })
        alertView.showSuccess("Update App", subTitle: "There is a new Pinscope version available. Please update your app!")
    }
}
