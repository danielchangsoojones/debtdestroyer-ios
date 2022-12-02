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
    var questionContentView = UIView()
    var questionView = QuestionView()
    var player = AVPlayer()
    var progressBarContainer = UIView()
    private var alreadyPushingVC = false

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
        questionView = QuestionView(frame: self.view.frame)
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
        self.questionContentView = questionView.questionContentView
        self.progressBarContainer = questionView.progressBarContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        self.questionContentView.alpha = 0.0
        quizStatusTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getLiveQuizStatus), userInfo: nil, repeats: true)
        pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(applicationDidBecomeActive),
                name: UIApplication.didBecomeActiveNotification,
                object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timeLabel.stopBlink()
        self.progressBarContainer.stopBlink()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func applicationDidBecomeActive() {
        //whenever the user leaves the app, it pauses the video, so we have to play again.
        //https://stackoverflow.com/questions/48473144/swift-ios-avplayer-video-freezes-pauses-when-app-comes-back-from-background
        let isWaitingToShowQuestionPrompt = endTime == nil
        if hasRevealedAnswerOnce || isWaitingToShowQuestionPrompt  {
            player.play()
        }
    }
    
    private func questionPromptAnimate() {
        UIView.animate(withDuration: 1.0) {
            self.questionContentView.alpha = 1.0
        }
    }
    
    private func playVideo() {
        if let video_url = URL(string: currentData.video_url_string) {
            player = AVPlayer(url: video_url)
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
        segueToNextVC(index: nil)
    }
    
    @objc private func getLiveQuizStatus() {
        let isPlaying = player.timeControlStatus == .playing
        if User.current()?.email == "messyjones@gmail.com" && isPlaying {
            let current_time_seconds = previousQuizDataTimes + Int(player.currentTime().seconds)
            dataStore.saveQuizCurrentTime(current_time_seconds: current_time_seconds)
        }
        
        dataStore.checkLiveQuizPosition(quizData: currentData) { show_question_prompt_time, should_reveal_answer, current_quiz_seconds in
            self.jumpToCurrentVideoMoment(current_quiz_seconds: current_quiz_seconds)
            
            if should_reveal_answer {
                self.revealAnswer()
            } else if let show_question_prompt_time = show_question_prompt_time {
                self.startQuestionPrompt(start_time: show_question_prompt_time)
            }
        }
    }
    
    var previousQuizDataTimes: Int {
        var previousQuizDataTimes = 0
        for (index, quizData) in quizDatas.enumerated() {
            if (index < currentIndex) {
                previousQuizDataTimes = previousQuizDataTimes + quizData.video_length_seconds
            }
        }
        return previousQuizDataTimes
    }
    
    private func jumpToCurrentVideoMoment(current_quiz_seconds: Double) {
        let users_current_quiz_seconds = Double(previousQuizDataTimes) + player.currentTime().seconds
        let timeDifference = abs(users_current_quiz_seconds - current_quiz_seconds)
        if timeDifference > 2 && User.current()?.email != "messyjones@gmail.com" {
            var totalVideoLength = 0
            for (index, quizData) in quizDatas.enumerated() {
                let upperBound = totalVideoLength + quizData.video_length_seconds
                if Int(current_quiz_seconds) >= totalVideoLength && Int(current_quiz_seconds) <= upperBound {
                    if quizData.objectId != currentData.objectId && !alreadyPushingVC {
                        alreadyPushingVC = true
                        //we need to jump to another quiz data
                        segueToNextVC(index: index)
                    } else {
                        //added the half second buffer because if we do it exactly, it was having this weird.
                        //double buffer. but just having a tiny bit buffer makes it smoother.
                        let timeIntoVideo = current_quiz_seconds - Double(previousQuizDataTimes) - 0.5
                        let time = CMTime(seconds: timeIntoVideo, preferredTimescale: .max)
                        player.seek(to: time)
                    }
                    return
                }
                totalVideoLength = upperBound
            }
        }
    }
    
    private func startQuestionPrompt(start_time: Date) {
        if endTime == nil {
            player.pause()
            self.endTime = start_time.addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            self.questionPromptAnimate()
        }
    }
    
    private func revealAnswer() {
        if !hasRevealedAnswerOnce {
            player.play()
            hasRevealedAnswerOnce = true
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                return answerView.isChosen
            }
            
            var answerStatus: AnswerStatus = .incorrect
            if let selectedAnswerIndex = selectedAnswerIndex {
                let answerView = answerViews[selectedAnswerIndex]
                //we need to remove the purple gradient so the replacement gradient will show (red or green).
                answerView.layer.sublayers?.removeAll(where: { layer in
                    return layer is CAGradientLayer
                })
                let isIncorrectAnswer = selectedAnswerIndex != currentData.correct_answer_index
                if isIncorrectAnswer {
                    addAnswerMarkingGif(to: answerView, imageName: "xmark")
                    answerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 25)
                } else {
                    answerStatus = .correct
                    User.current()?.quizPointCounter += 1
                    pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
                }
            } else {
                answerStatus = .time_ran_out
            }
            markCorrectAnswerView()
            
            // this code is hiding remaining options
            for (_, answerView) in answerViews.enumerated() {
                if answerView.tag == selectedAnswerIndex || answerView.tag == self.currentData.correct_answer_index {
                    answerView.alpha = 1.0
                } else {
                    UIView.animate(withDuration: 1.0) {
                        answerView.alpha = 0.0
                    }
                }
            }
            
            self.submitAnswer(answerStatus: answerStatus)
        }
    }
    
    private func markCorrectAnswerView() {
        let correctAnswerView = answerViews[currentData.correct_answer_index]
        addAnswerMarkingGif(to: correctAnswerView, imageName: "checkmark")
        correctAnswerView.setGradientBackground(color1: self.hexStringToUIColor(hex: "E9D845"), color2: self.hexStringToUIColor(hex: "B5C30F"), radi: 25)
    }
    
    private func addAnswerMarkingGif(to answerView: AnswerChoiceNewUIView, imageName: String) {
        answerView.gifImgView.image = UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        answerView.gifImgView.tintColor = .black
        answerView.gifImgView.alpha = 0.2
        UIImageView.animate(withDuration: 1, animations: {
            answerView.gifImgView.alpha = 1
        })
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerBar.setProgress(Float(timeLeft)/Float(Constants.originalStartTime), animated: false)
            timeLabel.text = timeLeft.time + " Seconds"
        } else {
            questionContentView.isUserInteractionEnabled = false
            timeLabel.text = "Time Up!"
            progressBarContainer.backgroundColor = .purple
            self.progressBarContainer.startBlink()
            self.timeLabel.startBlink()
            timer.invalidate()
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
    
    private func segueToNextVC(index: Int?) {
        playerLayer.player?.pause()
        playerLayer.player = nil
        timer.invalidate()
        quizStatusTimer.invalidate()
        NotificationCenter.default.removeObserver(self)
        
        var nextIndex = currentIndex + 1
        if let index = index {
            nextIndex = index
        }
        let isLastQuestion = !quizDatas.indices.contains(nextIndex)
        if isLastQuestion {
            if Helpers.getTopViewController() is UINavigationController {
                //the quizVC was shown in a modal, so pop to the leaderboard in the tab bar.
                let tabBarVC = presentingViewController as? UITabBarController
                tabBarVC?.selectedIndex = 1
                dismiss(animated: true)
            } else {
                let leaderboardVC = ChampionsViewController()
                self.navigationController?.pushViewController(leaderboardVC, animated: true)
            }
        } else {
            let vc = QuestionViewController(quizDatas: quizDatas,
                                            currentIndex: nextIndex)
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
