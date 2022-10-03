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
    private var quizScores: [QuizScoreParse] = []
    private var descriptionLabel: UILabel!
    private let dataStore = LeaderboardDataStore()
    private var messageHelper: MessageHelper?
    private var champImgView = UIImageView()
    private var champNameLabel = UILabel()
    private var champPointsLabel = UILabel()
    private var bottomView = MyRoundBottomView()

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
        self.champImgView = championsView.champImgView
        self.champNameLabel = championsView.champNameLabel
        self.champPointsLabel = championsView.champPointsLabel
        self.bottomView = championsView.bottomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setLeaderboardTableView()
        loadLeaderboard()
    }
    
    override func viewDidLayoutSubviews() {
//        self.bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 300)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarBtns()
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
    }
    
    private func setLeaderboardTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: LeaderboardTableCell.self)
    }
    
    private func loadLeaderboard() {
        dataStore.getLeaderBoard(quizTopicID: quizTopic.objectId ?? "") { quizScores, deadlineMessage in
            self.quizScores = quizScores
            self.descriptionLabel.text = deadlineMessage
            if !User.shouldShowEarnings {
                self.descriptionLabel.text = "Thanks for playing the daily trivia! Come back tommorow for more daily trivia."
            }
            if let quizScore = quizScores.first {
                self.champNameLabel.text = quizScore.user.fullName
                self.champPointsLabel.text = " " + String(quizScore.score) + " Points "
                self.tableView.reloadData()
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
        cell.nameLabel.text = quizScore.user.fullName
        cell.pointsLabel.text = String(quizScore.score) + " Points"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
