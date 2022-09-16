//
//  StartQuizViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class StartQuizViewController: UIViewController {
    private var dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    private var backgroundImgView: UIImageView!
    private var nameLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        let startView = StartQuizView(frame: self.view.frame)
        self.view = startView
        self.backgroundImgView = startView.backgroudImgView
        self.nameLabel = startView.nameLabel
        self.descriptionLabel = startView.descriptionLabel
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
            self.backgroundImgView.loadFromFile(quizTopic?.intro_img)
            self.descriptionLabel.text = "Complete the quiz, receive 2 " + (quizTopic?.name ?? "coins") + " (payouts occur within 24 hours)."
            self.descriptionLabel.isHidden = User.current()?.email == User.appleTesterEmail
            self.nameLabel.text = quizData.first?.quizTopic.name
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
        let learnVC = LearnViewController(quizDatas: quizDatas, currentIndex: 0)
        self.navigationController?.pushViewController(learnVC, animated: true)
    }
}
