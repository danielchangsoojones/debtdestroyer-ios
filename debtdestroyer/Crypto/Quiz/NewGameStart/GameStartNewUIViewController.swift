//
//  GameStartNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 19/12/22.
//

import UIKit

class GameStartNewUIViewController: UIViewController {
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
    var prizeBtn = GradientBlueButton()
    private var quizDatas: [QuizDataParse] = []
    private let quizDataStore = QuizDataStore()
    private var checkStartTimer = Timer()
    var headingLbl: UILabel!
    
    override func loadView() {
        super.loadView()
        let newGameStartView = GameStartNewUIView(frame: self.view.frame)
        self.view = newGameStartView
        self.dayDateLbl = newGameStartView.dayDateLbl
        self.timeLabel = newGameStartView.countDownTimerLbl
        self.descriptionLbl = newGameStartView.descriptionLbl
        self.prizeBtn = newGameStartView.prizeBtn
        self.headingLbl = newGameStartView.headingLbl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setNavBarBtns()
        getDemoQuizData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callTimer()
        addStartQuizBtn()
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
    
    @objc private func addStartQuizBtn() {
        if (User.current()?.isAppleTester ?? false) {
            let btn = UIButton()
            btn.setTitle("Start Quiz", for: .normal)
            btn.backgroundColor = .blue
            btn.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
            view.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(prizeBtn.snp.top).offset(-10)
                make.width.height.equalTo(prizeBtn)
            }
        }
    }
    
    private func callTimer() {
        checkStartTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getQuizDatas), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func getDemoQuizData() {
        //for apple review, I see if I should hide
        quizDataStore.shouldShowEarnings { shouldMakeVisible in
            User.shouldShowEarnings = shouldMakeVisible
            if (User.current()?.isAppleTester ?? false) {
                self.quizDataStore.getDemoQuizData { quizDatas in
                    self.quizDatas = quizDatas
                    self.setData(quizTopic: quizDatas.first!.quizTopic)
                }
            }
        }
    }
    
    @objc private func getQuizDatas() {
        if !(User.current()?.isAppleTester ?? false) {
            quizDataStore.getQuizData { quizDatas, error  in
                self.quizDatas = quizDatas as! [QuizDataParse]
                self.checkIfStartQuiz()
            }
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
                startQuiz()
            }
        }
    }
    
    @objc private func startQuiz() {
        checkStartTimer.invalidate()
        let questionVC = QuestionViewController(quizDatas: quizDatas,
                                                currentIndex: 0)
        let navController = UINavigationController(rootViewController: questionVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func setData(quizTopic: QuizTopicParse) {
        let apiDate = quizTopic.start_time
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .long
        formatter.timeZone = .init(abbreviation: "PDT")
        var strDate = formatter.string(from: apiDate)
        //        var strDate = formatter.string(from: apiDate.toLocalTime())
        
        strDate = strDate.replacingOccurrences(of: " at ", with: " @ ")
        strDate = strDate.replacingOccurrences(of: ",", with: "")
        strDate = strDate.replacingOccurrences(of: ":", with: " ")
        var stringArr = strDate.components(separatedBy: " ")
        stringArr.remove(at: 3)
        let shortMonth : String = stringArr[1].prefix(3) + "."
        stringArr.remove(at: 1)
        stringArr.insert(shortMonth, at: 1)
        if stringArr[2] == "1" {
            stringArr[2] = "1st"
        } else if stringArr[2] == "2" {
            stringArr[2] = "2nd"
        } else if stringArr[2] == "3" {
            stringArr[2] = "3rd"
        } else {
            stringArr[2] = stringArr[2] + "th"
        }
        stringArr.remove(at: 6)
        stringArr.remove(at: 5)
        
        
        let finalDate = stringArr.joined(separator: " ")
        self.dayDateLbl.text = finalDate
        
        let prizeAmount = Int(quizTopic.prize_amount / 100)
        let prizeAmountStr = "$\(prizeAmount)"
        let descriptionLblText = quizTopic.ticker
        if descriptionLblText != descriptionLbl.text {
            descriptionLbl.text = descriptionLblText
        }
        
        headingLbl.text = quizTopic.name
        
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
        
        if !User.shouldShowEarnings {
            descriptionLbl.text = "Come play our trivia daily to see if you will win!"
            self.prizeBtn.isHidden = true
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
