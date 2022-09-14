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
        
        startView.backgroudImgView.image = UIImage.init(named: "nanoBack")
        //        startView.backgroudImgView.loadFromFile(currentData.quizTopic.intro_img)
        //        startView.nameLabel.text = currentData.quizTopic.name
        startView.descriptionLabel.text = "Complete the quiz, receive 2 " + currentData.quizTopic.name + " (payouts occur within 24 hours)."
        startView.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        dataStore.getQuizData { quizData in
            self.quizDatas = quizData
            //[Error]: Cannot create a pointer to an unsaved ParseObject (Code: 141, Version: 1.19.3)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        
        // i (Rashmi) wasn't sure about sequence of VC so commented other.
        
        //        let vc = AddressViewController(quizTopicDatas: self.quizDatas[currentIndex].quizTopic)
        //        let vc = LearnViewController(quizDatas: self.quizDatas, currentIndex: 0)
        let vc = ProvideFeedbackViewController(quizTopicDatas: self.quizDatas[currentIndex].quizTopic)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
