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
    private var pointsLabel = UILabel()
    
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
        self.pointsLabel = championsView.pointsLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setLeaderboardTableView()
        loadLeaderboard()
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
        self.tabBarController!.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    private func setLeaderboardTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: LeaderboardTableCell.self)
        tableView.backgroundColor = .blue
    }
    
    private func loadLeaderboard() {
        dataStore.getLeaderBoard(quizTopicID: quizTopic.objectId ?? "") { quizScores, deadlineMessage in
            self.quizScores = quizScores
            self.descriptionLabel.text = deadlineMessage
            let quizScore = quizScores[0]
            self.champNameLabel.text = "Anny Maxwell"//quizScore.user.name
            self.pointsLabel.text = " " + String(quizScore.score) + " Points "
            self.tableView.reloadData()
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
        cell.nameLabel.text = "Test Data"//quizScore.user.name
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
