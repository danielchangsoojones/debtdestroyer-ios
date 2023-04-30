//
//  ReferralView.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit

class ReferralView: UIView {
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var stackView: UIStackView!
    var inviteButton: UIButton!
    var skipButton: UIButton!
    private let greenColor = UIColor(red: 114/255, green: 244/255, blue: 171/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setSkipButton()
        setInviteButton()
        setStackView()
        addPrizes()
        setSubtitleLabel()
        setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSkipButton() {
        skipButton = UIButton()
        skipButton.setTitle("Skip", for: .normal)
        skipButton.backgroundColor = .clear
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        skipButton.layer.cornerRadius = 14
        skipButton.clipsToBounds = true
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.white.cgColor
        let horizontalInset: CGFloat = 15
        let verticalInset: CGFloat = 4
        skipButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setInviteButton() {
        inviteButton = UIButton()
        inviteButton.setTitle("Invite Now", for: .normal)
        inviteButton.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        inviteButton.setTitleColor(greenColor, for: .normal)
        inviteButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        inviteButton.layer.cornerRadius = 33
        inviteButton.clipsToBounds = true
        inviteButton.layer.borderWidth = 2
        inviteButton.layer.borderColor = greenColor.cgColor
        let horizontalInset: CGFloat = 15
        let verticalInset: CGFloat = 20
        inviteButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        addSubview(inviteButton)
        inviteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
    
    private func setStackView() {
        stackView = UIStackView()
        stackView.spacing = 9
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "Earn commissions on your friends prizes. This lasts FOREVER."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        subtitleLabel.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1)
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(stackView.snp.top).offset(-50)
        }
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "🤑 Invite Friends, \nWin Prizes Together"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = greenColor
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(subtitleLabel)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-15)
        }
    }
    
    private func addPrizes() {
        //TODO: we should make the prize population backend driven
        let jackPotPrizeView = createPrizeView(title: "$1,500", subtitle: "when your friend wins Jackpot Prize")
        let topFivePrizeView = createPrizeView(title: "$10", subtitle: "when your friend wins Top 5")
        stackView.addArrangedSubview(jackPotPrizeView)
        stackView.addArrangedSubview(topFivePrizeView)
    }
    
    private func createPrizeView(title: String, subtitle: String) -> UIView {
        let prizeView = UIView()
        prizeView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        prizeView.layer.borderColor = UIColor.white.cgColor
        prizeView.layer.borderWidth = 1
        prizeView.layer.cornerRadius = 15
        prizeView.layer.shadowColor = UIColor.white.cgColor
        prizeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        prizeView.layer.shadowOpacity = 0.4
        prizeView.layer.shadowRadius = 5
        
        let introLabel = UILabel()
        introLabel.text = "You receive"
        introLabel.textAlignment = .center
        introLabel.numberOfLines = 1
        introLabel.textColor = .white
        introLabel.font = .systemFont(ofSize: 17, weight: .regular)
        prizeView.addSubview(introLabel)
        introLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = greenColor
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        prizeView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(introLabel)
            make.top.equalTo(introLabel.snp.bottom).offset(15)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        prizeView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        return prizeView
    }

}
