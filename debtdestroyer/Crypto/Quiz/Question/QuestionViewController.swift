//
//  QuestionNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit
import Foundation
import AVFoundation

class QuestionViewController: UIViewController {
    struct Constants {
        static let originalStartTime: TimeInterval = 12
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
    private var bottomView = UIView()
    var backBtn = UIButton()
    var pointsLabel = UILabel()
    private let dataStore = QuizDataStore()
    private var playerLayer: AVPlayerLayer!
    private var quizStatusTimer = Timer()
    private var show_question_prompt_time: Date?
    
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
        self.playerLayer = questionView.playerLayer
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
        questionView.questionNoLabel.text = "Question \(currentIndex + 1) of \(quizDatas.count)"
        print("question \(currentIndex + 1) of \(quizDatas.count)")
        self.circularView = questionView.circularView
        self.backBtn = questionView.backBtn
        self.pointsLabel = questionView.pointsLabel
        self.timeLabel = questionView.timerLabel
        self.answerStackView = questionView.answerStackView
        backBtn.addTarget(self,action: #selector(backPressed),for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        NotificationCenter.default.addObserver(self, selector: #selector(enteredAppBackground), name: NSNotification.Name(rawValue: "quizLeft"), object: nil)
        circularView.progressAnimation(duration: timeLeft)
        
        quizStatusTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getLiveQuizStatus), userInfo: nil, repeats: true)
        pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        appD.quizRunning = true
    }
    
    private func playVideo() {
        if let video_url = URL(string: currentData.video_url_string) {
            let player = AVPlayer(url: video_url)
            playerLayer.player = player
            player.play()
        }
    }
    
    @objc private func getLiveQuizStatus() {
        dataStore.checkLiveQuizPosition(quizTopic: currentData.quizTopic) { current_quiz_data_id, show_question_prompt_time, should_reveal_answer in
            if let current_quiz_data_id = current_quiz_data_id, current_quiz_data_id != self.currentData.objectId {
                //the user is out of sync with liveness. Jump to the correct question
                self.jump(to: current_quiz_data_id)
            } else if should_reveal_answer {
                //TODO: show the answer
            } else if let show_question_prompt_time = show_question_prompt_time {
                self.startQuestionPrompt(start_time: show_question_prompt_time)
            }
        }
    }
    
    private func startQuestionPrompt(start_time: Date) {
        if endTime == nil {
            self.endTime = start_time.addingTimeInterval(timeLeft)
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func jump(to quizDataID: String) {
        let index = quizDatas.firstIndex { quizData in
            return quizData.objectId == quizDataID
        }
        
        if let index = index {
            playerLayer.player?.pause()
            playerLayer.player = nil
            timer.invalidate()
            quizStatusTimer.invalidate()
            let vc = QuestionViewController(quizDatas: quizDatas, currentIndex: index)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00"
            timer.invalidate()
//            submitAnswer(answerStatus: .time_ran_out)
        }
    }
  
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func enteredAppBackground() {
        dataStore.exitedAppDuringTrivia(for: currentData.quizTopic, quizData: currentData)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    private func addAnswers(to stackView: UIStackView) {
        if let answers = currentData.answers {
            for (index, answer) in answers.enumerated() {
                let answerView = AnswerChoiceNewUIView(answer: answer)
                answerView.backgroundColor = .systemGray6
                answerView.layer.cornerRadius = 25
                answerView.layer.borderColor = UIColor.systemGray4.cgColor
                answerView.layer.borderWidth = 1
                answerView.tag = index
                answerView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))

                answerViews.append(answerView)
                answerView.answerLabel.text = answer.capitalized
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
                if isIncorrectAnswer {
                    answerView.gifImgView.image = UIImage.init(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
                    answerView.gifImgView.tintColor = .black
                    answerView.gifImgView.alpha = 0
                    UIImageView.animate(withDuration: 3, animations: {
                        answerView.gifImgView.alpha = 1

                    })

                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 25)
                    
                    // Correct Answer show
                    
                    let correctAnswerView = answerViews[currentData.correct_answer_index]
                    correctAnswerView.gifImgView.image = UIImage.init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
                    correctAnswerView.gifImgView.tintColor = .black
                    correctAnswerView.gifImgView.alpha = 0.2
                    UIImageView.animate(withDuration: 3, animations: {
                        correctAnswerView.gifImgView.alpha = 1
                        
                    })
                    
                    correctAnswerView.setGradientBackground(color1: hexStringToUIColor(hex: "E9D845"), color2: hexStringToUIColor(hex: "B5C30F"), radi: 25)
                    
                } else {
                    User.current()?.quizPointCounter += 1
                    pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
                    answerView.gifImgView.image = UIImage.init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
                    answerView.gifImgView.tintColor = .black
                    answerView.gifImgView.alpha = 0.2
                    UIImageView.animate(withDuration: 3, animations: {
                        answerView.gifImgView.alpha = 1
                        
                    })

                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "E9D845"), color2: hexStringToUIColor(hex: "B5C30F"), radi: 25)

                }
            }
            
        }
        
        Timer.runThisAfterDelay(seconds: 1.7, after: {
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                if answerView.tag == gesture.view?.tag {
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
            if let storiesUrl = URL(string: "instagram-stories://share") {
                if UIApplication.shared.canOpenURL(storiesUrl) {
                    let vc = ScoreViewController(quizTopic: self.quizDatas.first!.quizTopic, quizDatas: self.quizDatas, currentIndex: 0)
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("Sorry the application is not installed")
                    finished()
                }
            }
        } else {
            let vc = QuestionViewController(quizDatas: quizDatas, currentIndex: nextIndex)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func finished() {
        if Helpers.getTopViewController() is UINavigationController {
            //the quizVC was shown in a modal, so pop to the leaderboard in the tab bar.
            let tabBarVC = presentingViewController as? UITabBarController
            if self.tabBarController?.viewControllers?.count == 4 {
                tabBarVC?.selectedIndex = 2
            } else {
                tabBarVC?.selectedIndex = 1
            }
            dismiss(animated: true)
        } else {
            let leaderboardVC = ChampionsViewController()
            self.navigationController?.pushViewController(leaderboardVC, animated: true)
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
