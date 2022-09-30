//
//  QuestionNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit
import Foundation

class QuestionNewUIViewController: UIViewController {
    var circularView = CircularProgressCountdownTimerView()
    var timeLeft: TimeInterval = 15
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceNewUIView] = []
    var backBtn = UIButton()
    let gifCheckMark = "https://media.giphy.com/media/QAUxbMqnNcMo9U0jt8/giphy.gif"
    let gifCrossMark = "https://media.giphy.com/media/VIz2F9yck4NhxmoC59/giphy.gif"
    private let dataStore = QuizDataStore()
    
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
        let questionView = QuestionNewUIView(frame: self.view.frame)
        self.view = questionView
        
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
        self.circularView = questionView.circularView
        self.backBtn = questionView.backBtn
        self.timeLabel = questionView.timerLabel
        backBtn.addTarget(self,action: #selector(backPressed),for: .touchUpInside)
//        questionView.submitBtn.addTarget(self,
//                                         action: #selector(submitPressed),
//                                         for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circularView.progressAnimation(duration: timeLeft)
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.view.setGradientBackground(color1: .topBlue, color2: .bottomBlue, radi: 0)
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00"
            timer.invalidate()
            incorrectAnswered()
        }
    }
  
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addAnswers(to stackView: UIStackView) {
        if let answers = currentData.answers {
            for (index, answer) in answers.enumerated() {
                let answerView = AnswerChoiceNewUIView(answer: answer)
                answerView.backgroundColor = .white
                answerView.layer.cornerRadius = 12
                answerView.tag = index
                answerView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))

                answerViews.append(answerView)
                answerView.answerLabel.text = answer
                stackView.addArrangedSubview(answerView)
                answerView.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
        }
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        for (index, answerView) in answerViews.enumerated() {
            if index == gesture.view?.tag {
                answerView.select()
 
                let isIncorrectAnswer = index != currentData.correct_answer_index
                var gifURL : String!
                if isIncorrectAnswer {
                    gifURL = gifCrossMark
//                    answerView.layer.sublayers?.remove(at: 0)
                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 12)
                } else {
                    gifURL = gifCheckMark
                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "E9D845"), color2: hexStringToUIColor(hex: "B5C30F"), radi: 12)

                }
                
                DispatchQueue.global().async {
                    
                    if let gifURL : String = gifURL {
                        if let imagefromURL = UIImage.gifImageWithURL(gifURL) {
                            DispatchQueue.main.async {
                                answerView.gifImgView.image = imagefromURL
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        Timer.runThisAfterDelay(seconds: 1.5, after: {
            self.submitAnswer()
        })
    }
        
    func submitAnswer() {
        let selectedAnswerIndex = answerViews.firstIndex { answerView in
            if answerView.backgroundColor != .white {
                return true
            } else {
                return false
            }
        }
        
        let isIncorrectAnswer = selectedAnswerIndex != currentData.correct_answer_index
        if isIncorrectAnswer {
            incorrectAnswered()
        } else {
            dataStore.saveCorrectAnswer(for: currentData.quizTopic)
            
            let nextIndex = currentIndex + 1
            let isLastQuestion = !quizDatas.indices.contains(nextIndex)
            if isLastQuestion {
                let leaderboardVC = ChampionsViewController(quizTopic: currentData.quizTopic)
                let navController = UINavigationController(rootViewController: leaderboardVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true)
            } else {
                let vc = QuestionNewUIViewController(quizDatas: quizDatas, currentIndex: nextIndex)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func incorrectAnswered() {
        let vc = ChampionsViewController(quizTopic: currentData.quizTopic)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d", Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
