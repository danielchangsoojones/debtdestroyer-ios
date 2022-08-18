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
        backgroundColor = .clear
        selectionStyle = .none
        // add shadow on cell
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        setLogoImg()
        setTitleLabel()
        setBalanceLabel()
        setRemoveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLogoImg() {
        logoImg.contentMode = .scaleAspectFill
        logoImg.clipsToBounds = true
        let dimension: CGFloat = 40
        logoImg.layer.cornerRadius = dimension * 0.2
        contentView.addSubview(logoImg)
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setBalanceLabel() {
        balanceLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        balanceLabel.textColor = .jaguarBlack
        contentView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setRemoveButton() {
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(.red, for: .normal)
        removeButton.backgroundColor = .green
        contentView.addSubview(removeButton)
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(10)
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    
}

