//
//  BestChampionsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class ChampionsViewController: UIViewController {
    private var tableView: UITableView!
    private let quizTopic: QuizTopicParse
    private var quizScores: [LeaderboardDataStore.QuizScore] = []
    private var descriptionLabel: UILabel!
    private let dataStore = LeaderboardDataStore()
    private var messageHelper: MessageHelper?
    private var bottomView = UIView()
    private var containerView = UIView()
    private var numberLabel = UILabel()
    private var nameLabel = UILabel()
    private var pointsLabel = UILabel()
    private var tweetText = String()
    private var timeLable = UILabel()

    init(quizTopic: QuizTopicParse) {
        self.quizTopic = quizTopic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let championsView = ChampionsView(frame: self.view.frame)
        self.view = championsView
        self.tableView = championsView.leaderboardTableView
        self.descriptionLabel = championsView.descriptionLabel
        self.bottomView = championsView.bottomView
        self.containerView = championsView.containerView
        self.numberLabel = championsView.numberLabel
        self.nameLabel = championsView.nameLabel
        self.timeLable = championsView.timeLable
        self.pointsLabel = championsView.pointsLabel
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
//        setNeedsStatusBarAppearanceUpdate()
    }

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }// code not working yet
    
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
        
        let nextTrivia = UIBarButtonItem.init(title: "Start Naxt Trivia", style: .done, target: self, action: #selector(nextTriviaPressed))
        navigationItem.leftBarButtonItem = nextTrivia
    }
    
    @objc private func nextTriviaPressed() {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
//        shareOnTwitter()
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
        dataStore.getLeaderBoard(quizTopicID: quizTopic.objectId ?? "") { quizScores, deadlineMessage in
            
//            if quizScores.isEmpty {
//                self.containerView.backgroundColor = .clear
//                self.tableView.backgroundColor = .clear
//            } else {
//                self.containerView.backgroundColor = .white
//                self.tableView.backgroundColor = .white
//            }
            self.quizScores = quizScores
            self.descriptionLabel.text = deadlineMessage
            if !User.shouldShowEarnings {
                self.descriptionLabel.text = "Thanks for playing the daily trivia! Come back tommorow for more daily trivia."
            }
            
            // MARK: This code will update info in bottom view if user never attended quiz before... No entry in table for current user.
            self.nameLabel.text = User.current()?.fullName.capitalized
            self.pointsLabel.text = " 0 "
            self.numberLabel.text = String(quizScores.count + 1) + ". "
            self.tweetText = "Hey.. I have earned 0 Points and scored \(quizScores.count + 1)."
            
            // MARK: this code will update info in bottom view if user attended quiz before
            var index = 1
            for quizScore in quizScores {
                if User.current()?.objectId == quizScore.user.objectId {
                    self.nameLabel.text = quizScore.user.fullName.capitalized
                    self.pointsLabel.text = " " + String(quizScore.points) + " Points "
                    self.numberLabel.text = String(index) + ". "
                    self.tweetText = "Hey.. I have earned \(quizScore.points) Points and scored \(index)."

                    return
                }
                index += 1
            }

        }
    }
}

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizScores.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LeaderboardTableCell.self)
        let quizScore = quizScores[indexPath.row + 1]
        cell.numberLabel.text = String(indexPath.row + 2) + ". "
        cell.nameLabel.text = quizScore.user.fullName.capitalized
        cell.pointsLabel.text = String(quizScore.points) + " Points"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.5
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
