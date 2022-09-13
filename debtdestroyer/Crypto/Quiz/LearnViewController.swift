//
//  QuizViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class LearnViewController: UIViewController {
    private let quizDatas: [QuizDataParse]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let learnView = LearnView(frame: self.view.frame)
        self.view = learnView
        
        learnView.iconImgView.loadFromFile(currentData.quizTopic.icon_img)
        learnView.tickerLabel.text = currentData.quizTopic.ticker
        learnView.descriptionLabel.text = currentData.question
        learnView.explainerImgView.loadFromFile(currentData.learn_photo)
        learnView.nextButton.addTarget(self,
                                      action: #selector(nextBtnPressed),
                                      for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        //TODO: segue to next screen.
    }
}
