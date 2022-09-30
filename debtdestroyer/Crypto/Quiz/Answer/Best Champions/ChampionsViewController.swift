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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setLeaderboardTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
