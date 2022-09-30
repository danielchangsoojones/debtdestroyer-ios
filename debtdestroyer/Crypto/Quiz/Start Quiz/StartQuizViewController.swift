//
//  StartQuizNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class StartQuizViewController: UIViewController {
    private var dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    private var backgroundImgView: UIImageView!
    private var descriptionLabel = UILabel()
    private var titleLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        let startView = StartQuizView(frame: self.view.frame)
        self.view = startView
        self.backgroundImgView = startView.backgroudImgView
        self.descriptionLabel = startView.descriptionLabel
        self.titleLabel = startView.titleLabel
        startView.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
        dataStore.getQuizData { quizData in
            self.quizDatas = quizData
            let quizTopic = quizData.first?.quizTopic
            self.backgroundImgView.image = UIImage.init(named: "startTrivia")
            self.backgroundImgView.backgroundColor = .oliveGreen
            
            self.dataStore.shouldShowEarnings { shouldShowEarnings in
                User.shouldShowEarnings = shouldShowEarnings
                if shouldShowEarnings {
                    self.titleLabel.text = quizTopic?.name ?? "Win our trivia to earn cash towards your student loan"
                    self.descriptionLabel.text = quizTopic?.ticker ?? ""
                } else {
                    self.titleLabel.text = "Become the trivia champion"
                    self.descriptionLabel.text = "Answer the most trivia questions correctly to become the trivia champion!"
                }
            }
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        let questionVC = QuestionViewController(quizDatas: quizDatas, currentIndex: 0)
        self.navigationController?.pushViewController(questionVC,
                                                      animated: true)
    }
}
