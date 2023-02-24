//
//  CryptoSettingsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit
import SCLAlertView

class CryptoSettingsViewController: UIViewController {
    
    enum cell: Int {
        case winnerInfo
        case connectedAccounts
        case contactUs
        case legaDisclosure
        case leaveFeedback
        case notification
        case logOut
        case deleteAcc
        case textNoti
        case answerKeys
        case quizQuestions
    }
    
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    var dataArr = [String]()
    var imgNameArr = [String]()
    private let quizDataStore = QuizDataStore()
    private let cryptoSettingsDataStore = CryptoSettingsDataStore()

    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        dataArr = ["Enter Winner Information", "Connected Accounts", "Contact Us", "Legal Disclosures", "Leave Feedback", "Notification Settings", "Log Out", "Delete Account"]

        imgNameArr = ["legal", "accounts", "contactUs", "legal", "feedback", "contactUs", "logout", "deleteAcc"]
        
        if User.current()!.email == "messyjones@gmail.com" {
            dataArr.append("Send Text Notification")
            imgNameArr.append("contactUs")
            dataArr.append("Answer Keys")
            imgNameArr.append("contactUs")
        }
        
        if (User.current()?.isAdminUser ?? false) {
            dataArr.append("Quiz Questions")
            imgNameArr.append("contactUs")
        }
              
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
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
        
        switch cell(rawValue: indexPath.row)! {
            case .winnerInfo:
                // MARK: Enter Winner Information
                let url = URL(string: "https://airtable.com/shr4ZTlvbRUqAGswk")!
                UIApplication.shared.open(url)
                
            case .connectedAccounts:
                // MARK: Connected Accounts
                let vc = ConnectedAccountsViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
            case .contactUs, .leaveFeedback:
                // MARK: Contact Us
                // MARK: Leave Feedback
                messageHelper?.text("3176905323", body: "")
                
            case .legaDisclosure:
                let vc = LegalDisclosuresViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
            case .notification:
                // MARK: Notification
                let vc = NotificationViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
                
            case .logOut:
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
                
            case .deleteAcc:
                // MARK: Delete Account
                let vc = DeleteAccountViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
            case .textNoti:
                // MARK: Send Text Notification
                if User.sendMassTextNotification == false {
                    
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    let alertView = SCLAlertView(appearance: appearance)
                    
                    alertView.addButton("Send") {
                        
                        self.quizDataStore.sendMassTextNotification {
                            print("success")
                            User.sendMassTextNotification = true
                            BannerAlert.show(title: "Notification send successfully!", subtitle: "", type: .success)
                        }
                        
                    }
                    
                    alertView.addButton("Cancel") {
                        
                    }
                    alertView.showNotice("", subTitle: "Are you sure you want to send a mass text notification?")
                }
                
            case .answerKeys:
                // MARK: Answer Keys
                let vc = AnswerKeysViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
            case .quizQuestions:
                // MARK: Answer Keys
                let vc = QuizQuestionsViewController()
                self.navigationController?.pushViewController(vc.self, animated: true)
                
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footer.backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x:10,y: 10 ,width:footer.frame.width - 20,height:50))
        titleLabel.textColor = .systemGray2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.MontserratRegular(size: 15)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        titleLabel.text  = "Version " + appVersion!
        footer.addSubview(titleLabel)
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 70
    }
}
