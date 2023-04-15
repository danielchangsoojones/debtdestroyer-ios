//
//  CryptoSettingsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 16/09/22.
//

import UIKit
import SCLAlertView
import StoreKit

class CryptoSettingsViewController: UIViewController {
    enum CellType: String {
        case winnerInfo = "Enter Winner Information"
        case connectedAccounts = "Verify Identity"
        case promoCode = "Promo Code"
        case contactUs = "Share Feedback"
        case legaDisclosure = "Legal Disclosures"
        case notification = "Notifications"
        case logOut = "Log Out"
        case deleteAcc = "Delete Account"
        case textNoti = "Send Text Notification"
        case answerKeys = "Answer Keys"
        case quizQuestions = "Quiz Questions"
        case rateUs = "Rate Us on App Store"
        case orderSwag = "Buy Swag"
        case socials = "Follow Us"
        
        var imageName: String {
            switch self {
            case .winnerInfo, .legaDisclosure, .answerKeys, .quizQuestions:
                return "legal"
            case .connectedAccounts:
                return "accounts"
            case .contactUs:
                return "contactUs"
            case .logOut:
                return "logout"
            case .deleteAcc:
                return "deleteAcc"
            case .notification, .textNoti:
                return "Bell"
            case .promoCode:
                return "invite"
            case .rateUs:
                return "feedback"
            case .orderSwag:
                return "swag"
            case .socials:
                return "socialsBtnImage"
            }
        }
    }
    
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    private var dataArr: [CellType] = []
    private let quizDataStore = QuizDataStore()
    private let cryptoSettingsDataStore = CryptoSettingsDataStore()
    private let prizeDataStore = PrizeDataStore()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        dataArr = [.notification, .contactUs, .rateUs, .socials, .winnerInfo, .legaDisclosure, .logOut, .deleteAcc]
        
        if !(User.isAppleTester) {
            dataArr.insert(.promoCode, at: 0)
            dataArr.insert(.orderSwag, at: 1)
        }
        
        if (User.current()?.showConnectAccount ?? false) {
            dataArr.insert(.connectedAccounts, at: 2)
        }
        
        if User.isAdminUser {
            dataArr.append(.textNoti)
            dataArr.append(.answerKeys)
            dataArr.append(.quizQuestions)
        }
        
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        cell.titleLabel.text = dataArr[indexPath.row].rawValue
        cell.logoImg.image = UIImage.init(named: dataArr[indexPath.row].imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = dataArr[indexPath.row]
        switch cellType {
        case .winnerInfo:
            // MARK: Enter Winner Information
            let url = URL(string: "https://airtable.com/shr4ZTlvbRUqAGswk")!
            UIApplication.shared.open(url)
            
        case .connectedAccounts:
            // MARK: Connected Accounts
            prizeDataStore.checkIfMethodAuthed { isAuthed in
                if isAuthed {
                    let connectedAccountsVC = ConnectedAccountsViewController()
                    self.navigationController?.pushViewController(connectedAccountsVC, animated: true)
                } else {
                    let vc = ConnectDisclosureViewController()
                    self.navigationController?.pushViewController(vc.self, animated: true)
                }
            }
        case .promoCode:
            // MARK: Promo Code
            let vc = PromoCodeUsedViewController(shouldShowSkipBtn: false)
            Haptics.shared.play(.heavy)
            self.navigationController?.pushViewController(vc.self, animated: true)
        case .contactUs:
            // MARK: Contact Us
            // MARK: Leave Feedback
            messageHelper?.text(MessageHelper.customerServiceNum, body: "")
            
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
                    self.cryptoSettingsDataStore.sendMassNotification {
                        User.sendMassTextNotification = true
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
        case .rateUs:
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                //TODO: need to confirm in production if this takes you to the app store review page
                let appID = "1639968618"
                let urlStr = "itms-apps://itunes.apple.com/us/app/itunes-u/id\(appID)?ls=1&mt=8&action=write-review"
                guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        case .orderSwag:
            let swagPage = NotionViewController(notionURL: "https://dankwun.notion.site/Debt-Destroyer-Swag-aeec29bb9b4948db9dffa105ebba7a12")
            self.navigationController?.pushViewController(swagPage.self, animated: true)
            
        case .socials:
            let alertController = UIAlertController(title: "Socials", message: nil, preferredStyle: .actionSheet)
            
            let socials = ["TikTok": "https://www.tiktok.com/@debtdestroyer", "Twitter": "https://www.twitter.com/debtdestroyer_"]
            for (title, link) in socials {
                let action = UIAlertAction(title: title, style: .default) { (_) in
                    if let url = URL(string: link) {
                        UIApplication.shared.open(url)
                    }
                }
                alertController.addAction(action)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = (self as AnyObject).bounds
            }
            
            present(alertController, animated: true, completion: nil)
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
