//
//  AppleTesterViewController.swift
//  debtdestroyer
//
//  Created by DK on 4/18/23.
//

import UIKit
import AVKit
import SCLAlertView

class AppleTesterViewController: UIViewController {
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
    private var mux_playback_id: String?
    //visibility conditions for daily boost VC
    private let maxStoredDays = 2 // maximum number of days to keep in UserDefaults
    private let dailyBoostKey = "dailyBoostShownOn" // UserDefaults key for storing dates
    private var shouldCheckForDailyBoost = true
    private var userSocials:[String] = []
    
    override func loadView() {
        super.loadView()
        let newGameStartView = AppleTesterView(frame: self.view.frame)
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
            prizeBtn.addTarget(self, action: #selector(prizeBtnPressed), for: .touchUpInside)
        }
        runAssignWebReferralCheck()
        updateDailyBoostUserDefaults()
        logUserSocials()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        User.current()?.fetchInBackground()
        checkWaitlist()
        addStartQuizBtn()
        showGameReminderPopUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc private func prizeBtnPressed() {
        let appearance = SCLAlertView.SCLAppearance()
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Real Game", action: {
            // Handle "Real Game" option
            self.startQuiz()
        })
        alertView.addButton("Cycle Vids", action: {
            // Handle "Cycle Vids" option
            let cycleVC = CycleVidViewController()
            self.navigationController?.pushViewController(cycleVC, animated: true)
        })
        alertView.addButton("Tiebreaker", action: {
            // Handle "Tiebreaker" option
            let tieVC = TieBreakerViewController(competing_tie_user_ids: [], inTestTieMode: true)
            self.navigationController?.pushViewController(tieVC, animated: true)
        })
        
        alertView.addButton("Easy Questions", action: {
            // Handle "Tiebreaker" option
            self.checkStartTimer.invalidate()
            self.playerLayer?.player?.pause()
            self.quizDataStore.getEasyQuizData { quizDatas in
                self.quizDatas = quizDatas
                let questionVC = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                              currentIndex: 0,
                                                                              competing_tie_user_ids: [],
                                                                              inTieMode: false,
                                                                              inTestTieMode: false)
                let navController = UINavigationController(rootViewController: questionVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true)
            }
        })
        alertView.showInfo("Choose Option", subTitle: "Please choose an option to continue.")
    }
    
    private func logUserSocials() {
        let socialApps = [("instagram-stories", "Instagram"), ("snapchat", "Snapchat"), ("twitter", "Twitter"), ("fb", "Facebook"), ("whatsapp", "Whatsapp")]
        for app in socialApps {
            if Helpers.checkIfAppOnPhone(appName: app.0) {
                userSocials.append(app.1)
            }
        }
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
        let hasInstagramOrTwitter = userSocials.contains(where: { $0 == "Instagram" || $0 == "Twitter" })
        if hasInstagramOrTwitter && !hasUserAlreadySeenBoost && User.current()?.personalPromoImg != nil && !(User.isAppleTester || User.isIpadDemo) {
            self.quizDataStore.getSpecialReferralInfo { titleLabelText, valuePropsText in
                //i have to add the time check constraint here b/c if I do this in the line where we check for IG app being on the user's phone, the timeLeft gets fetched as 0.
                if self.timeLeft > 30 && self.timeLeft < 72000 {
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
        let dailyBoostVC = DailyBoostViewController(userSocials: userSocials, titleLabelText: titleLabelText, valuePropsText: valuePropsText)
        dailyBoostVC.modalPresentationStyle = .custom
        present(dailyBoostVC, animated: true, completion: {
            dailyBoostVC.saveModalDismissed = { selectedSocial in
                self.quizDataStore.saveSpecialReferral(socialType: selectedSocial, actionType: "dismissed") {
                    shownOnQuizTopics.append(self.quizTopicID)
                    UserDefaults.standard.set(shownOnQuizTopics, forKey: self.dailyBoostKey)
                }
            }
            dailyBoostVC.saveSharePressed = { selectedSocial in
                dailyBoostVC.shareButton.startSpinning()
                dailyBoostVC.shareButton.setTitle("", for: .normal)
                self.shareOnSocial(selectedSocial: selectedSocial)
                self.quizDataStore.saveSpecialReferral(socialType: selectedSocial, actionType: "shared") {
                    dailyBoostVC.shareButton.stopSpinning()
                    dailyBoostVC.shareButton.setTitle(selectedSocial == "Instagram" ? "Share on Instagram" : "Share on Twitter", for: .normal)
                    shownOnQuizTopics.append(self.quizTopicID)
                    UserDefaults.standard.set(shownOnQuizTopics, forKey: self.dailyBoostKey)
                }
            }
        })
    }
    
    private func shareOnSocial(selectedSocial: String) {
        Haptics.shared.play(.heavy)
        if selectedSocial == "Instagram" {
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
                        BannerAlert.show(title: "Failed to fetch promo image.", subtitle: "Please take a screenshot and text it to 317-690-5323", type: .error)
                    }
                }
            }
        }
        
        if selectedSocial == "Twitter" {
            let firstName = User.current()?.firstName ?? ""
            let personalPromo = User.current()?.personalPromo ?? ""
            //TODO: for some reason twitter ignores the values that come after the &. Cant figure out how to prevent this
            let referralLink = "https://debt-destroyer-production.herokuapp.com/referral?code=\(personalPromo)&name=\(firstName)"
            let tweetText = "Play Debt Destroyer (@debtdestroyer_) with me! There's a $15,000 trivia at 9PM EST daily! Sign up using my referral code via this link and download the app!\n\n\(referralLink)"
            let encodedTweetText = tweetText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "twitter://post?message=\(encodedTweetText)"
            if let url = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        if let playerItem = getTrophyPlayerItem() {
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
    }
    
    private func getTrophyPlayerItem() -> AVPlayerItem? {
        let file = "silverCup.mp4".components(separatedBy: ".")
        if let path = Bundle.main.path(forResource: file[0], ofType:file[1]) {
            let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            return playerItem
        }
        
        return nil
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
                    if let quizTopic = quizDatas.first?.quizTopic {
                        self.setData(quizTopic: quizTopic)
                    } else {
                        BannerAlert.show(title: "Error", subtitle: "Could not find the first quiz data", type: .error)
                    }
                }
            }
        }
    }
    
    @objc private func getQuizDatas() {
        if !(User.isAppleTester || User.isIpadDemo) {
            quizDataStore.getQuizData { result, error  in
                if let quizDatas = result as? [QuizDataParse] {
                    self.quizDatas = quizDatas
                    self.startPlayingGameHost(quizDatas: quizDatas)
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
    
    private func startPlayingGameHost(quizDatas: [QuizDataParse]) {
        if self.mux_playback_id != quizDatas.first?.quizTopic?.mux_playback_id {
            //hasn't set the playback id or it has changed on the backend
            //or we have switched quizDatas
            self.mux_playback_id = quizDatas.first?.quizTopic?.mux_playback_id
            if let mux_playback_id = quizDatas.first?.quizTopic?.mux_playback_id {
                if let url = URL(string: "https://stream.mux.com/\(mux_playback_id).m3u8") {
                    let playerItem = AVPlayerItem(url: url)
                    self.queuePlayer?.replaceCurrentItem(with: playerItem)
                }
            } else if let playerItem = getTrophyPlayerItem() {
                //the next quiz has switched, so quiztopic is empty
                self.queuePlayer?.replaceCurrentItem(with: playerItem)
                self.queuePlayer?.play()
            } else {
                BannerAlert.show(title: "Error", subtitle: "could not load the trophy background", type: .error)
            }
        }
        
        
    }
    
    private func checkIfStartQuiz() {
        if let quizData = quizDatas.first, let quizTopic = quizData.quizTopic {
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
        } else {
            BannerAlert.show(title: "Error", subtitle: "The quiz data does not have a quiz topic", type: .error)
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
        playerLayer?.player?.pause()
        var quizStartIndex = 0
        let currentQuizTopicIndex = quizDatas.firstIndex { quizData in
            return quizData.objectId == quizData.quizTopic?.currentQuizDataID
        }
        //if we need to start them off in the middle of the quiz because they came late.
        if let currentQuizTopicIndex = currentQuizTopicIndex {
            quizStartIndex = currentQuizTopicIndex
        }
        
        let questionVC = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                      currentIndex: quizStartIndex,
                                                                      competing_tie_user_ids: [],
                                                                      inTieMode: false,
                                                                      inTestTieMode: false)
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
