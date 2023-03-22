//
//  QuestionWithAnswerRevealGoTinyViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 25/01/23.
//

import UIKit
import Foundation
import AVFoundation
import SCLAlertView

class QuestionWithAnswerRevealGoTinyViewController: UIViewController {
    struct Constants {
        static let originalStartTime: TimeInterval = 12
    }
    
    private var messageHelper: MessageHelper?
    private var timeLeft: TimeInterval = Constants.originalStartTime
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceNewUIView] = []
    var answerStackView = UIStackView()
    private var bottomView: UIView!
    var pointsLabel = UILabel()
    private let dataStore = QuizDataStore()
    private var playerLayer: AVPlayerLayer!
    private var quizStatusTimer = Timer()
    private var show_question_prompt_time: Date?
    private var hasRevealedAnswerOnce = false
    var timerBar = UIProgressView()
    var questionContentView = UIView()
    var questionView = QuestionWithAnswerRevealGoTinyView()
    var player = AVPlayer()
    var progressBarContainer = UIView()
    private var alreadyPushingVC = false
    private var answer_video_url: String?
    private var intervieweeImageView: UIImageView!
    let audioSession = AVAudioSession.sharedInstance()
    var volume: Float?
    var obs: NSKeyValueObservation?
    var soundOffContainer = UIView()
    var closePopupButton = UIButton()
    var revealAnswerContainer = UIView()
    var correctAnswerView = UIView()
    var yourAnswerView = UIView()
    var yourAnswerLabel = UILabel()
    var correctAnswerLabel = UILabel()
    var yourAnswerHeading = UILabel()
    var correctAnswerHeading = UILabel()
    private var helpButton = UIButton()
    private var competing_tie_users_count: Int?
    private var inTieMode = false
    private var final_remaining_tie_spots = -1
    private var won_users: [User] = []
    private var lost_users: [User] = []
    
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int, competing_tie_users_count: Int?, inTieMode: Bool) {
        self.quizDatas = quizDatas
        self.inTieMode = inTieMode
        self.competing_tie_users_count = competing_tie_users_count
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        questionView = QuestionWithAnswerRevealGoTinyView(frame: self.view.frame)
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
        self.intervieweeImageView = questionView.intervieweeImageView
        self.bottomView = questionView.bottomView
        self.soundOffContainer = questionView.soundOffContainer
        self.closePopupButton = questionView.closePopupButton
        self.helpButton = questionView.helpButton
        self.revealAnswerContainer = questionView.revealAnswerContainer
        self.correctAnswerView = questionView.correctAnswerView
        self.yourAnswerView = questionView.yourAnswerView
        self.yourAnswerLabel = questionView.yourAnswerLabel
        self.correctAnswerLabel = questionView.correctAnswerLabel
        self.yourAnswerHeading = questionView.yourAnswerHeading
        self.correctAnswerHeading = questionView.correctAnswerHeading
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        playVideo()
        quizStatusTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                               target: self,
                                               selector: #selector(getLiveQuizStatus),
                                               userInfo: nil,
                                               repeats: true)
        pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
        closePopupButton.addTarget(self,action: #selector(closeNoSoundPopup),for: .touchUpInside)
        showControlBtns()
        intervieweeImageView.loadFromFile(currentData.intervieweePhoto)
        helpButton.addTarget(self, action: #selector(helpPressed), for: .touchUpInside)
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
    
    @objc private func closeNoSoundPopup() {
        UserDefaults.standard.set(true, forKey: "NoSoundBannerClosed")
        UserDefaults.standard.synchronize()
        self.soundOffContainer.isHidden = true
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    private func showControlBtns() {
        if (User.current()?.isAdminUser ?? false) {
            let questionPromptFrame = CGRect(x: 100, y: 100, width: 300, height: 100)
            createBtn(title: "Start Question Prompt", selector: #selector(startQuestionPromptControl), backgroundColor: .purple, frame: questionPromptFrame)
            
            let revealAnswerFrame = CGRect(x: questionPromptFrame.minX,
                                           y: 265,
                                           width: questionPromptFrame.width,
                                           height: questionPromptFrame.height)
            createBtn(title: "Reveal Answer",
                      selector: #selector(revealAnswerControl),
                      backgroundColor: .red,
                      frame: revealAnswerFrame)
            
            let nextFrame = CGRect(x: 30,
                                   y: 100,
                                   width: 60,
                                   height: 60)
            createBtn(title: "skip",
                      selector: #selector(adminNextBtn),
                      backgroundColor: .yellow,
                      frame: nextFrame)
        }
    }
    
    @objc private func startQuestionPromptControl() {
        if inTieMode {
            dataStore.markQuizTieStatus(quizDatas: quizDatas,
                                        shouldStartQuestionPrompt: true,
                                        total_tie_slots: competing_tie_users_count ?? 0,
                                        currentQuizData: currentData) { quizData, final_remaining_tie_spots, won_users, lost_users   in
                //do nothing
            }
        } else {
            let quizManagerDataStore = CryptoSettingsDataStore()
            quizManagerDataStore.markQuizStatus(quizDatas: quizDatas,
                                                shouldStartQuestionPrompt: true,
                                                currentIndex: nil,
                                                currentQuizData: currentData) { _ in
                //for the question prompt, we won't get to this completion.
            }
        }
    }
    
    @objc private func revealAnswerControl() {
        if inTieMode {
            dataStore.markQuizTieStatus(quizDatas: quizDatas,
                                        shouldStartQuestionPrompt: false,
                                        total_tie_slots: competing_tie_users_count ?? 0,
                                        currentQuizData: currentData) { quizData, final_remaining_tie_spots, won_users, lost_users  in
                self.final_remaining_tie_spots = final_remaining_tie_spots
                self.lost_users = lost_users
                self.won_users = won_users
            }
        } else {
            if User.isAdminUser {
                if quizDatas.count == (currentIndex + 1) {
                    
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    let alertView = SCLAlertView(appearance: appearance)
                    
                    alertView.addButton("Officially End Quiz") {
                        self.dataStore.officiallyEndQuiz(for: self.currentData.quizTopic)
                    }
                    
                    alertView.addButton("No") {
                        
                    }
                    alertView.showNotice("", subTitle: "Would you like to officially end the quiz?")
                }
            }
            
            let now = Date()
            if currentData.quizTopic.start_time > now {
                //when I am just previewing the quiz, I don't want it to hit the server with the revealed answer.
                self.answer_video_url = AnswerKeysViewController.answer_video_urls[currentIndex]
                self.revealAnswer(with: AnswerKeysViewController.correct_indices[currentIndex])
                self.playVideoAnswer()
            } else {
                let quizManagerDataStore = CryptoSettingsDataStore()
                quizManagerDataStore.markQuizStatus(quizDatas: quizDatas,
                                                    shouldStartQuestionPrompt: false,
                                                    currentIndex: currentIndex,
                                                    currentQuizData: currentData) { quizTopic in
                    self.competing_tie_users_count =  quizTopic.competing_tie_user_ids.count
                }
            }
        }
    }
    
    @objc private func adminNextBtn() {
        segueToNextVC(index: nil)
    }
    
    private func createBtn(title: String, selector: Selector, backgroundColor: UIColor, frame: CGRect) {
        let btn = UIButton(frame: frame)
        btn.backgroundColor = backgroundColor
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    private func questionPromptAnimate() {
        UIView.animate(withDuration: 1.0) {
            self.bottomView.alpha = 1.0
        }
        
        showIntervieweePhoto(shouldShow: true)
    }
    
    private func showIntervieweePhoto(shouldShow: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.intervieweeImageView.alpha = shouldShow ? 1.0 : 0.0
        }
    }
    
    private func playVideo() {
        let bannerStatus = UserDefaults.standard.bool(forKey: "NoSoundBannerClosed")
        
        if !bannerStatus {
            
            // this code is KVO to notify user if volume change or put on mute
            self.obs = audioSession.observe( \.outputVolume ) { (av, change) in
                if av.outputVolume == 0.0 {
                    self.soundOffContainer.isHidden = false
                }
            }
            
            // this code is to notify user initially, if volume is off
            do {
                try audioSession.setActive(true)
                volume = audioSession.outputVolume
                if volume == 0.0 {
                    self.soundOffContainer.isHidden = false
                }
            } catch {
                print("Error Setting Up Audio Session")
            }
        }
        
        
        
        if let video_url = URL(string: currentData.video_url_string) {
            player = AVPlayer(url: video_url)
            playerLayer.player = player
            player.play()
            
            if User.isAppleTester || User.isIpadDemo {
                NotificationCenter.default
                    .addObserver(self,
                                 selector: #selector(playerDidFinishPlaying),
                                 name: .AVPlayerItemDidPlayToEndTime,
                                 object: player.currentItem
                    )
            }
        }
    }
    
    @objc private func playerDidFinishPlaying(notification: NSNotification) {
        if hasRevealedAnswerOnce {
            segueToNextVC(index: nil)
        } else if User.isAppleTester || User.isIpadDemo {
            let now = Date()
            startQuestionPrompt(start_time: now)
        }
    }
    
    @objc private func getLiveQuizStatus() {
        if !(User.isAppleTester || User.isIpadDemo) {
            let isPlaying = player.timeControlStatus == .playing
            //we aren't syncing the time when we are in tie mode. We probably could eventually
            //it's just weird because the quiztopic is always changing.
            if User.current()?.email == "messyjones@gmail.com" && isPlaying && !inTieMode {
                let current_time_seconds = player.currentTime().seconds
                dataStore.saveQuizCurrentTime(current_time_seconds: current_time_seconds,
                                              currentQuizDataID: currentData.objectId ?? "")
            }
            
            dataStore.checkLiveQuizPosition(quizData: currentData) { show_question_prompt_time, correct_answer_index, current_quiz_seconds, answer_video_url, current_quiz_data_id, shouldRevealAnswer  in
                if !self.inTieMode {
                    self.jumpToCurrentVideoMoment(current_quiz_seconds: current_quiz_seconds, current_quiz_data_id: current_quiz_data_id)
                }
                self.answer_video_url = answer_video_url
                
                if shouldRevealAnswer, let correct_answer_index = correct_answer_index {
                    self.revealAnswer(with: correct_answer_index)
                } else if let show_question_prompt_time = show_question_prompt_time {
                    self.startQuestionPrompt(start_time: show_question_prompt_time)
                }
            }
        }
    }
    
    private func jumpToCurrentVideoMoment(current_quiz_seconds: Double, current_quiz_data_id: String) {
        let timeDifference = abs(player.currentTime().seconds - current_quiz_seconds)
        if timeDifference > 2 && User.current()?.email != "messyjones@gmail.com" {
            if alreadyPushingVC {
                return
            } else if current_quiz_data_id != currentData.objectId {
                //we need to jump to another quiz data
                let index = quizDatas.firstIndex { quizData in
                    return quizData.objectId == current_quiz_data_id
                }
                
                if let index = index, index > currentIndex {
                    //we had a glitch where it would jump backwards sometimes at the end of every player.
                    //we want to make sure it only jumps forward
                    
                    //If I don't kill the player, then it keeps playing it in the background.
                    //while the new player on another VC is playing.
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                    segueToNextVC(index: index)
                }
            }
        }
    }
    
    private func startQuestionPrompt(start_time: Date) {
        if endTime == nil {
            self.endTime = start_time.addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            self.questionPromptAnimate()
        }
    }
    
    private func revealAnswer(with correct_answer_index: Int) {
        if !hasRevealedAnswerOnce {
            playVideoAnswer()
            hasRevealedAnswerOnce = true
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                return answerView.isChosen
            }
            
            UIView.animate(withDuration: 1.0) {
                // hiding these to show reveal answer go tiny
                self.bottomView.isHidden = true
                self.progressBarContainer.isHidden = true
                self.timeLabel.isHidden = true
            }
            // After hiding question & options it will show reveal answer with animation
            UIView.animate(withDuration: 1.0) {
                self.revealAnswerContainer.alpha = 1.0
            }

            if let selectedAnswerIndex = selectedAnswerIndex {
                let answerView = answerViews[selectedAnswerIndex]
                updateYourAnswerView(answerView: answerView)
                let isIncorrectAnswer = selectedAnswerIndex != correct_answer_index
                if isIncorrectAnswer {
                    yourAnswerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF7910"), color2: hexStringToUIColor(hex: "EB5757"),radi: 25)
                    UIView.animate(withDuration: 1.0) {
                        self.yourAnswerView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    }
                } else {
                    self.questionView.setGifImage(gifImgView: self.questionView.gifImgViewXmark, subviewTo: yourAnswerView, bottomTo: yourAnswerLabel, imageName: "checkmark")
                    yourAnswerView.setGradientBackground(color1: self.hexStringToUIColor(hex: "E9D845"), color2: self.hexStringToUIColor(hex: "B5C30F"), radi: 25)
                    User.current()?.quizPointCounter += 1
                    pointsLabel.text = "\(User.current()?.quizPointCounter ?? 0) Points"
                }
            }
            
            markCorrectAnswerView(correct_answer_index: correct_answer_index)
            
            // this code is hiding remaining options
            for (_, answerView) in answerViews.enumerated() {
                if answerView.tag == selectedAnswerIndex || answerView.tag == correct_answer_index {
                    answerView.alpha = 1.0
                } else {
                    UIView.animate(withDuration: 1.0) {
                        answerView.alpha = 0.0
                    }
                }
            }
        }
    }
    
    private func playVideoAnswer() {
        if let answer_video_url = answer_video_url, let url = URL(string: answer_video_url) {
            let asset = AVURLAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            player.replaceCurrentItem(with: playerItem)
            player.play()
            
            //removing the old notification right before we add it again.
            //it's weird. The notification doesn't work after the 2nd time after adding
            //it again.
            NotificationCenter.default.removeObserver(self,
                                                      name: .AVPlayerItemDidPlayToEndTime,
                                                      object: nil)
            
            NotificationCenter.default
                .addObserver(self,
                             selector: #selector(playerDidFinishPlaying),
                             name: .AVPlayerItemDidPlayToEndTime,
                             object: player.currentItem
                )
        }
    }
    
    private func updateYourAnswerView(answerView : AnswerChoiceNewUIView) {
        yourAnswerView.alpha = 1.0

        yourAnswerLabel.text = answerView.answerLabel.text
    }
    
    private func markCorrectAnswerView(correct_answer_index: Int) {
        correctAnswerView.setGradientBackground(color1: self.hexStringToUIColor(hex: "E9D845"), color2: self.hexStringToUIColor(hex: "B5C30F"), radi: 25)
        correctAnswerLabel.text = answerViews[correct_answer_index].answerLabel.text
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
            progressBarContainer.backgroundColor = hexStringToUIColor(hex: "A324EA")
            self.progressBarContainer.startBlink()
            self.timeLabel.startBlink()
            timer.invalidate()
            self.showIntervieweePhoto(shouldShow: false)
            submitSelectedAnswer()
            
            if User.isAppleTester || User.isIpadDemo {
                let video_answer_id = currentData.videoAnswer.objectId ?? ""
                dataStore.loadVideoAnswer(video_answer_id: video_answer_id) { videoAnswer in
                    self.answer_video_url = videoAnswer.video_url_string
                    self.revealAnswer(with: self.currentData.correct_answer_index)
                    self.playVideoAnswer()
                }
            }
        }
    }
    
    private func submitSelectedAnswer() {
        //don't submit answers for the quiz when admin doing quiz
        if !User.isAdminUser {
            let selectedAnswerIndex = self.answerViews.firstIndex { answerView in
                return answerView.isChosen
            } ?? -1
            
            if inTieMode {
                dataStore.saveTieAnswer(chosen_answer_index: selectedAnswerIndex,
                                        quizData: currentData)
            } else {
                dataStore.saveAnswer(for: currentData.quizTopic,
                                     chosen_answer_index: selectedAnswerIndex,
                                     quizData: currentData)
            }
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
    
    private func segueToNextVC(index: Int?) {
        if !alreadyPushingVC {
            alreadyPushingVC = true
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
            
            if inTieMode {
                let hasWon = won_users.contains { user in
                    return user.objectId == User.current()?.objectId
                }
                let hasLost = lost_users.contains { user in
                    return user.objectId == User.current()?.objectId
                }
                if final_remaining_tie_spots == 0 || hasWon || hasLost {
                    //the tiebreaker is over
                    //or the users who won or lost go to the leaderboard
                    self.popBackToLeaderboard()
                } else  {
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    let vc = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                          currentIndex: nextIndex,
                                                                          competing_tie_users_count: competing_tie_users_count,
                                                                          inTieMode: inTieMode)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if isLastQuestion {
                UserDefaults.standard.removeObject(forKey: "NoSoundBannerClosed")
                UserDefaults.standard.synchronize()
                let shouldGoTieBreaker = (competing_tie_users_count ?? 0) > 0
                if shouldGoTieBreaker {
                    let tiebreakerVC = TieBreakerViewController(competing_tie_users_count: competing_tie_users_count ?? 0)
                    self.navigationController?.pushViewController(tiebreakerVC, animated: true)
                } else if Helpers.getTopViewController() is UINavigationController {
                    self.popBackToLeaderboard()
                }
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                let vc = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                      currentIndex: nextIndex,
                                                                      competing_tie_users_count: nil,
                                                                      inTieMode: inTieMode)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func popBackToLeaderboard() {
        //the quizVC was shown in a modal, so pop to the leaderboard in the tab bar.
        let tabBarVC = presentingViewController as? UITabBarController
        tabBarVC?.selectedIndex = 1
        dismiss(animated: true)
    }
}
