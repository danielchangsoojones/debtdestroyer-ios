//
//  NotificationViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/02/23.
//

import UIKit
import UserNotifications
import SCLAlertView

class NotificationViewController: UIViewController {
    
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    var dataArr = [String]()
    private let cryptoSettingsDataStore = CryptoSettingsDataStore()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        dataArr = ["Notification Status"]
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
            // Enable or disable features based on authorization
            DDNotification.saveNotificationStatus()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              // your code here
                if !granted {
                    let alert = SCLAlertView()
                    alert.showInfo("You denied notification access", subTitle: "You denied notification access to turn it on. Go into your iPhone settings -> notifications. And enable them for debt destroyer. Then, restart the app.")
                }
                self.tableView.reloadData()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSegmentForNotification(_:)), name: NSNotification.Name(rawValue: "toggleSegmentForNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func toggleSegmentForNotification(_ notification: Notification) {
        if let nextIndex = notification.object as? Int {
            if nextIndex == 1 {
                //on
                DDNotification.saveNotificationDesire(desire: "on")
            } else {
                //off
                DDNotification.saveNotificationDesire(desire: "off")
            }
        }
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(cellType: NotificationTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NotificationTableViewCell.self)
        cell.titleLabel.text = dataArr[indexPath.row]
        
        let shouldBeOn = User.current()?.notificationDesire == "on" || User.current()?.notificationDesire == nil
        if shouldBeOn && User.current()?.notificationStatus == "authorized" {
            cell.toggleSegment.selectedIndex = 0
        } else {
            cell.toggleSegment.selectedIndex = 1
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
