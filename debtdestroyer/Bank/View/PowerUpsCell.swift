//
//  PowerUpsCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable

class PowerUpsCell: UITableViewCell, Reusable {
    
    let titleLabel = UILabel()
    let balanceLabel = UILabel()
    let removeButton = UIButton()
    private let background = UIView()
    var chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
        setBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setBackground() {
        background.backgroundColor = .white
        background.layer.cornerRadius =  8
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 0.23
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowRadius = 5
        background.layer.shouldRasterize = true
        background.layer.rasterizationScale = UIScreen.main.scale
        
        background.addDashBorder()
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
            make.top.equalTo(contentView.snp.top).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        setChevron(imageName: "chevronGrey")
        setTitleLabel()
        setBalanceLabel()
        
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratRegular(size: 12)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
    }
    
    private func setBalanceLabel() {
        balanceLabel.font = UIFont.MontserratRegular(size: 10)
        balanceLabel.textColor = .black
        balanceLabel.numberOfLines = 0
        background.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(chevronImageView.snp.leading)
            make.bottom.equalToSuperview().offset(-10)
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

