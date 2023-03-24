//
//  BestChampionsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import SCLAlertView
import UIKit

class ChampionsViewController: UIViewController {
    private var tableView: UITableView!
//    private var quizTopic: QuizTopicParse?
    private var quizScores: [LeaderboardDataStore.QuizScore] = []
    private var pastWinnersData: [WinnerParse] = []
    private let dataStore = LeaderboardDataStore()

    private var messageHelper: MessageHelper?
    private var bottomView = UIView()
    private var containerView = UIView()
    private var numberLabel = UILabel()
    private var nameLabel = UILabel()
    private var pointsLabel = UILabel()
    private var tweetText = String()
    private var timeLable = UILabel()
    private var toggleSegment = HBSegmentedControl()
    
    override func loadView() {
        super.loadView()
        let championsView = ChampionsView(frame: self.view.frame)
        self.view = championsView
        self.tableView = championsView.leaderboardTableView
        //        self.descriptionLabel = championsView.descriptionLabel
        self.bottomView = championsView.bottomView
        self.containerView = championsView.containerView
        self.numberLabel = championsView.numberLabel
        self.nameLabel = championsView.nameLabel
        self.pointsLabel = championsView.pointsLabel
        self.toggleSegment = championsView.toggleSegment
        toggleSegment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: UIControl.Event.valueChanged)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setLeaderboardTableView()
    }
    
    override func viewWillLayoutSubviews() {
        self.bottomView.addTopRoundedCornerToView(targetView: bottomView, desiredCurve: 10.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarBtns()
        self.tabBarController?.tabBar.isHidden = false
        loadLeaderboard()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }// code not working yet
    
    override func viewDidAppear(_ animated: Bool) {
        self.bottomView.setGradientBackground()
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.hidesBackButton = true
        
        let help = UIBarButtonItem.init(title: "help?", style: .done, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
        
        let inviteBtn = UIBarButtonItem.init(title: "Invite", style: .done, target: self, action: #selector(invitePressed))
        navigationItem.leftBarButtonItem = inviteBtn
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if toggleSegment.selectedIndex == 0 {
            print("Leaderboard")
        } else {
            print("Past Winners")
        }
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
        //        shareOnTwitter()
    }
    
    @objc private func invitePressed() {
        Haptics.shared.play(.heavy)
        let vc = PromoCodeUsedViewController(shouldShowSkipBtn: false)
        self.navigationController?.pushViewController(vc.self, animated: true)
    }
    
    private func shareOnTwitter() {
        
        let tweetUrl = "https://apps.apple.com/app/id1639968618"
        
        let appURL = "twitter://intent/tweet?text=\(self.tweetText)&url=\(tweetUrl)"
        let webURL = "https://twitter.com/intent/tweet?text=\(self.tweetText)&url=\(tweetUrl)"
        
        let appURLescapedShareString = appURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let webURLescapedShareString = webURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlapp = URL(string: appURLescapedShareString)!
        let urlweb = URL(string: webURLescapedShareString)!
        
        
        if UIApplication.shared.canOpenURL(urlapp as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(urlapp)
            } else {
                UIApplication.shared.openURL(urlapp)
            }
        } else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(urlweb)
            } else {
                UIApplication.shared.openURL(urlweb)
            }
        }
        
    }
    
    private func setLeaderboardTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: LeaderboardTableCell.self)
    }
    
    private func loadLeaderboard() {
        dataStore.getLeaderBoard { quizScores, deadlineMessage in
            
            //            if quizScores.isEmpty {
            //                self.containerView.backgroundColor = .clear
            //                self.tableView.backgroundColor = .clear
            //            } else {
            //                self.containerView.backgroundColor = .white
            //                self.tableView.backgroundColor = .white
            //            }
            self.quizScores = quizScores
            
            self.tableView.reloadData()
            
            // MARK: This code will update info in bottom view if user never attended quiz before... No entry in table for current user.
            self.nameLabel.text = User.current()?.fullName.capitalized
            self.pointsLabel.text = " 0 "
            self.numberLabel.text = String(quizScores.count + 1) + ". "
            self.timeLable.text = "NA"
            self.tweetText = "Hey.. I have earned 0 Points and scored \(quizScores.count + 1)."
            
            // MARK: this code will update info in bottom view if user attended quiz before
            var index = 1
            for quizScore in quizScores {
                if User.current()?.objectId == quizScore.user.objectId {
                    self.nameLabel.text = quizScore.user.fullName.capitalized
                    self.pointsLabel.text = " " + String(quizScore.points)
                    self.numberLabel.text = String(index) + ". "
                    self.timeLable.text = String(quizScore.total_time_str)
                    self.tweetText = "Hey.. I have earned \(quizScore.points) Points and scored \(index)."
                    
                    return
                }
                index += 1
            }
        }
        
//            dataStore.loadPastWinners { pastWinners in
//                self.pastWinnersData = pastWinners
//                //            self.tableView.reloadData()
//            }
    }
}

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LeaderboardTableCell.self)
        let quizScore = quizScores[indexPath.row]
        cell.numberLabel.text = String(indexPath.row + 1) + ". "
        var name = quizScore.user.fullName.capitalized
        let isInvitedUser = quizScore.user.promoCode == User.current()?.personalPromo
        if User.isAdminUser {
            name += " (\(quizScore.user.promoCode ?? "")))"
        } else if let personalPromo = User.current()?.personalPromo, isInvitedUser {
            name += " (\(personalPromo))"
        }
        
        cell.nameLabel.text = name
        
        cell.pointsLabel.text = String(quizScore.points)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if User.isAdminUser || User.isSemiAdmin {
            let quizScore = quizScores[indexPath.row]
            let user = quizScore.user
            let promoCode = user.promoCode
            
            if let promoCode = promoCode, !promoCode.isEmpty {
                dataStore.getFriendInvite(invitingPromo: promoCode) { invitingUser in
                    self.showPromoAlert(user: user, invitingUser: invitingUser)
                }
            } else {
                showPromoAlert(user: user, invitingUser: nil)
            }
        }
    }
    
    private func showPromoAlert(user: User, invitingUser: User?) {
        let contactNumber = user.phoneNumber
        if contactNumber.removeWhitespaces() == ""  {
            BannerAlert.show(title: "", subtitle: "Contact number not available!", type: .info)
        } else {
            let alertView = SCLAlertView()
            alertView.addButton("Text User") {
                self.messageHelper?.text(contactNumber)
            }
            
            if let invitingUser = invitingUser {
                alertView.addButton("Text Inviting User") {
                    self.messageHelper?.text(invitingUser.phoneNumber)
                }
            }
            
            alertView.showInfo("Text", subTitle: "Message Them")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LeaderboardTableCell()
        headerView.backgroundColor = .systemGray6
        headerView.numberLabel.text = ""
        headerView.nameLabel.text = ""
        headerView.pointsLabel.text = "Points"
        headerView.pointsLabel.font = UIFont.MontserratSemiBold(size: 15)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
