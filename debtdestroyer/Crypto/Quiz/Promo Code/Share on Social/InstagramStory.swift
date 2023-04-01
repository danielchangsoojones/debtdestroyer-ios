//
//  Share.swift
//  hoosier-riders
//
//  Created by Daniel Jones on 5/1/20.
//  Copyright © 2020 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class InstagramStory {
    static func sharePhoto(data: Data, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        openInstagram(with: data, pasteboardType: "com.instagram.sharedSticker.backgroundImage", completion: completion)
    }
    
    static func shareVideo(url: String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        Helpers.loadDataFromURL(string: url) { (data, error) in
            if let data = data {
                openInstagram(with: data,
                              pasteboardType: "com.instagram.sharedSticker.backgroundVideo",
                              completion: completion)
            } else {
                completion(false, error ?? "unknown error with instagram sharing")
            }
        }
    }
    
    static func openInstagram(with data: Data, pasteboardType: String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        DispatchQueue.main.async {
            //must bring it back to the main thread now
            if let urlScheme = URL(string: "instagram-stories://share"), UIApplication.shared.canOpenURL(urlScheme) {
                setPasteboard(data: data, pasteboardType: pasteboardType)
                UIApplication.shared.open(urlScheme, options: [:]) { (success) in
                    if success {
                        completion(success, nil)
                    } else {
                        completion(false, "error opening instagram")
                    }
                }
            } else {
                completion(false, "Error opening instagram")
            }
        }
    }
    
    //Instagram stories uses the users pasteboard to decide what to post
    private static func setPasteboard(data: Data, pasteboardType: String) {
        let pasteboardItems = [[pasteboardType: data]]
        let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [.expirationDate: Date().addingTimeInterval(60 * 5)]
        UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
    }
    
    static func checkIfAppOnPhone() -> Bool {
        return Helpers.checkIfAppOnPhone(appName: "instagram-stories")
    }
}
