//
//  LegalDisclosuresViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/08/22.
//

import UIKit

class LegalDisclosuresViewController: UIViewController {
    private var tableView: UITableView!
    var dataArr = [String]()
    var imgNameArr = [String]()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = ["Privacy Policy", "Terms of Service", "Game Rules"]
        imgNameArr = ["legal", "legal","legal"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Legal Disclosures"
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(cellType: SettingsTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LegalDisclosuresViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsTableViewCell.self)
        cell.chevronImageView.image = UIImage.init(systemName: "arrow.up.forward")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        cell.titleLabel.text = dataArr[indexPath.row]
        cell.logoImg.image = UIImage.init(named: imgNameArr[indexPath.row])
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
            //Privacy Policy
            let url = URL(string: "https://www.debtdestroyer.app/privacy-policy")!
            UIApplication.shared.open(url)
        } else if indexPath.row == 1 {
            //Terms of Service
            let url = URL(string: "https://www.debtdestroyer.app/terms-and-services")!
            UIApplication.shared.open(url)
        } else if indexPath.row == 2 {
            //Game Rules
            let url = URL(string: "https://www.debtdestroyer.app/tie-breaker-rules")!
            UIApplication.shared.open(url)
        } 
        
    }
}

