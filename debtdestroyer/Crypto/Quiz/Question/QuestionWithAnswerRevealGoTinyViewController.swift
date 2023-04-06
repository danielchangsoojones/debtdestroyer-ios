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
    private var quizDatas: [QuizDataParse]
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
    private var inTieMode = false
    private var won_user_ids: [String] = []
    private var lost_user_ids: [String] = []
    private var competing_tie_user_ids: [String] = []
    
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int, competing_tie_user_ids: [String], inTieMode: Bool) {
        self.quizDatas = quizDatas
        self.inTieMode = inTieMode
        self.competing_tie_user_ids = competing_tie_user_ids
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
            let questionPromptFrame = CGRect(x: 150, y: 100, width: 200, height: 65)
            createBtn(title: "Start Question Prompt", selector: #selector(startQuestionPromptControl), backgroundColor: .purple, frame: questionPromptFrame)
            
            let revealAnswerFrame = CGRect(x: questionPromptFrame.minX,
                                           y: 200,
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
                      backgroundColor: .systemYellow,
                      frame: nextFrame)
            
//            let harderFrame = CGRect(x: 30,
//                                   y: 300,
//                                   width: 80,
//                                   height: 60)
//            createBtn(title: "make harder",
//                      selector: #selector(makeHarderPressed),
//                      backgroundColor: .gradOrange,
//                      frame: harderFrame)
            
            let easierFrame = CGRect(x: questionPromptFrame.minX,
                                   y: 300,
                                   width: 60,
                                   height: 40)
            createBtn(title: "easier",
                      selector: #selector(makeEasierPressed),
                      backgroundColor: .fuchsiaPink,
                      frame: easierFrame)
        }
    }
    
    @objc private func makeHarderPressed() {
        dataStore.updateMidQuiz(current_order: currentIndex,
                                quizDatas_length: quizDatas.count, difficulty: "hard") {
            BannerAlert.show(title: "Success", subtitle: "Increased quiz difficulty", type: .success)
        }
    }
    
    @objc private func makeEasierPressed() {
        let alertView = SCLAlertView()
        alertView.addButton("Make Easier") {
            self.dataStore.updateMidQuiz(current_order: self.currentIndex,
                                         quizDatas_length: self.quizDatas.count, difficulty: "easy") {
                BannerAlert.show(title: "Success", subtitle: "Increased quiz difficulty", type: .success)
            }
        }
        
        alertView.showWait("Make Easier?", subTitle: "Are you sure that you want to make the quiz easier?")
    }
    
    @objc private func startQuestionPromptControl() {
        if inTieMode {
            let total_tie_spots = quizDatas.first?.quizTopic.winner_tie_spots
            dataStore.markQuizTieStatus(quizDatas: quizDatas,
                                        shouldStartQuestionPrompt: true,
                                        total_tie_slots: total_tie_spots ?? 0,
                                        currentQuizData: currentData)
        } else {
            let quizManagerDataStore = CryptoSettingsDataStore()
            quizManagerDataStore.markQuizStatus(quizDatas: quizDatas,
                                                shouldStartQuestionPrompt: true,
                                                currentIndex: nil,
                                                currentQuizData: currentData, completion: { _ in
                self.checkIfQuizDatasUpdated()
            })
        }
    }
    
    @objc private func revealAnswerControl() {
        if inTieMode {
            let total_tie_spots = quizDatas.first?.quizTopic.winner_tie_spots
            dataStore.markQuizTieStatus(quizDatas: quizDatas,
                                        shouldStartQuestionPrompt: false,
                                        total_tie_slots: total_tie_spots ?? 0,
                                        currentQuizData: currentData)
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
                if let item = AnswerKeysViewController.getItem(withId: currentData.objectId ?? "") {
                    self.answer_video_url = item.answer_url
                    self.revealAnswer(with: item.correct_answer_index)
                    self.playVideoAnswer()
                }
            } else {
                let quizManagerDataStore = CryptoSettingsDataStore()
                quizManagerDataStore.markQuizStatus(quizDatas: quizDatas,
                                                    shouldStartQuestionPrompt: false,
                                                    currentIndex: currentIndex,
                                                    currentQuizData: currentData) { quizTopic in
                    self.competing_tie_user_ids =  quizTopic.competing_tie_user_ids
                    self.checkIfQuizDatasUpdated()
                }
            }
        }
    }
    
    //we update the quizdatas because sometimes can be updated mid quiz
    private func checkIfQuizDatasUpdated() {
        dataStore.getQuizData { result, error in
            if let quizDatas = result as? [QuizDataParse] {
                self.quizDatas = quizDatas
            } else if let error = error {
                if error.localizedDescription.contains("error-force-update") {
                    ForceUpdate.showAlert()
                } else {
                    BannerAlert.show(with: error)
                }
            } else {
                BannerAlert.showUnknownError(functionName: "getQuizData")
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
        btn.titleLabel?.numberOfLines = 2
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
            
            dataStore.checkLiveQuizPosition(quizData: currentData, inTieMode: inTieMode) { show_question_prompt_time, correct_answer_index, current_quiz_seconds, answer_video_url, current_quiz_data_id, shouldRevealAnswer, competing_tie_user_ids, won_array, lost_array, updated_quiz_data_ids    in
                if !self.inTieMode {
                    self.jumpToCurrentVideoMoment(current_quiz_seconds: current_quiz_seconds, current_quiz_data_id: current_quiz_data_id)
                }
                self.answer_video_url = answer_video_url
                
                if shouldRevealAnswer, let correct_answer_index = correct_answer_index {
                    if self.inTieMode {
                        self.won_user_ids = won_array
                        self.lost_user_ids = lost_array
                    }
                    self.competing_tie_user_ids = competing_tie_user_ids
                    self.revealAnswer(with: correct_answer_index)
                } else if let show_question_prompt_time = show_question_prompt_time {
                    self.startQuestionPrompt(start_time: show_question_prompt_time)
                }
                
                self.checkQuizChanged(updated_quiz_data_ids: updated_quiz_data_ids)
            }
        }
    }
    
    //This would break if it wasn't a consistent 2 options.
    //Also hard difficulty would operate differently than this.
    private func checkQuizChanged(updated_quiz_data_ids: [String]) {
        for id in updated_quiz_data_ids {
            let targetQuizData = quizDatas.first { quizData in
                return quizData.objectId == id
            }
            if let targetQuizData = targetQuizData, let answers = targetQuizData.answers {
                if answers.count > 2 {
                    //these quizdatas still have 4 answers. We need to fix this. Do an update
                    self.checkIfQuizDatasUpdated()
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
                    doCorrectAnswerHaptic()
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
    
    private func doCorrectAnswerHaptic() {
        let hapticGenerator = UIImpactFeedbackGenerator(style: .heavy)
        let delays: [TimeInterval] = [0.1, 0.12, 0.14, 0.16, 0.18, 0.2, 0.22, 0.24, 0.26, 0.28, 0.30]
        for delay in delays {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                hapticGenerator.impactOccurred()
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
        Haptics.shared.play(.heavy)
        self.answerStackView.isUserInteractionEnabled = false // added this line so user can answer once only. if immediadely clicked can select more
        for (index, answerView) in answerViews.enumerated() {
            if index == gesture.view?.tag {
                answerView.select()
            }
        }
        self.submitSelectedAnswer()
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
                let hasWon = won_user_ids.contains(User.current()?.objectId ?? "")
                let hasLost = lost_user_ids.contains(User.current()?.objectId ?? "")
                
                let hasOfficiallyEnded = won_user_ids.count == currentData.quizTopic.winner_tie_spots
                if hasOfficiallyEnded || hasWon || hasLost || isLastQuestion {
                    //the tiebreaker is over
                    //or the users who won or lost go to the leaderboard
                    self.popBackToLeaderboard()
                } else {
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    let vc = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                          currentIndex: nextIndex,
                                                                          competing_tie_user_ids: competing_tie_user_ids,
                                                                          inTieMode: inTieMode)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if isLastQuestion {
                UserDefaults.standard.removeObject(forKey: "NoSoundBannerClosed")
                UserDefaults.standard.synchronize()
                let shouldGoTieBreaker = competing_tie_user_ids.contains(User.current()?.objectId ?? "")
                if shouldGoTieBreaker || (User.isAdminUser && !competing_tie_user_ids.isEmpty){
                    let tiebreakerVC = TieBreakerViewController(competing_tie_user_ids: competing_tie_user_ids)
                    self.navigationController?.pushViewController(tiebreakerVC, animated: true)
                } else if Helpers.getTopViewController() is UINavigationController {
                    self.popBackToLeaderboard()
                    //TODO: uncomment the following lines --> at the last question, land the user on the PromoCodeUsed. The user will be able to click on the skip button to land on the leaderboard
//                    let promoVC = PromoCodeUsedViewController(shouldShowSkipBtn: true)
//                    self.navigationController?.pushViewController(promoVC, animated: true)
                }
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                let vc = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                      currentIndex: nextIndex,
                                                                      competing_tie_user_ids: competing_tie_user_ids,
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
