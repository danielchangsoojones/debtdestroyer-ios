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
    private var nextButton: SpinningWithGradButton!
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    let showSkipButton: Bool
    
    init(showSkipButton: Bool, quizDatas: [QuizDataParse]?) {
        self.showSkipButton = showSkipButton
        //TODO: i'm not really doing anything with the quizDatas yet.
        //but i should evenutally not make a double api call.
        if let quizDatas = quizDatas {
            self.quizDatas = quizDatas
        }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(startQuizLoadData), name: NSNotification.Name(rawValue: "StartQuizLoadData"), object: nil)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setSkipButton()
    }
    
    private func setSkipButton() {
        if showSkipButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(skipPressed))
        }
    }
    
    @objc private func skipPressed() {
        dismiss(animated: true)
    }
    
    private func loadData() {
        self.dataStore.getQuizData { quizDatas in
            self.quizDatas = quizDatas
            self.dataStore.shouldShowEarnings { shouldShowEarnings in
                User.shouldShowEarnings = shouldShowEarnings
                if shouldShowEarnings {
                    let quizTopic = self.quizDatas.first?.quizTopic
                    
                    self.titleLabel.text = quizTopic?.name ?? "Play Daily Trivia"
                    self.descriptionLabel.text = quizTopic?.ticker ?? "Compete once per day in a trivia challenge to correctly answer as many questions in a row as you can! Whoever has the longest streak that day, wins $50 towards their student loan. Good Luck!"
                } else {
                    self.titleLabel.text = "Play Daily Trivia"
                    self.descriptionLabel.text = "Compete once per day in a trivia challenge to correctly answer as many questions in a row as you can! Whoever has the longest streak that day, wins. Good Luck!"
//                    self.titleLabel.text = "Become the trivia champion"
//                    self.descriptionLabel.text = "Answer the most trivia questions correctly to become the trivia champion!"
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc func startQuizLoadData() {
        loadData()
    }
    
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
