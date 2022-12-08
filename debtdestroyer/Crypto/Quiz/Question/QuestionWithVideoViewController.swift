//
//  QuestionWithVideoViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 05/12/22.
//

import UIKit
import Foundation
import AVFoundation
import SnapKit

class QuestionWithVideoViewController: UIViewController {
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
    var answerStackView = UIStackView()
    private var bottomView = UIView()
    var pointsLabel = UILabel()
    private let dataStore = QuizDataStore()
    private var playerLayer: AVPlayerLayer!
    private var quizStatusTimer = Timer()
    private var show_question_prompt_time: Date?
    private var hasRevealedAnswerOnce = false
    private var hasRevealedByAPI = false
    var timerBar = UIProgressView()
    var questionContentView = UIView()
    var questionView = QuestionWithVideoView()
    var player = AVPlayer()
    var progressBarContainer = UIView()
    private var alreadyPushingVC = false
    var answerView = UIView()
    var answerCollection:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var collectionHeight = 96
    var selectedAnswerIndex : Int?
    var answerStatus: AnswerStatus!
    var noOfOptions : Int!
    var cellCountCheck = 0

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
        questionView = QuestionWithVideoView(frame: self.view.frame)
        self.view = questionView
        self.playerLayer = questionView.playerLayer
        questionView.questionLabel.text = currentData.question
        questionView.questionNoLabel.text = "Question \(currentIndex + 1) of \(quizDatas.count)"
        print("question \(currentIndex + 1) of \(quizDatas.count)")
        self.timerBar = questionView.timerBar
        self.answerView = questionView.answerView
        self.pointsLabel = questionView.pointsLabel
        self.timeLabel = questionView.timerLabel
        self.questionContentView = questionView.questionContentView
        self.progressBarContainer = questionView.progressBarContainer
        self.bottomView = questionView.bottomView
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
    
    private func setAnswerCollectionView() {
        layout.scrollDirection = .vertical
        answerCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        answerCollection.delegate = self
        answerCollection.dataSource = self
        answerCollection.backgroundColor = .clear
        answerCollection.isScrollEnabled = false
        answerCollection.register(cellType: AnswerCollectionViewCell.self)
        answerView.addSubview(answerCollection)
        answerCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.height.equalTo(collectionHeight)
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: number of options mod 2 and add reminder * 120 for colloction height
        noOfOptions = currentData.answers!.count
        let rows = noOfOptions / 2
        let reminder = noOfOptions % 2
        collectionHeight = (rows+reminder)*96
        
        setAnswerCollectionView()
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
                self.hasRevealedByAPI = true
                self.answerCollection.reloadData()
            }
            if let show_question_prompt_time = show_question_prompt_time {
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
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerBar.setProgress(Float(timeLeft)/Float(Constants.originalStartTime), animated: false)
            timeLabel.text = timeLeft.time + " Seconds"
        } else {
            questionContentView.isUserInteractionEnabled = false
            timeLabel.text = "Time Up!"
            progressBarContainer.backgroundColor = hexStringToUIColor(hex: "A324EA")
            self.progressBarContainer.startBlink()
            self.timeLabel.startBlink()
            answerStatus = .time_ran_out
            timer.invalidate()
        }
    }
  
    func submitAnswer(answerStatus: AnswerStatus) {
        dataStore.saveAnswerV(for: currentData.quizTopic,
                              answerStatus: answerStatus,
                              quizData: currentData)
        print("================submitAnswer===================")
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
            let vc = QuestionWithVideoViewController(quizDatas: quizDatas, currentIndex: nextIndex)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension QuestionWithVideoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentData.answers!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType:AnswerCollectionViewCell.self)
        
        cell.ansLabel.text = currentData.answers![indexPath.row].capitalized
                
        if !hasRevealedAnswerOnce && hasRevealedByAPI && selectedAnswerIndex != nil{
            player.play()
            
            if indexPath.row == currentData.correct_answer_index {
                print("================GREEN===================")
                
                cell.gifImgView.image = UIImage.init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
                cell.gifImgView.tintColor = .black
                cell.gifImgView.alpha = 0.2
                UIImageView.animate(withDuration: 1, animations: {
                    cell.gifImgView.alpha = 1
                })
                cell.contentView.backgroundColor = .clear
                cell.contentView.setGradientBackground(color1: self.hexStringToUIColor(hex: "E9D845"), color2: self.hexStringToUIColor(hex: "B5C30F"), radi: 8)
                
            }
            if indexPath.row != currentData.correct_answer_index {
                
                if indexPath.row == selectedAnswerIndex {
                    print("================Red===================")

                    cell.gifImgView.image = UIImage.init(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
                    cell.gifImgView.tintColor = .black
                    cell.gifImgView.alpha = 0.2
                    UIImageView.animate(withDuration: 1, animations: {
                        cell.gifImgView.alpha = 1
                    })
                    cell.contentView.backgroundColor = .clear
                    cell.contentView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 8)
                } else {
                    print("================Hide===================")

                    UIView.animate(withDuration: 1.0) {
                        cell.contentView.alpha = 0.0
                    }
                }
            }
            
            cellCountCheck += 1
            if noOfOptions == cellCountCheck {
                if selectedAnswerIndex != currentData.correct_answer_index
                {
                    answerStatus = .incorrect
                } else if selectedAnswerIndex == currentData.correct_answer_index {
                    User.current()?.quizPointCounter += 1
                    pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
                    answerStatus = .correct
                } else {
                    answerStatus = .time_ran_out
                }
                submitAnswer(answerStatus: answerStatus)
                self.hasRevealedAnswerOnce = true
                self.bottomView.backgroundColor = .clear
                print("================self.hasRevealedAnswerOnce = true===================")
            }
        } else {
            // code to colour selected cell to purple
            if selectedAnswerIndex == indexPath.row && cell.contentView.backgroundColor == .white {
                cell.contentView.backgroundColor = hexStringToUIColor(hex: "A324EA")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnswerIndex = indexPath.row
        self.answerCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (answerView.frame.width - 22) * 0.5, height: 90)
    }
}
