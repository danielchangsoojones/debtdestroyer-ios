//
//  WeekPrizeCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable
import SCLAlertView
import SwiftConfettiView

class WeekPrizeCell: UITableViewCell, Reusable {
    struct Constants {
        static let horizontalContainerInset: CGFloat = 10
    }
    
    private let ticketsTitle = UILabel()
    let ticketsAmountLabel = UILabel()
    let ticketsImageView = UIImageView()
    var confettiView: SwiftConfettiView!
    private let line = UIView()
    private let prizeTitleLabel = UILabel()
    let prizeDescriptionLabel = UILabel()
    let prizeAmountLabel = UILabel()
    private let containerView = UIView()
    let weekPrizeBackgroundImgView = UIImageView()
    private let prizeAmountContainer = UIView()
    private let towardsLoansLabel = UILabel()
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    private let imgView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setWeekPrizeView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        
        containerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF2474"), color2: hexStringToUIColor(hex: "FF7910"),radi: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setWeekPrizeView() {
        containerView.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalContainerInset)
            make.bottom.equalToSuperview().offset(-20)
        }
        setWeekPrizeBackgroundImgView()
        setTicketLabel()
        setConfettiBubble()
        setLine()
        setWeekPrizeLbl()
        setPrizeDescriptionLabel()
        setPrizeAmountContainer()
        setConstraints()
    }
    
    private func setConstraints() {
        let leadingOffset: CGFloat = 10
        ticketsTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
            make.centerY.equalTo(confettiView)
            make.trailing.equalTo(confettiView.snp.leading).offset(-10)
        }
        
        confettiView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(leadingOffset)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(confettiView.frame.height)
        }

        line.snp.makeConstraints { make in
            make.leading.equalTo(ticketsTitle)
            make.trailing.equalTo(confettiView)
            make.top.equalTo(confettiView.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        prizeTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.equalTo(ticketsTitle)
        }
        
        prizeDescriptionLabel.snp.makeConstraints{ make in
            make.top.equalTo(prizeTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(prizeTitleLabel)
            make.trailing.equalTo(confettiView)
        }

        prizeAmountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        towardsLoansLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(prizeAmountLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        prizeAmountContainer.snp.makeConstraints { make in
            make.leading.equalTo(prizeTitleLabel)
            make.trailing.equalTo(line)
            make.top.equalTo(prizeDescriptionLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    private func setWeekPrizeBackgroundImgView() {
//        weekPrizeBackgroundImgView.image = UIImage.init(named: "backgroundGrad")
        weekPrizeBackgroundImgView.backgroundColor = .clear
        weekPrizeBackgroundImgView.layer.cornerRadius = 8
        containerView.addSubview(weekPrizeBackgroundImgView)
        weekPrizeBackgroundImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setTicketLabel() {
        ticketsTitle.text = "You Have"
        ticketsTitle.font = UIFont.MontserratSemiBold(size: 28)
        ticketsTitle.numberOfLines = 2
        ticketsTitle.textColor = .white
        containerView.addSubview(ticketsTitle)
    }
    
    private func setConfettiBubble() {
        let frame = CGRect(x: 50, y: 50, width: 120, height: 120)
        confettiView = SwiftConfettiView(frame: frame)
        confettiView.backgroundColor = .white
        confettiView.layer.cornerRadius = frame.height / 2
        confettiView.type = .confetti
        confettiView.intensity = 0.85
        confettiView.clipsToBounds = true
        containerView.addSubview(confettiView)
        confettiView.startConfetti()
        
        let ticketsStackView = UIStackView()
        ticketsStackView.axis = .horizontal
        ticketsStackView.distribution = .fill
        ticketsStackView.alignment = .leading
        ticketsStackView.spacing = 5
        confettiView.addSubview(ticketsStackView)
        ticketsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        ticketsAmountLabel.font = UIFont.MontserratSemiBold(size: 16)
        ticketsAmountLabel.textColor = .black
        ticketsStackView.addArrangedSubview(ticketsAmountLabel)
        ticketsAmountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        imgView.image = UIImage.init(named: "ticketC")
        ticketsStackView.addArrangedSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }

    }
    
    private func setLine() {
        line.backgroundColor = .white.withAlphaComponent(0.5)
        containerView.addSubview(line)
    }
    
    private func setWeekPrizeLbl() {
        prizeTitleLabel.text = "This Week's Prize"
        prizeTitleLabel.numberOfLines = 1
        prizeTitleLabel.textColor = .white
        prizeTitleLabel.textAlignment = .left
        prizeTitleLabel.font = UIFont.MontserratBold(size: 22)
        containerView.addSubview(prizeTitleLabel)
    }
    
    private func setPrizeDescriptionLabel() {
        prizeDescriptionLabel.text = "The winner will be announced soon..!"
        prizeDescriptionLabel.numberOfLines = 2
        prizeDescriptionLabel.textColor = .white
        prizeDescriptionLabel.textAlignment = .left
        prizeDescriptionLabel.font = UIFont.MontserratRegular(size: 15)
        containerView.addSubview(prizeDescriptionLabel)
    }
    
    private func setPrizeAmountContainer() {
        prizeAmountContainer.backgroundColor = .white
        prizeAmountContainer.layer.cornerRadius = 10
        containerView.addSubview(prizeAmountContainer)
        
        prizeAmountLabel.textColor = UIColor.fuchsiaPink
        prizeAmountLabel.textAlignment = .center
        prizeAmountLabel.font = UIFont.MontserratMedium(size: 33)
        prizeAmountContainer.addSubview(prizeAmountLabel)
        
        towardsLoansLabel.textColor = prizeAmountLabel.textColor
        towardsLoansLabel.textAlignment = .center
        towardsLoansLabel.text = "towards your student loans"
        towardsLoansLabel.font = UIFont.MontserratRegular(size: 14)
        prizeAmountContainer.addSubview(towardsLoansLabel)
    }
    
//    private func setInfoBtn() {
//        weekPrizeInfoBtn.setBackgroundImage(UIImage.init(named: "Info"), for: .normal)
//        weekPrizeInfoBtn.addTarget(self,
//                                   action: #selector(weekPrizeInfoBtnClicked),
//                                   for: .touchUpInside)
//        weekPrizeView.addSubview(weekPrizeInfoBtn)
//        weekPrizeInfoBtn.snp.makeConstraints{ make in
//            make.top.equalTo(weekPrizeBackgroundImgView.snp.top).offset(20)
//            make.leading.equalTo(weekPrizeLbl.snp.trailing).offset(5)
//            make.height.width.equalTo(25)
//        }
//    }
//
//    @objc private func weekPrizeInfoBtnClicked() {
//        print("weekPrizeInfoBtnClicked")
//        self.showAlert()
//    }
//
//    private func showAlert() {
//        let appearance = SCLAlertView.SCLAppearance(
//            showCloseButton: false
//        )
//        let alertView = SCLAlertView(appearance: appearance)
//        alertView.addButton("OK", action: {
//            print("hello")
//        })
//        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
//    }
    
}

