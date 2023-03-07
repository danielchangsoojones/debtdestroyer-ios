//
//  Notification.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/7/23.
//

import Foundation
import UserNotifications
import Parse

class DDNotification {
    static func saveNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            var status = "notDetermined"
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                status = "authorized"
            case .denied:
                status = "denied"
            case .notDetermined:
                break
            @unknown default:
                break
            }
            
            self.saveNotificationPreference(status: status)
        }
    }
    
    private static func saveNotificationPreference(status: String) {
        User.current()?.notificationStatus = status
        User.current()?.saveInBackground()
        
//        var parameters: [String : Any] = ["status" : status]
//        PFCloud.callFunction(inBackground: "saveNotificationStatus", withParameters: parameters) { (result, error) in
//            if let result = result as? String {
//                print(result)
//            } else if let error = error {
//                BannerAlert.show(with: error)
//            } else {
//                BannerAlert.showUnknownError(functionName: "saveNotificationStatus")
//            }
//        }
    }
    
    static func saveNotificationDesire(desire: String) {
        User.current()?.notificationDesire = desire
        User.current()?.saveInBackground()
    }
}
