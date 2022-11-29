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
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    private var timeLeft: TimeInterval = Constants.originalStartTime
    var dayDateLbl = UILabel()
    var headingLbl = UILabel()
    var descriptionLbl = UILabel()
    var prizeBtn = GradientBtn()
    var rippleContainer = UIView()

    override func loadView() {
        super.loadView()
        let newGameStartView = NewGameStartView(frame: self.view.frame)
        self.view = newGameStartView
        self.dayDateLbl = newGameStartView.dayDateLbl
        self.headingLbl = newGameStartView.headingLbl
        self.timeLabel = newGameStartView.countDownTimerLbl
        self.descriptionLbl = newGameStartView.descriptionLbl
        self.prizeBtn = newGameStartView.prizeBtn
        self.rippleContainer = newGameStartView.rippleContainer
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)

        setNavBarBtns()

        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let location = CGPoint.init(x: rippleContainer.frame.width/2, y: rippleContainer.frame.height/2)
        //        ripple(location, view: rippleContainer, times: 5)
        ripple(location, view: rippleContainer, times: 4, duration: 2, size: 100, multiplier: 4, divider: 3, color: .white, border: 2)
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
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.timeMinHr
            timeLabel.text = timeString(time: TimeInterval(timeLeft))

        } else {
            timeLabel.text = "00:00:00"
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
}
