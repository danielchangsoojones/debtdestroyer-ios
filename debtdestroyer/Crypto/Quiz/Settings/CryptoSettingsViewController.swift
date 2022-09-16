//
//  CryptoSettingsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit
import SCLAlertView

class CryptoSettingsViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    var dataArr = [String]()
    var imgNameArr = [String]()
    private var debtAccountsData: [DebtAccountsParse] = []
    private let dataStore = BankDataStore()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDebtAccounts()
        messageHelper = MessageHelper(currentVC: self)
        dataArr = ["Contact Us", "Leave Feedback", "Logout", "Delete Account"]
        
        imgNameArr = ["contactUs", "feedback","logout", "deleteAcc"]
        
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.tintColor = .black
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
    
    private func loadDebtAccounts() {
        dataStore.loadDebtAccounts { debtAccounts in
            self.debtAccountsData = debtAccounts
            self.tableView.reloadData()
        }
    }
    
}

extension CryptoSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsTableViewCell.self)
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
        if indexPath.row == 0 || indexPath.row == 1 {
            // MARK: Contact Us
            // MARK: Leave Feedback
            messageHelper?.text("3176905323", body: "")
        } else if indexPath.row == 2 {
            // MARK: Logout
            User.logOutInBackground { error in
                if let error = error {
                    BannerAlert.show(with: error)
                } else {
                    //successfully logged out
                    let welcomeVC = WelcomeViewController()
                    let navController = UINavigationController(rootViewController: welcomeVC)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true)
                }
            }
        } else {
            // MARK: Delete Account
            let vc = DeleteAccountViewController()
            self.navigationController?.pushViewController(vc.self, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footer.backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x:10,y: 10 ,width:footer.frame.width - 20,height:50))
        titleLabel.textColor = .systemGray2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        titleLabel.text  = "Version " + appVersion!
        footer.addSubview(titleLabel)
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 70
    }
}
