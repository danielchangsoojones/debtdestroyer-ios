//
//  StartQuizNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class StartQuizNewUIViewController: UIViewController {
    private var dataStore = QuizDataStore()
    private var quizDatas: [QuizDataParse] = []
    private var backgroundImgView: UIImageView!
    private var descriptionLabel = UILabel()
    private var nameLabel = UILabel()
    private var titleLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        let startView = StartQuizNewUIView(frame: self.view.frame)
        self.view = startView
        self.backgroundImgView = startView.backgroudImgView
        self.nameLabel = startView.nameLabel
        self.descriptionLabel = startView.descriptionLabel
        self.titleLabel = startView.descriptionLabel
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
//                let prizeAmount = quizTopic?.prize_amount ?? 0
//                self.descriptionLabel.text = "Complete the quiz, receive \(prizeAmount) " + (quizTopic?.name ?? "coins") + " (payouts occur within 24 hours)."
//                self.descriptionLabel.isHidden = !shouldShowEarnings
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
//        let learnVC = LearnViewController(quizDatas: quizDatas, currentIndex: 0)
//        self.navigationController?.pushViewController(learnVC, animated: true)
        let vc = BestChampionsContainerViewController(contentViewController: ChampionsViewController(quizDatas: quizDatas, currentIndex: 0), bottomSheetViewController: ChampionsListViewController(quizDatas: quizDatas, currentIndex: 0), bottomSheetConfiguration: .init(
            height: UIScreen.main.bounds.height * 0.8,
            initialOffset: ((UIScreen.main.bounds.height) - 380) + UIWindow().safeAreaInsets.bottom))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
