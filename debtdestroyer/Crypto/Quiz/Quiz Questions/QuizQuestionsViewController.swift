//
//  QuizQuestionsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 31/01/23.
//

import UIKit

class QuizQuestionsViewController: UIViewController {
   
    private var tableView: UITableView!
    private let quizDataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    var color1 = UIColor()

    override func loadView() {
        super.loadView()
        setTableView()
        color1 = hexStringToUIColor(hex: "EB4D3D")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Quiz Questions"
        self.navigationController?.navigationBar.tintColor = color1
        navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.isHidden = false
        loadData()
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(cellType: QuizQuestionTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        quizDataStore.getQuizData { result, error  in
            if let quizDatas = result as? [QuizDataParse] {
                self.quizDatas = quizDatas
                self.tableView.reloadData()
            } else if let error = error {
                if error.localizedDescription.contains("error-force-update") {
                    ForceUpdate.showAlert()
                } else {
                    BannerAlert.show(with: error)
                }
            } else {
                BannerAlert.showUnknownError(functionName: "getQuizData")
            }
        }

    }

    
}

extension QuizQuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: QuizQuestionTableViewCell.self)
        cell.questionLabel.text = "Question \(indexPath.row) : " + self.quizDatas[indexPath.row].question
        let answersString = "\"[\"" + self.quizDatas[indexPath.row].answers!.joined(separator: "\",\"") + "\"]\""
        cell.answersLabel.text = "Answers: " + answersString
        
        cell.videoURL = self.quizDatas[indexPath.row].video_url_string
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
