//
//  NewGameStartViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit
import Ripple

class NewGameStartViewController: UIViewController {
    struct Constants {
        static let originalStartTime: TimeInterval = 36000
    }
    
    private var messageHelper: MessageHelper?
    var quizKickoffTime: Date?
    var timeLabel =  UILabel()
    private var timer = Timer()
    private var timeLeft: TimeInterval = Constants.originalStartTime
    var dayDateLbl = UILabel()
    var descriptionLbl = UILabel()
    var prizeBtn = GradientBtn()
    var rippleContainer = UIView()
    private var quizDatas: [QuizDataParse] = []
    private let quizDataStore = QuizDataStore()
    private var checkStartTimer = Timer()
    var rippleAdded = false
    
    override func loadView() {
        super.loadView()
        let newGameStartView = NewGameStartView(frame: self.view.frame)
        self.view = newGameStartView
        self.dayDateLbl = newGameStartView.dayDateLbl
        self.timeLabel = newGameStartView.countDownTimerLbl
        self.descriptionLbl = newGameStartView.descriptionLbl
        self.prizeBtn = newGameStartView.prizeBtn
        self.rippleContainer = newGameStartView.rippleContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setNavBarBtns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callTimer()
        
        if !rippleAdded {
            rippleAdded = true
            let location = CGPoint.init(x: rippleContainer.frame.width/2, y: rippleContainer.frame.height/2)
            ripple(location, view: rippleContainer, times: 4, duration: 2, size: 100, multiplier: 4, divider: 3, color: .white, border: 2)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkStartTimer.invalidate()
        timer.invalidate()
    }
    
    private func callTimer() {
        checkStartTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getQuizDatas), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func getQuizDatas() {
        print("getQuizDatas called")
        quizDataStore.getQuizData { quizDatas in
            self.quizDatas = quizDatas
            self.checkIfStartQuiz()
        }
    }
    
    private func checkIfStartQuiz() {
        if let quizData = quizDatas.first {
            let quizTopic = quizData.quizTopic
            self.quizKickoffTime = quizTopic.start_time
            setData(quizTopic: quizTopic)
            let now = Date()
            if quizTopic.start_time < now {
                //time to start the game
                checkStartTimer.invalidate()
                let questionVC = QuestionViewController(quizDatas: quizDatas,
                                                        currentIndex: 0)
                let navController = UINavigationController(rootViewController: questionVC)
                navController.modalPresentationStyle = .fullScreen
                present(navController, animated: true)
            }
        }
    }
    
    private func setData(quizTopic: QuizTopicParse) {
        
        let prizeAmount = Int(quizTopic.prize_amount / 100)
        let prizeAmountStr = "$\(prizeAmount)"
        let descriptionLblText = "Answer all 15 questions correctly to win " + prizeAmountStr + " towards your loans! If no one wins, the money rolls over to next week!"
        if descriptionLblText != descriptionLbl.text {
            descriptionLbl.text = descriptionLblText
        }
        
        self.dayDateLbl.text = "Tuesday Dec. 5th @ 6pm PDT"
        
        let titletxt = "      " + prizeAmountStr + " Prize      "
        if titletxt != prizeBtn.titleLabel?.text {
            if #available(iOS 15.0, *) {
                if self.prizeBtn.configuration == nil {
                    var configuration = UIButton.Configuration.plain()
                    configuration.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 25),NSAttributedString.Key.foregroundColor : UIColor.white]))
                    self.prizeBtn.configuration = configuration
                    
                } else {
                    self.prizeBtn.configuration?.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 25),NSAttributedString.Key.foregroundColor : UIColor.white]))
                }
                
            } else {
                self.prizeBtn.setTitleColor(.white, for: .normal)
                self.prizeBtn.setTitle(titletxt, for: .normal)
            }
        }
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.hidesBackButton = true
        
        let help = UIBarButtonItem.init(title: "help?", style: .done, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
        
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc func updateTime() {
        if timeLeft >= 3600 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeString(time: TimeInterval(timeLeft))
            
        } else if timeLeft <= 3600 && timeLeft >= 60 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeStringMinSec(time: TimeInterval(timeLeft))
            
        } else if timeLeft <= 60 && timeLeft >= 0 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeStringSec(time: TimeInterval(timeLeft))
            
        } else {
            timeLabel.text = "00"
            timer.invalidate()
            // Time to start game
            
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func timeStringMinSec(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func timeStringSec(time:TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format: "%02i", seconds)
    }
    
    
}
