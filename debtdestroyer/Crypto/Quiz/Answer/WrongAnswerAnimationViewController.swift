//
//  WrongAnswerAnimationViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 28/09/22.
//

import UIKit

class WrongAnswerAnimationViewController: UIViewController {
    var circularView = CircularProgressView()
    var duration: TimeInterval!
    var animationView = FinishAnimationView()
    var earnedLabel = UILabel()
    var nextButton = UIButton()
    var imgView = UIImageView()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    let answerColor = "EB5757"

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
        
        animationView = FinishAnimationView(frame: self.view.bounds)
        self.view = animationView
        self.circularView = animationView.circularView
        self.imgView = animationView.imgView
        self.earnedLabel = animationView.earnedLabel
        self.nextButton = animationView.nextButton
        self.nextButton.addTarget(self,
                                  action: #selector(nextBtnPressed),
                                  for: .touchUpInside)
        self.earnedLabel.text = "Wrong Answer!"
        self.imgView.image = UIImage.init(named: "cross")
        self.circularView.progressLayer.strokeColor = hexStringToUIColor(hex: answerColor).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duration = 1
        circularView.progressAnimation(duration: duration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func nextBtnPressed() {
        let nextIndex = currentIndex + 1
        let learnVC = LearnViewController(quizDatas: quizDatas, currentIndex: nextIndex)
        navigationController?.pushViewController(learnVC, animated: true)
    }
    
}
