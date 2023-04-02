//
//  NewGameStartViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit
import AVKit

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
    var prizeBtn = GradientBlueButton()
    var rippleContainer = UIView()
    private var quizDatas: [QuizDataParse] = []
    private let quizDataStore = QuizDataStore()
    private var checkStartTimer = Timer()
    var headingLbl: UILabel!
    private var queuePlayer: AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?
    private var playbackLooper: AVPlayerLooper?
    private var quizTopicID = ""
    //visibility conditions for daily boost VC
    private let maxStoredDays = 2 // maximum number of days to keep in UserDefaults
    private let dailyBoostKey = "dailyBoostShownOn" // UserDefaults key for storing dates
    private var shouldCheckForDailyBoost = true
    
    override func loadView() {
        super.loadView()
        let newGameStartView = NewGameStartView(frame: self.view.frame)
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
        loopVideo()
        setNavBarBtns()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification, object: nil)
        getDemoQuizData()
        if User.isAdminUser || User.isIpadDemo {
            prizeBtn.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        }
        runAssignWebReferralCheck()
        updateDailyBoostUserDefaults()
        logUserSocials()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkWaitlist()
        addStartQuizBtn()
        showGameReminderPopUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    private func logUserSocials() {
        var userSocials:[String] = []
        if InstagramStory.checkIfAppOnPhone() {
            userSocials.append("Instagram")
        }
        if Helpers.checkIfAppOnPhone(appName: "snapchat") {
            userSocials.append("Snapchat")
        }
        if Helpers.checkIfAppOnPhone(appName: "twitter") {
            userSocials.append("Twitter")
        }
        //TODO: twitter & snapchat check
        quizDataStore.logUserSocials(socials: userSocials) {
            print("logged user socials")
        }
    }
    
    func updateDailyBoostUserDefaults() {
        var shownOnQuizTopics = UserDefaults.standard.array(forKey: dailyBoostKey) as? [String] ?? []
        shownOnQuizTopics = shownOnQuizTopics.suffix(2)
//        shownOnQuizTopics = []
        UserDefaults.standard.set(shownOnQuizTopics, forKey: dailyBoostKey)
    }
    
    private func showDailyBoostPopUpIfVisible() {
        //we only want to show this pop up for users who have IG on their phone, hasn't shared for upcoming quiz yet, and if it's more than 2 min or less than 23 hrs before the start of the next game
        let hasUserAlreadySeenBoost = checkIfUserSawBoost()
        if InstagramStory.checkIfAppOnPhone() && !hasUserAlreadySeenBoost && User.current()?.personalPromoImg != nil && !(User.isAppleTester || User.isIpadDemo) {
            self.quizDataStore.getSpecialReferralInfo { titleLabelText, valuePropsText in
                //i have to add the time check constraint here b/c if I do this in the line where we check for IG app being on the user's phone, the timeLeft gets fetched as 0.
                if self.timeLeft > 60 && self.timeLeft < 72000 {
                    self.showDailyBoostPopUp(titleLabelText: titleLabelText, valuePropsText: valuePropsText)
                }
            }
        }
    }
    
    private func checkIfUserSawBoost() -> Bool {
        // Check UserDefaults to see if the DailyBoostViewController should be shown
        let shownOnQuizTopics = UserDefaults.standard.array(forKey: dailyBoostKey) as? [String] ?? []
        return shownOnQuizTopics.contains(quizTopicID)
    }
    
    private func showDailyBoostPopUp(titleLabelText: String, valuePropsText: [String]) {
        var shownOnQuizTopics = UserDefaults.standard.array(forKey: dailyBoostKey) as? [String] ?? []
        let dailyBoostVC = DailyBoostViewController(titleLabelText: titleLabelText, valuePropsText: valuePropsText)
        dailyBoostVC.modalPresentationStyle = .custom
        present(dailyBoostVC, animated: true, completion: {
            dailyBoostVC.saveModalDismissed = {
                self.quizDataStore.saveSpecialReferral(socialType: "Instagram", actionType: "dismissed") {
                    shownOnQuizTopics.append(self.quizTopicID)
                    UserDefaults.standard.set(shownOnQuizTopics, forKey: self.dailyBoostKey)
                }
            }
            dailyBoostVC.saveSharePressed = {
                self.shareOnIGStory()
                self.quizDataStore.saveSpecialReferral(socialType: "Instagram", actionType: "shared") {
                    shownOnQuizTopics.append(self.quizTopicID)
                    UserDefaults.standard.set(shownOnQuizTopics, forKey: self.dailyBoostKey)
                }
            }
        })
    }
    
    private func shareOnIGStory() {
        Haptics.shared.play(.heavy)
        if let imageFile = User.current()?.personalPromoImg {
            imageFile.getDataInBackground { (data, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    // Use the `image` object to share on Instagram
                    if let data = image.pngData() {
                        InstagramStory.sharePhoto(data: data) { bool, string in
                            //user clicked share, but we really don't have a way to check unless we tell the user to tag us or we check it ourselves
                        }
                    }
                } else {
                    print("Failed to get user's promo image for Daily Boost. Please take a screenshot and text it to 317-690-5323: \(error?.localizedDescription ?? "unknown error")")
                }
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func applicationDidBecomeActive() {
        playerLayer?.player?.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkStartTimer.invalidate()
        timer.invalidate()
    }
    
    private func runAssignWebReferralCheck() {
        if User.current()?.promoCode == nil || User.current()?.promoCode == "" {
            //for users who don't enter a promo code, we're checking if they signed up on another user's referral website but forgot to enter in their promo code in the onboarding flow
            quizDataStore.assignWebReferral {
                print("successfully ran assignWebReferral")
            }
        }
    }
    
    private func checkWaitlist() {
        quizDataStore.checkWaitlist { shouldWaitlist, headingTitle, subtitle in
            if shouldWaitlist {
                let waitlistVC = WaitlistViewController(headingTitle: headingTitle, subtitle: subtitle)
                self.navigationController?.pushViewController(waitlistVC, animated: true)
            } else {
                self.callTimer()
            }
        }
    }
    
    func loopVideo() {
        let file = "silverCup.mp4".components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
        self.playerLayer = AVPlayerLayer(player: self.queuePlayer)
        guard let playerLayer = self.playerLayer else {return}
        guard let queuePlayer = self.queuePlayer else {return}
        self.playbackLooper = AVPlayerLooper.init(player: queuePlayer, templateItem: playerItem)
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.view.frame
        self.view.layer.insertSublayer(playerLayer, at: 0)
        playerLayer.player?.play()
        
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
        //need to reset the kickoff time and the timeLeft to get the timer to restart well.
        quizKickoffTime = nil
        timeLeft = Constants.originalStartTime
        checkStartTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getQuizDatas), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func getDemoQuizData() {
        //for apple review, I see if I should hide
        quizDataStore.shouldShowEarnings { shouldMakeVisible in
            User.shouldShowEarnings = shouldMakeVisible
            if User.isAppleTester || User.isIpadDemo {
                self.quizDataStore.getDemoQuizData { quizDatas in
                    self.quizDatas = quizDatas
                    self.setData(quizTopic: quizDatas.first!.quizTopic)
                }
            }
        }
    }
    
    @objc private func getQuizDatas() {
        if !(User.isAppleTester || User.isIpadDemo) {
            quizDataStore.getQuizData { result, error  in
                if let quizDatas = result as? [QuizDataParse] {
                    self.quizDatas = quizDatas
                    self.checkIfStartQuiz()
                } else if let error = error {
                    if error.localizedDescription.contains("error-force-update") {
                        let forceUpdateShown  = ForceUpdate.forceUpdateShown?.withAddedMinutes(minutes: 2)
                        
                        if forceUpdateShown == nil || forceUpdateShown! <= Date() {
                            ForceUpdate.showAlert()
                        }
                    } else {
                        BannerAlert.show(with: error)
                    }
                } else {
                    BannerAlert.showUnknownError(functionName: "getQuizData")
                }
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
            //adding in shouldCheckForDailyBoost so that we don't run the cloud call within showDailyBoostPopUpIfVisible every second
            if shouldCheckForDailyBoost{
                showDailyBoostPopUpIfVisible()
                shouldCheckForDailyBoost = false
            }
        }
    }
    
    private func showGameReminderPopUp() {
        if User.current()?.notificationStatus == nil || User.current()?.notificationStatus == "notDetermined" {
            let popupVC = ReminderTextNotificationViewController()
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            present(popupVC, animated: true, completion: nil)
        }
    }
    
    @objc private func startQuiz() {
        checkStartTimer.invalidate()
        var quizStartIndex = 0
        let currentQuizTopicIndex = quizDatas.firstIndex { quizData in
            return quizData.objectId == quizData.quizTopic.currentQuizDataID
        }
        //if we need to start them off in the middle of the quiz because they came late.
        if let currentQuizTopicIndex = currentQuizTopicIndex {
            quizStartIndex = currentQuizTopicIndex
        }
        
        let questionVC = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                      currentIndex: quizStartIndex,
                                                                      competing_tie_user_ids: [],
                                                                      inTieMode: false)
        let navController = UINavigationController(rootViewController: questionVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func setData(quizTopic: QuizTopicParse) {
        if quizTopicID != quizTopic.objectId{
            quizTopicID = quizTopic.objectId ?? ""
            User.current()?.quizPointCounter = 0 // To reset points for new topic
        }
        let apiDate = quizTopic.start_time
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .long
        formatter.timeZone = .init(abbreviation: "PDT")
        var strDate = formatter.string(from: apiDate)        
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
        
        let prizeAmount = Int(quizTopic.prize_amount / 100).withCommas()
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
        
        let inviteBtn = UIBarButtonItem.init(title: "Invite", style: .done, target: self, action: #selector(invitePressed))
        navigationItem.leftBarButtonItem = inviteBtn
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func invitePressed() {
        Haptics.shared.play(.heavy)
        let vc = PromoCodeUsedViewController(shouldShowSkipBtn: false)
        self.navigationController?.pushViewController(vc.self, animated: true)
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
            // Time to start game
            timeLabel.text = "00"
//            timer.invalidate()
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
