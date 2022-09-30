//
//  StartQuizNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit
import SCLAlertView

class StartQuizViewController: UIViewController {
    private var backgroundImgView: UIImageView!
    private var descriptionLabel = UILabel()
    private var titleLabel = UILabel()
    private var nextButton: SpinningButton!
    
    private var dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    private let currentIndex: Int
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int) {
        self.quizDatas = quizDatas
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let startView = StartQuizView(frame: self.view.frame)
        self.view = startView
        self.backgroundImgView = startView.backgroudImgView
        self.descriptionLabel = startView.descriptionLabel
        self.titleLabel = startView.titleLabel
        self.nextButton = startView.nextButton
        startView.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        self.backgroundImgView.image = UIImage.init(named: "startTrivia")
        self.backgroundImgView.backgroundColor = .oliveGreen
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.dataStore.shouldShowEarnings { shouldShowEarnings in
            User.shouldShowEarnings = shouldShowEarnings
            if shouldShowEarnings {
                let quizTopic = self.quizDatas.first?.quizTopic
                
                self.titleLabel.text = quizTopic?.name ?? "Win our trivia to earn cash towards your student loan"
                self.descriptionLabel.text = quizTopic?.ticker ?? ""
            } else {
                self.titleLabel.text = "Become the trivia champion"
                self.descriptionLabel.text = "Answer the most trivia questions correctly to become the trivia champion!"
            }
            activityIndicator.stopAnimating()
        }
    }
    
    
    //    override func viewDidLoad() {
    //
    //        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    //
    //        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
    //        activityIndicator.color = UIColor.black
    //        self.view.addSubview(activityIndicator)
    //        activityIndicator.startAnimating()
    //
    //
    //
    //        dataStore.getQuizData { quizData in
    //            self.quizDatas = quizData
    //            let quizTopic = quizData.first?.quizTopic
    //            self.backgroundImgView.image = UIImage.init(named: "startTrivia")
    //            self.backgroundImgView.backgroundColor = .oliveGreen
    //
    //            self.dataStore.shouldShowEarnings { shouldShowEarnings in
    //                User.shouldShowEarnings = shouldShowEarnings
    //                if shouldShowEarnings {
    //                    self.titleLabel.text = quizTopic?.name ?? "Win our trivia to earn cash towards your student loan"
    //                    self.descriptionLabel.text = quizTopic?.ticker ?? ""
    //                } else {
    //                    self.titleLabel.text = "Become the trivia champion"
    //                    self.descriptionLabel.text = "Answer the most trivia questions correctly to become the trivia champion!"
    //                }
    //            }
    //            activityIndicator.stopAnimating()
    //        }
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        nextButton.startSpinning()
        dataStore.checkIfAlreadyTakenQuiz(for: currentData.quizTopic) { result, error in
            self.nextButton.stopSpinning()
            if let hasAlreadyTakenQuiz = result as? Bool {
                if !hasAlreadyTakenQuiz {
                    let questionVC = QuestionViewController(quizDatas: self.quizDatas, currentIndex: 0)
                    self.navigationController?.pushViewController(questionVC,
                                                                  animated: true)
                }
            } else {
                let alertView = SCLAlertView()
                let subtitle = error?.localizedDescription ?? "Please come into the app tommorow to see the next quiz."
                alertView.showInfo("Next Quiz", subTitle: subtitle, closeButtonTitle: "Okay")
            }
        }
    }
}
