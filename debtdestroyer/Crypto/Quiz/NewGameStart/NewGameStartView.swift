//
//  NewGameStartView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit
import TTTAttributedLabel

class NewGameStartView: UIView, TTTAttributedLabelDelegate {
    var videoContainer = UIView()
    var settingsButton: UIButton!
    var inviteButton: UIButton!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setContainerForVideo()
        setSettingsButton()
        setInviteButton()
        setTableView()
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
    
    private func setSettingsButton() {
        if let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate) {
            settingsButton = UIButton()
            settingsButton.tintColor = .white
            settingsButton.setImage(image, for: .normal)
            settingsButton.imageView?.contentMode = .scaleAspectFit
            videoContainer.addSubview(settingsButton)
            settingsButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(20)
                make.top.equalTo(self.snp.topMargin).inset(20)
            }
        }
    }
    
    private func setInviteButton() {
        inviteButton = UIButton()
        inviteButton.setTitle("Invite", for: .normal)
        inviteButton.backgroundColor = .clear
        inviteButton.setTitleColor(.white, for: .normal)
        inviteButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        inviteButton.layer.cornerRadius = 14
        inviteButton.clipsToBounds = true
        inviteButton.layer.borderWidth = 1
        inviteButton.layer.borderColor = UIColor.white.cgColor
        let horizontalInset: CGFloat = 15
        let verticalInset: CGFloat = 4
        inviteButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        videoContainer.addSubview(inviteButton)
        inviteButton.snp.makeConstraints { make in
            make.centerY.equalTo(settingsButton)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .black
        videoContainer.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(inviteButton.snp.bottom).offset(10)
        }
    }
}
