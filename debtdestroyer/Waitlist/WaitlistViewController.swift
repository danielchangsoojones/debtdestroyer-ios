//
//  WaitlistViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 1/13/23.
//

import UIKit

class WaitlistViewController: UIViewController {
    
    private var messageHelper: MessageHelper?
    private let headingTitle: String
    private let subtitle: String
    private var contactUsBtn = UIButton()
    private var timer = Timer()
    private let quizDataStore = QuizDataStore()
    
    init(headingTitle: String, subtitle: String) {
        self.headingTitle = headingTitle
        self.subtitle = subtitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let waitlistView = WaitlistView(frame: self.view.frame)
        self.view = waitlistView
        waitlistView.subtitleLabel.text = subtitle
        waitlistView.titleLabel.text = headingTitle
        contactUsBtn = waitlistView.contactUsBtn
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        self.navigationItem.setHidesBackButton(true, animated: true)
        contactUsBtn.addTarget(self,action: #selector(contactUsBtnPressed),for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callTimer()
    }
    
    private func callTimer() {
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(checkWaitlist), userInfo: nil, repeats: true)
    }
    
    @objc private func checkWaitlist() {
        quizDataStore.checkWaitlist { shouldWaitlist, headingTitle, subtitle in
            if !shouldWaitlist {
                self.navigationController?.popViewController(animated: true)
            } 
        }
    }
    
    @objc private func contactUsBtnPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
}
