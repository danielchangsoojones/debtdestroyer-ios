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
    let removeButton = UIButton()
    private let background = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        setBackground()
//        setLogoImg()
//        setTitleLabel()
//        setBalanceLabel()
//        setRemoveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.top.equalTo(contentView.snp.top).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        setLogoImg()
        setTitleLabel()
        setBalanceLabel()
        setRemoveButton()
    }
    
    private func setLogoImg() {
        logoImg.contentMode = .scaleAspectFill
        logoImg.clipsToBounds = true
        let dimension: CGFloat = 40
        logoImg.layer.cornerRadius = dimension * 0.2
        background.addSubview(logoImg)
        logoImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(dimension)
           // make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .jaguarBlack
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setBalanceLabel() {
        balanceLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        balanceLabel.textColor = .jaguarBlack
        background.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setRemoveButton() {
        removeButton.setTitle("Remove", for: .normal)
        removeButton.titleLabel?.textAlignment = .left
        removeButton.setTitleColor(.red, for: .normal)
        removeButton.backgroundColor = .clear
        background.addSubview(removeButton)
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    
}

