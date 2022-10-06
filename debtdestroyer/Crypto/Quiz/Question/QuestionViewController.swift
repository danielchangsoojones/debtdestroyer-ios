//
//  QuestionNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController {
    struct Constants {
        static let originalStartTime: TimeInterval = 15
    }
    
    enum AnswerStatus: String {
        case incorrect = "incorrect"
        case correct = "correct"
        case time_ran_out = "time_ran_out"
    }
    
    var circularView = CircularProgressCountdownTimerView()
    private var timeLeft: TimeInterval = Constants.originalStartTime
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceNewUIView] = []
    var answerStackView = UIStackView()

    var backBtn = UIButton()
    let gifCheckMark = "https://media.giphy.com/media/QAUxbMqnNcMo9U0jt8/giphy.gif"
    let gifCrossMark = "https://media.giphy.com/media/VIz2F9yck4NhxmoC59/giphy.gif"
    private let dataStore = QuizDataStore()
    
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    let appD = UIApplication.shared.delegate as! AppDelegate

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
        let questionView = QuestionView(frame: self.view.frame)
        self.view = questionView
        
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
        questionView.questionNoLabel.text = "question \(currentIndex + 1) of \(quizDatas.count)"
        print("question \(currentIndex + 1) of \(quizDatas.count)")
        self.circularView = questionView.circularView
        self.backBtn = questionView.backBtn
        self.timeLabel = questionView.timerLabel
        self.answerStackView = questionView.answerStackView
        backBtn.addTarget(self,action: #selector(backPressed),for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circularView.progressAnimation(duration: timeLeft)
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(enteredAppBackground), name: NSNotification.Name(rawValue: "quizLeft"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.setGradientBackground(color1: .topBlue, color2: .bottomBlue, radi: 0)
        appD.quizRunning = true
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00"
            timer.invalidate()
            submitAnswer(answerStatus: .time_ran_out)
        }
    }
  
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func enteredAppBackground() {
        //TODO: exited app, so they lose the entire quiz.
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
        timer.invalidate()
        circularView.pause()
        self.answerStackView.isUserInteractionEnabled = false // added this line so user can answer once only. if immediadely clicked can select more
        for (index, answerView) in answerViews.enumerated() {
            if index == gesture.view?.tag {
                answerView.select()
 
                let isIncorrectAnswer = index != currentData.correct_answer_index
                var gifURL : String!
                if isIncorrectAnswer {
                    gifURL = gifCrossMark
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
        
        Timer.runThisAfterDelay(seconds: 1.7, after: {
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                if answerView.backgroundColor != .white {
                    return true
                } else {
                    return false
                }
            }
            
            let isCorrectAnswer = selectedAnswerIndex == self.currentData.correct_answer_index
            let answerStatus: AnswerStatus = isCorrectAnswer ? .correct : .incorrect
            self.submitAnswer(answerStatus: answerStatus)
        })
    }
        
    func submitAnswer(answerStatus: AnswerStatus) {
        let time_answered_seconds = Constants.originalStartTime - timeLeft
        dataStore.saveAnswer(for: currentData.quizTopic,
                             answerStatus: answerStatus,
                             quizData: currentData,
                             time_answered_seconds: time_answered_seconds)
        
        let nextIndex = currentIndex + 1
        let isLastQuestion = !quizDatas.indices.contains(nextIndex)
        if isLastQuestion {
            appD.quizRunning = false
            let leaderboardVC = ChampionsViewController(quizTopic: currentData.quizTopic)
            self.navigationController?.pushViewController(leaderboardVC, animated: true)
        } else {
            let vc = QuestionViewController(quizDatas: quizDatas, currentIndex: nextIndex)
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
