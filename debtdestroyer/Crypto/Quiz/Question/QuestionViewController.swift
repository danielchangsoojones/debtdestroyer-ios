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
    
    private var timeLeft: TimeInterval = Constants.originalStartTime
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceNewUIView] = []
    var answerStackView = UIStackView()
    private var bottomView = UIView()
    var pointsLabel = UILabel()
    private let dataStore = QuizDataStore()
    private var playerLayer: AVPlayerLayer!
    private var quizStatusTimer = Timer()
    private var show_question_prompt_time: Date?
    private var hasRevealedAnswerOnce = false
    var timerBar = UIProgressView()

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
        self.timerBar = questionView.timerBar
        self.pointsLabel = questionView.pointsLabel
        self.timeLabel = questionView.timerLabel
        self.answerStackView = questionView.answerStackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        // TODO: UNCOMMENT THIS code, commented for testing
        quizStatusTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getLiveQuizStatus), userInfo: nil, repeats: true)
        pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    // TODO: Remove THIS func viewDidAppear.. added for testing

//    override func viewDidAppear(_ animated: Bool) {
//        endTime = Date().addingTimeInterval(timeLeft)
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func playVideo() {
        if let video_url = URL(string: currentData.video_url_string) {
            let player = AVPlayer(url: video_url)
            playerLayer.player = player
            player.play()
            NotificationCenter.default
                .addObserver(self,
                selector: #selector(playerDidFinishPlaying),
                name: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem
            )
        }
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        segueToNextVC()
    }
    
    @objc private func getLiveQuizStatus() {
        dataStore.checkLiveQuizPosition(quizData: currentData) { show_question_prompt_time, should_reveal_answer in
             if should_reveal_answer {
                self.revealAnswer()
            } else if let show_question_prompt_time = show_question_prompt_time {
                self.startQuestionPrompt(start_time: show_question_prompt_time)
            }
        }
    }
    
    private func startQuestionPrompt(start_time: Date) {
        if endTime == nil {
            self.endTime = start_time.addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    private func revealAnswer() {
        if !hasRevealedAnswerOnce {
            hasRevealedAnswerOnce = true
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                return answerView.isChosen
            }

            let isCorrectAnswer = selectedAnswerIndex == self.currentData.correct_answer_index
            var answerStatus: AnswerStatus = isCorrectAnswer ? .correct : .incorrect
            if let selectedAnswerIndex = selectedAnswerIndex {
                let answerView = answerViews[selectedAnswerIndex]
                //we need to remove the purple gradient so the replacement gradient will show (red or green).
                answerView.layer.sublayers?.removeAll(where: { layer in
                    return layer is CAGradientLayer
                })
                if isCorrectAnswer {
                    User.current()?.quizPointCounter += 1
                    pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
                    markCorrect(answerView: answerView)
                } else {
                    //incorrect answer
                    addAnswerMarkingGif(to: answerView, imageName: "xmark")
                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 25)
                    
                    // Correct Answer show
                    let correctAnswerView = answerViews[currentData.correct_answer_index]
                    markCorrect(answerView: correctAnswerView)
                }
            } else {
                let correctAnswerView = answerViews[currentData.correct_answer_index]
                markCorrect(answerView: correctAnswerView)
                answerStatus = .time_ran_out
            }
            
            self.submitAnswer(answerStatus: answerStatus)
        }
    }
    
    private func markCorrect(answerView: AnswerChoiceNewUIView) {
        addAnswerMarkingGif(to: answerView, imageName: "checkmark")
        answerView.setGradientBackground(color1: self.hexStringToUIColor(hex: "E9D845"), color2: self.hexStringToUIColor(hex: "B5C30F"), radi: 25)
    }
    
    private func addAnswerMarkingGif(to answerView: AnswerChoiceNewUIView, imageName: String) {
        answerView.gifImgView.image = UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        answerView.gifImgView.tintColor = .black
        answerView.gifImgView.alpha = 0.2
        UIImageView.animate(withDuration: 1, animations: {
            answerView.gifImgView.alpha = 1
        })
    }
    
//    private func jump(to quizDataID: String) {
//        let index = quizDatas.firstIndex { quizData in
//            return quizData.objectId == quizDataID
//        }
//
//        if let index = index {
//            playerLayer.player?.pause()
//            playerLayer.player = nil
//            timer.invalidate()
//            quizStatusTimer.invalidate()
//            let vc = QuestionViewController(quizDatas: quizDatas, currentIndex: index)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    @objc func updateTime() {
    
        
        
        if timeLeft > 0 {
          

            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerBar.setProgress(Float(timeLeft)/Float(Constants.originalStartTime), animated: false)
            timeLabel.text = timeLeft.time + " Seconds"
        } else {
            timeLabel.text = "Time Up!"
            self.timeLabel.alpha = 1
            UILabel.animate(withDuration: 1.5) {
                self.timeLabel.alpha = 0
            }
            timer.invalidate()
            submitAnswer(answerStatus: .time_ran_out)
        }
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
        // TODO: Code here for progrss bar pause
        self.answerStackView.isUserInteractionEnabled = false // added this line so user can answer once only. if immediadely clicked can select more
        for (index, answerView) in answerViews.enumerated() {
            if index == gesture.view?.tag {
                answerView.select()
            }
        }
    }
        
    func submitAnswer(answerStatus: AnswerStatus) {
        dataStore.saveAnswer(for: currentData.quizTopic,
                             answerStatus: answerStatus,
                             quizData: currentData)
    }
    
    private func segueToNextVC() {
        let nextIndex = currentIndex + 1
        let isLastQuestion = !quizDatas.indices.contains(nextIndex)
        if isLastQuestion {
            if Helpers.getTopViewController() is UINavigationController {
                //the quizVC was shown in a modal, so pop to the leaderboard in the tab bar.
                let tabBarVC = presentingViewController as? UITabBarController
                tabBarVC?.selectedIndex = 2
                dismiss(animated: true)
            } else {
                let leaderboardVC = ChampionsViewController()
                self.navigationController?.pushViewController(leaderboardVC, animated: true)
            }
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
