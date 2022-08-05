//
//  SettingsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 04/08/22.
//

import UIKit
import SCLAlertView

class SettingsViewController: UIViewController {
    private var tableView: UITableView!
    var dataArr = [String]()
    var imgNameArr = [String]()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = ["Notifications", "Appearance", "Privacy & Safety", "Leave Feedback", "Invites", "Terms of Service", "Privacy Policy", "Logout", "Delete Account"]
        
        imgNameArr = ["bankC", "bankC","bankC", "bankC","bankC", "bankC","bankC", "bankC","bankC"]
    }
    
    
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(cellType: SettingsTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsTableViewCell.self)
        
        cell.titleLabel.text = dataArr[indexPath.row]
        if indexPath.row == 8 {
            cell.titleLabel.textColor = .red
        }
        cell.logoImg.image = UIImage.init(named: imgNameArr[indexPath.row])
        if indexPath.row == 5 || indexPath.row == 6 {
            cell.chevronImageView.image = UIImage.init(systemName: "arrow.up.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        } else {
            cell.chevronImageView.image = UIImage(named: "chevronGrey")
        }
        if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7 {
            cell.whitePadding()
            cell.setLine(check: true)
            cell.whitePadding()
        }else{
            cell.setLine(check: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            //Notifications
        } else if indexPath.row == 1 {
            //Appearance
        } else if indexPath.row == 2 {
            //Privacy & Safety
        } else if indexPath.row == 3 {
            //Leave Feedback
        } else if indexPath.row == 4 {
            //Invites
        } else if indexPath.row == 5 {
            //Terms of Service
        } else if indexPath.row == 6 {
            //Privacy Policy
        } else if indexPath.row == 7 {
            //Logout
        } else {
            //Delete Account
        }
        
    }
}
