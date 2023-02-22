//
//  ReminderTextNotificationViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/02/23.
//

import UIKit

class ReminderTextNotificationViewController: UIViewController {
    
    private var enableButton: GradientBtn!
    private var noThanksButton = UIButton()
    var notiView = ReminderTextNotificationView()
    var color1 = UIColor()
    var color2 = UIColor()

    override func loadView() {
        super.loadView()
        notiView = ReminderTextNotificationView(frame: self.view.frame)
        self.view = notiView
        noThanksButton = notiView.noThanksButton
        notiView.noThanksButton.addTarget(self, action: #selector(noThanksPressed), for: .touchUpInside)
        notiView.enableButton.addTarget(self, action: #selector(enableReminderTextsPressed), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @objc private func noThanksPressed() {
        self.dismiss(animated: true)
    }
    
    @objc private func enableReminderTextsPressed() {
//        let vc =
//        navigationController?.pushViewController(vc, animated: true)
    }
        
}
