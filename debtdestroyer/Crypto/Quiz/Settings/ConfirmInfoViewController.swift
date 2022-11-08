//
//  ConfirmInfoViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit

class ConfirmInfoViewController: UIViewController {
    
    var confirmInfoView = ConfirmInfoView()
    var titleLbl = UILabel()
    var nextBtn = SpinningWithGradButton()
    private var messageHelper: MessageHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmInfoView = ConfirmInfoView(frame: self.view.bounds)
        self.view = confirmInfoView
        self.nextBtn = confirmInfoView.nextBtn
        self.titleLbl = confirmInfoView.titleLbl
        
        self.nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        
        setNavBarBtns()
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        self.navigationController?.setStatusBar(backgroundColor: .white)
        let navBtn = UIButton()
        let attStr = NSMutableAttributedString(string: "Questions?", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15)])
        
        attStr.append(NSMutableAttributedString(string: " Message us.", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor:UIColor.black]))
        
        navBtn.setAttributedTitle(attStr, for: .normal)
        navBtn.addTarget(self, action: #selector(questionsPressed), for: .touchUpInside)
        let helpButton = UIBarButtonItem(customView: navBtn)
        navigationItem.rightBarButtonItem = helpButton
    }
    
    @objc private func questionsPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func nextBtnPressed() {
        
    }

    
}
