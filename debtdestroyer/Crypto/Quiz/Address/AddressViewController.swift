//
//  AddressViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class AddressViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var dataStore = QuizDataStore()
    var addView = AddressView()
    private let quizTopicDatas: QuizTopicParse
    
    init(quizTopicDatas: QuizTopicParse) {
        self.quizTopicDatas = quizTopicDatas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let addView = AddressView(frame: self.view.frame)
        self.view = addView
    
        addView.addLabel.text = "Enter Your " + quizTopicDatas.name + " Address"
        addView.addTextField.placeholder = quizTopicDatas.name + "_sfjlsdfisdlfjsljfls"
        addView.descriptionLabel.text = "This is the address where you would like to have your " + quizTopicDatas.name + " sent. It takes us up to 24 hours to send you your coin rewards since we currently have to manually send out the rewards."
        
        addView.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        messageHelper = MessageHelper(currentVC: self, delegate: nil)
        setNavBarBtns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       setGradientNavigationTitle()
    }
    
    private func setGradientNavigationTitle() {
        let navTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: 120, height: 25))
        navTitle.text = "You’ve Earned 2 " + quizTopicDatas.name + "!"
        navTitle.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        navTitle.textAlignment = .center
        let gradientLabel = addView.getGradientLayer(bounds: navTitle.bounds)
        navTitle.textColor = addView.gradientColor(bounds: navTitle.bounds, gradientLayer: gradientLabel)
        self.navigationItem.titleView = navTitle
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
    
    @objc private func nextBtnPressed() {
        let provideFeedbackVC = ProvideFeedbackViewController(quizTopicDatas: quizTopicDatas)
        self.navigationController?.pushViewController(provideFeedbackVC, animated: true)
    }
}

