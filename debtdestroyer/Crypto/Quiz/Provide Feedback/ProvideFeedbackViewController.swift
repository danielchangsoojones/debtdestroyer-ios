//
//  ProvideFeedbackViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class ProvideFeedbackViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private let quizTopicDatas: QuizTopicParse
    private var dataStore = QuizDataStore()
    var feedbackView = ProvideFeedbackView()
    private var nextQuizButton = UIButton()
    private var feedbackButton = UIButton()
    var titleLabel = UILabel()
    var color1 = UIColor()
    var color2 = UIColor()
    
    init(quizTopicDatas: QuizTopicParse) {
        self.quizTopicDatas = quizTopicDatas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        feedbackView = ProvideFeedbackView(frame: self.view.bounds)
        self.view = feedbackView
        nextQuizButton = feedbackView.nextQuizButton
        feedbackButton = feedbackView.feedbackButton
        color1 = feedbackView.hexStringToUIColor(hex: "FF2474")
        color2 = feedbackView.hexStringToUIColor(hex: "FF7910")
        feedbackView.nextQuizButton.addTarget(self, action: #selector(nextQuizButtonPressed), for: .touchUpInside)
        feedbackView.feedbackButton.addTarget(self, action: #selector(feedbackButtonPressed), for: .touchUpInside)
        if User.shouldShowEarnings {
            feedbackView.descriptionLabel1.text = "Your " + quizTopicDatas.name + " will be sent within 24 hours. It takes us up to 24 hours since we have to manually send out the rewards currently."
            feedbackView.descriptionLabel1.text = "Thanks for learning about " + quizTopicDatas.name + "! Please come back tommorow for our next coin quiz about a new coin where you’ll earn airdrops for that coin!"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarBtns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setGradientNavigationTitle()
        setUIforStartQuizBtn()
    }
    
    private func setGradientNavigationTitle() {
        if User.shouldShowEarnings {
            let navTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: 120, height: 25))
            navTitle.text = "You’ve Earned 2 " + quizTopicDatas.name + "!"
            navTitle.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
            navTitle.textAlignment = .center
            let gradientLabel = feedbackView.getGradientLayer(bounds: navTitle.bounds)
            navTitle.textColor = feedbackView.gradientColor(bounds: navTitle.bounds, gradientLayer: gradientLabel)
            self.navigationItem.titleView = navTitle
        }
    }
    
    private func setUIforStartQuizBtn() {
        nextQuizButton.layer.cornerRadius =  8
        nextQuizButton.clipsToBounds = true
        let gradientForText = feedbackView.getGradientLayer(bounds: nextQuizButton.bounds)
        nextQuizButton.setTitleColor(feedbackView.gradientColor(bounds: nextQuizButton.bounds, gradientLayer: gradientForText), for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: nextQuizButton.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 8
        
        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:nextQuizButton.bounds, cornerRadius:8).cgPath
        border.frame = nextQuizButton.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = 4
        gradient.mask = border
        
        nextQuizButton.layer.addSublayer(gradient)
    }
    
    private func setNavBarBtns() {
        navigationItem.backButtonTitle = ""
        
        var helpImg = UIImage.init(named: "Help")
        helpImg = helpImg?.withRenderingMode(.alwaysOriginal)
        let help = UIBarButtonItem(image: helpImg , style: .plain, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
        
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func nextQuizButtonPressed() {
        let startQuizVC = StartQuizViewController()
        self.navigationController?.pushViewController(startQuizVC, animated: true)
    }
    
    @objc private func feedbackButtonPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
}
