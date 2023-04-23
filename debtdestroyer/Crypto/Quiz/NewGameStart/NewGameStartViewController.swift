//
//  NewGameStartViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit
import SnapKit
import AVKit
import SCLAlertView

class NewGameStartViewController: UIViewController {
    struct Constants {
        static let originalStartTime: TimeInterval = 36000
    }
    private var messageHelper: MessageHelper?
    var quizKickoffTime: Date?
    private var timer = Timer()
    private var timeLeft: TimeInterval = Constants.originalStartTime
    
    private var quizDatas: [QuizDataParse] = []
    private let quizDataStore = QuizDataStore()
    private var checkStartTimer = Timer()
    
    //live stream
    private var queuePlayer: AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?
    private var playbackLooper: AVPlayerLooper?
    private var quizTopicID = ""
    private var mux_playback_id: String?
    private var timeLeftLabelText = "00"
    private var bottomConstraint: Constraint?
    private var liveChatInputView = InputChatView()
    private let liveChatBgGradient = CAGradientLayer()
    private var sendMessageButton: UIButton!
    private var liveChatTableView: UITableView!
    private var liveChatMessages: [LiveChatParse] = []
    private var isLiveChatOn = false
    
    //visibility conditions for daily boost VC
    private let maxStoredDays = 2 // maximum number of days to keep in UserDefaults
    private let dailyBoostKey = "dailyBoostShownOn" // UserDefaults key for storing dates
    private var shouldCheckForDailyBoost = true
    private var userSocials:[String] = []
    
    //Home Redesign
    private var tableView: UITableView!
    private var infoSections = [InfoSection]()
    private var gameContent: [String] = [] // we can use this if we want to have multiple mini games
    private var winnerContent: [WinnerInfo] = [] //to showcase winners
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        super.loadView()
        let newGameStartView = NewGameStartView(frame: self.view.frame)
        self.view = newGameStartView
        tableView = newGameStartView.tableView
        setup(newGameStartView.tableView)
        newGameStartView.settingsButton.addTarget(self, action: #selector(showSettingsVC), for: .touchUpInside)
        newGameStartView.inviteButton.addTarget(self, action: #selector(showInviteVC), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
        if User.isAdminUser || User.isIpadDemo {
            if let view = view as? NewGameStartView {
                view.inviteButton.removeTarget(nil, action: nil, for: .allEvents)
                view.inviteButton.setTitle("Admin Control", for: .normal)
                view.inviteButton.addTarget(self, action: #selector(adminBtnPressed), for: .touchUpInside)
            }
        }
        callTimer()
        getDemoQuizData()
        runAssignWebReferralCheck()
        updateDailyBoostUserDefaults()
        logUserSocials()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        User.current()?.fetchInBackground()
        showGameReminderPopUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
        loadPastWinners()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        checkStartTimer.invalidate()
        timer.invalidate()
    }
    
    private func loadPastWinners() {
        quizDataStore.loadPastWinners { pastWinners, totalAmountWon in
            let totalWinnings = self.numberToDollar(amount: totalAmountWon)
            self.winnerContent = pastWinners
            self.infoSections = [
                InfoSection(title: "🌟️ GAME STARTS AT 9PM EST DAILY!", content: self.gameContent.compactMap({ return "Cell \($0)"
                })),
                
                InfoSection(title: "🤑️ Total Won: \(totalWinnings)", content: self.winnerContent.compactMap({ return "Cell \($0)"
                }))
            ]
            self.tableView.reloadData()
        }
    }
    
    private func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: HeaderTableViewCell.self)
        tableView.register(cellType: GameInfoTableViewCell.self)
        tableView.register(cellType: PastWinnerTableViewCell.self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @objc private func showSettingsVC() {
        Haptics.shared.play(.light)
        let settingsVC = CryptoSettingsViewController()
        self.navigationController?.pushViewController(settingsVC.self, animated: true)
    }
    
    @objc private func showInviteVC() {
        Haptics.shared.play(.light)
        let vc = ReferralViewController(shouldShowSkipBtn: false)
        self.navigationController?.pushViewController(vc.self, animated: true)
    }
    
    private func showGameReminderPopUp() {
        if User.current()?.notificationStatus == nil || User.current()?.notificationStatus == "notDetermined" {
            let popupVC = ReminderTextNotificationViewController()
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            present(popupVC, animated: true, completion: nil)
        }
    }
    
    @objc private func applicationDidBecomeActive() {
        playerLayer?.player?.play()
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
            
            //we are fetching live chat messages
            if (isLiveChatOn) {
                quizDataStore.getLiveChatMessages(quizTopicID: quizTopicID) { liveChatMessageParses in
                    self.liveChatMessages = liveChatMessageParses
                    self.liveChatTableView.reloadData()
                    self.scrollToLastMessage()
                }
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
    }
    
    @objc func updateTime() {
        if timeLeft >= 3600 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLeftLabelText = timeString(time: TimeInterval(timeLeft))
        } else if timeLeft <= 3600 && timeLeft >= 60 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLeftLabelText = timeStringMinSec(time: TimeInterval(timeLeft))
        } else if timeLeft <= 60 && timeLeft >= 0 {
            timeLeft = quizKickoffTime?.timeIntervalSinceNow ?? 0
            timeLeftLabelText = timeStringSec(time: TimeInterval(timeLeft))
        } else {
            // Time to start game
            timeLeftLabelText = "00"
            //            timer.invalidate()
        }
        
        //updating the time
        let indexPath = IndexPath(row: 1, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? GameInfoTableViewCell {
            cell.set(timeLeftLabel: timeLeftLabelText)
        }
        if (isLiveChatOn) {
            if let view = view as? LiveChatView {
                view.timerLabel.text = timeLeftLabelText
            }
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

//Admin controls
extension NewGameStartViewController {
    @objc private func adminBtnPressed() {
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
}

//live host + live chat
extension NewGameStartViewController {
    private func startPlayingGameHost(quizDatas: [QuizDataParse]) {
        //automatically pops up live chat if T-10 min til game.
        if timeLeft <= 600 && timeLeft > 0 {
            if !isLiveChatOn {
                loopDefaultVideo() // we set up trophy default + live chat
                self.isLiveChatOn = true
            }
            
            if self.mux_playback_id != quizDatas.first?.quizTopic?.mux_playback_id {
                //so that we run the function below only once
                self.mux_playback_id = quizDatas.first?.quizTopic?.mux_playback_id
                if let mux_playback_id = quizDatas.first?.quizTopic?.mux_playback_id {
                    if let url = URL(string: "https://stream.mux.com/\(mux_playback_id).m3u8") {
                        //we show the live host!
                        self.playbackLooper = nil //otherwise, the live video doesn't show
                        let playerItem = AVPlayerItem(url: url)
                        self.queuePlayer?.replaceCurrentItem(with: playerItem)
                    }
                } else if let playerItem = getTrophyPlayerItem() {
                    //we revert back to the trophy view when we delete the mux playback id
                    self.queuePlayer?.replaceCurrentItem(with: playerItem)
                } else {
                    BannerAlert.show(title: "Error", subtitle: "could not load live host or trophy background", type: .error)
                }
            }
        }
    }
    
    func loopDefaultVideo() {
        if let playerItem = getTrophyPlayerItem() {
            self.tabBarController?.tabBar.isHidden = true
            let liveChatView = LiveChatView(frame: self.view.frame)
            self.view = liveChatView
            self.liveChatTableView = liveChatView.tableView
            setLiveChatInputView()
            setKeyboardDetector()
            setChatTableView()
            //so that DJ can toggle the games
            liveChatView.adminButton.isHidden = false
            liveChatView.adminButton.addTarget(self, action: #selector(adminBtnPressed), for: .touchUpInside)
            
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
    
    private func setLiveChatInputView() {
        if let view = view as? LiveChatView {
            liveChatInputView = view.liveChatInputView
            liveChatInputView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                self.bottomConstraint = make.bottom.equalToSuperview().constraint
            }
            sendMessageButton = liveChatInputView.sendButton
            sendMessageButton.addTarget(self, action: #selector(pressedSendMsgBtn), for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc private func pressedSendMsgBtn() {
        //TODO: we want to send off the message + show it to all users
        if let localMessage = liveChatInputView.textView.text, !localMessage.isEmpty {
            let liveChatParse = LiveChatParse()
            liveChatParse.message = localMessage
            liveChatMessages.append(liveChatParse)
            liveChatTableView.reloadData()
            liveChatInputView.textView.text = ""
            scrollToLastMessage()
            Haptics.shared.play(.medium)
            quizDataStore.sendLiveChatMessage(message: localMessage, quizTopicID: quizTopicID) {}
        }
    }
    
    private func scrollToLastMessage() {
        let indexPath = IndexPath(row: self.liveChatMessages.count - 1, section: 0)
        liveChatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @objc private func hideKeyboard() {
        liveChatInputView.textView.endEditing(true)
    }
    
    private func setKeyboardDetector() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        if isKeyboardShowing {
            bottomConstraint?.update(offset: -keyboardHeight)
            liveChatInputView.bottomConstraint?.update(offset: -liveChatInputView.topOffset)
        } else {
            bottomConstraint?.update(offset: 0)
            liveChatInputView.bottomConstraint?.update(offset: -liveChatInputView.originalBottomConstraint)
        }
        
        UIView.animate(withDuration: 0,
                       delay: 0,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in}
    }
    
    private func setChatTableView() {
        liveChatTableView.delegate = self
        liveChatTableView.dataSource = self
        liveChatTableView.register(cellType: LiveChatTableViewCell.self)
        liveChatTableView.separatorStyle = .none
    }
}

// Share functionalities
extension NewGameStartViewController {
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
    
    private func runAssignWebReferralCheck() {
        if User.current()?.promoCode == nil || User.current()?.promoCode == "" {
            //for users who don't enter a promo code, we're checking if they signed up on another user's referral website but forgot to enter in their promo code in the onboarding flow
            quizDataStore.assignWebReferral {
                print("successfully ran assignWebReferral")
            }
        }
    }
}

//Home Redesign
class InfoSection {
    let title: String
    let content: [String] //refers to the content within the section
    
    init(title: String,
         content: [String]) {
        self.title = title
        self.content = content
    }
}

//we're populating the tableViews for the home screen & live chat screen
extension NewGameStartViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == liveChatTableView {
            //this is the tableView for the live chat
            return 1
        } else {
            //this is the tableView for the home screen
            return infoSections.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == liveChatTableView {
            //this is the tableView for the live chat
            return liveChatMessages.count
        } else {
            //this is the tableView for the home screen
            return 2 //header row + content row
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == liveChatTableView {
            //this is the tableView for the live chat
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LiveChatTableViewCell.self)
            cell.set(name: liveChatMessages[indexPath.row].user.firstName , message: liveChatMessages[indexPath.row].message)
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            //this is the tableView for the home screen
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HeaderTableViewCell.self)
                cell.set(label: infoSections[indexPath.section].title)
                cell.selectionStyle = .none
                return cell
            } else {
                if indexPath.section == 0 {
                    //show game info
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameInfoTableViewCell.self)
                    cell.selectionStyle = .none
                    cell.showGameRules = {
                        let urlString = "https://www.debtdestroyer.app/tie-breaker-rules"
                        if let url = URL(string: urlString) {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    return cell
                } else {
                    //show winners
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PastWinnerTableViewCell.self)
                    cell.updateCellWith(row: winnerContent)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == liveChatTableView {
            //this is the tableView for the live chat
            return UITableView.automaticDimension
        } else {
            //this is the tableView for the home screen
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            } else {
                //TODO: this is hard coded -- weird that we're not able to dynamically size the cell based on its content
                return 280
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
