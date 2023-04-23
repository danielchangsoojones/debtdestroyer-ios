//
//  LiveChatView.swift
//  debtdestroyer
//
//  Created by DK on 4/18/23.
//

import UIKit

class LiveChatView: UIView {
    var videoContainer = UIView()
    private var titleLabel: UILabel!
    var timerLabel: UILabel!
    var tableView: UITableView!
    var liveChatInputView = InputChatView()
    var adminButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setContainerForVideo()
        setLabels()
        setUpLiveChatInputView()
        setUpLine()
        setTableView()
        setUpAdminButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerForVideo() {
        addSubview(videoContainer)
        videoContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setLabels() {
        titleLabel = UILabel()
        titleLabel.text = "$15,000 GAME STARTS IN"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        videoContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin).inset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        timerLabel = UILabel()
        timerLabel.text = ""
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.font = .systemFont(ofSize: 30, weight: .bold)
        videoContainer.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func setUpLiveChatInputView() {
        addSubview(liveChatInputView)
        liveChatInputView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setUpLine() {
        let line = UIView()
        line.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 52/255, alpha: 1)
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(liveChatInputView.snp.top)
            make.height.equalTo(1.5)
        }
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(liveChatInputView.snp.top)
            make.height.equalTo(200)
        }
    }
    
    private func setUpAdminButton() {
        //for DJ to toggle buttons pre-game
        adminButton = UIButton()
        adminButton.isHidden = true
        adminButton.setTitle("Admin Control", for: .normal)
        adminButton.backgroundColor = .black
        adminButton.setTitleColor(.white, for: .normal)
        adminButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        adminButton.layer.cornerRadius = 25
        adminButton.clipsToBounds = true
        adminButton.layer.borderWidth = 1
        adminButton.layer.borderColor = UIColor.white.cgColor
        let horizontalInset: CGFloat = 15
        let verticalInset: CGFloat = 15
        adminButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        videoContainer.addSubview(adminButton)
        adminButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(tableView.snp.top).offset(-10)
        }
    }
}
