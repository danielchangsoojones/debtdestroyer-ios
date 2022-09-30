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
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    
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
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func loadData() {
        self.dataStore.getQuizData { quizDatas in
            self.quizDatas = quizDatas
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
                self.activityIndicator.stopAnimating()
            }
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
        super.viewWillAppear(animated)
        loadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        nextButton.startSpinning()
        if let quizTopic = quizDatas.first?.quizTopic {
            dataStore.checkIfAlreadyTakenQuiz(for: quizTopic) { result, error in
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
        } else {
            nextButton.stopSpinning()
        }
    }
}
