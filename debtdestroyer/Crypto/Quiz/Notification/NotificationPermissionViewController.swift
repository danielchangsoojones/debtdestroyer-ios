//
//  NotificationPermissionViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 07/10/22.
//

import UIKit

class NotificationPermissionViewController: UIViewController, UNUserNotificationCenterDelegate {

    private var allowBtn = SpinningWithGradButton()

    override func loadView() {
        super.loadView()
        let notificationView = NotificationPermissionView(frame: self.view.frame)
        self.view = notificationView

        self.allowBtn = notificationView.allowBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        self.allowBtn.addTarget(self,action: #selector(allowNotifications),for: .touchUpInside)

    }
    
    @objc private func allowNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else {
                return
            }
        }
        print("Success")
        
    }
    
}

