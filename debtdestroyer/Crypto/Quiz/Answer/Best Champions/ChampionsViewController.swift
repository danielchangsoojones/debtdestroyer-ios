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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeaderboardTableView()
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
            self.tableView.reloadData()
        }
    }
}

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LeaderboardTableCell.self)
        let quizScore = quizScores[indexPath.row]
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = quizScore.user.name
        cell.pointsLabel.text = String(quizScore.score)
        return cell
    }
}
