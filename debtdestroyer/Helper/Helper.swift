//
//  Helper.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/08/22.
//

import Foundation
import UIKit
import SystemConfiguration


func dateTimeStatus(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    if let dt = dateFormatter.date(from: date) {
        let userFormatter = DateFormatter()
        userFormatter.dateStyle = .medium // Set as desired
        userFormatter.timeStyle = .medium // Set as desired
        
        return userFormatter.string(from: dt)
    } else {
        return "Unknown date"
    }
}
