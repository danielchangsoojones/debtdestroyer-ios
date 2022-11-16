//
//  ConnectedAccountsTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/08/22.
//

import UIKit
import Reusable

class ConnectedAccountsTableViewCell: UITableViewCell, Reusable {
    let logoImg = UIImageView()
    let titleLabel = UILabel()
    let balanceLabel = UILabel()
    private let background = UIView()
    private let loanAccountTagLabel = UILabel()
    let recentPaymentLabel = UILabel()
    private let imgView = UIImageView()
    var chevronImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        setLoanAccountTagLabel()
        setBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLoanAccountTagLabel() {
        loanAccountTagLabel.text = "  Loan Account  "
        loanAccountTagLabel.font = UIFont.MontserratMedium(size: 12)
        loanAccountTagLabel.textColor = .white
        loanAccountTagLabel.backgroundColor = hexStringToUIColor(hex: "38C4F6")
        loanAccountTagLabel.numberOfLines = 0
        loanAccountTagLabel.layer.cornerRadius = 5
        loanAccountTagLabel.layer.masksToBounds = true
        
        contentView.addSubview(loanAccountTagLabel)
        loanAccountTagLabel.snp.makeConstraints { make in
            //            make.bottom.equalTo(background.snp.top).offset(3)
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(contentView.snp.leading).inset(22)
            make.height.equalTo(22)
        }
    }

    private func setBackground() {
        background.backgroundColor = .white
        background.layer.cornerRadius = 8
        // add shadow on cell
        background.layer.masksToBounds = false
        background.layer.shadowOpacity = 0.23
        background.layer.shadowRadius = 4
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowColor = UIColor.black.cgColor
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
            make.top.equalTo(loanAccountTagLabel.snp.bottom).inset(3)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        setLogoImg()
        setChevron(imageName: "xyz")
        setTitleLabel()
        setBalanceLabel()
        setRecentPaymentLabel()
        setTicketImage()
    }
    
    private func setLogoImg() {
        logoImg.contentMode = .scaleAspectFit
        logoImg.clipsToBounds = true
        let dimension: CGFloat = 25
        logoImg.layer.cornerRadius = dimension * 0.2
        background.addSubview(logoImg)
        logoImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(dimension)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratSemiBold(size: 18)
        titleLabel.textColor = .jaguarBlack
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
    }
    
    private func setBalanceLabel() {
        balanceLabel.font = UIFont.MontserratSemiBold(size: 14)
        balanceLabel.textColor = .jaguarBlack
        background.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
    }
    
    private func setRecentPaymentLabel() {
        recentPaymentLabel.font = UIFont.MontserratSemiBold(size: 14)
        recentPaymentLabel.textColor = .jaguarBlack
        recentPaymentLabel.adjustsFontSizeToFitWidth = true
        recentPaymentLabel.numberOfLines = 0
        background.addSubview(recentPaymentLabel)
        recentPaymentLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setTicketImage() {
        imgView.image = UIImage.init(named: "ticketC")
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.leading.equalTo(recentPaymentLabel.snp.trailing)
            make.height.width.equalTo(15)
            make.centerY.equalTo(recentPaymentLabel)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
    }

    func setChevron(imageName: String) {
        chevronImageView = UIImageView(image: UIImage(named: imageName))
        chevronImageView.contentMode = .scaleAspectFit
        background.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
}

