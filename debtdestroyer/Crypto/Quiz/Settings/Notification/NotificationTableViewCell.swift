//
//  NotificationTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/02/23.
//

import UIKit
import Reusable
import CustomSwitch

class NotificationTableViewCell: UITableViewCell, Reusable {
    let titleLabel = UILabel()
    let toggleSwitch = CustomSwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setToggleSwitch()
        setTitleLabel()
        //        toggleSwitch.isOn = false
        toggleSwitch.addTarget(self, action: #selector(switchIsChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratMedium(size: 20)
        titleLabel.textColor = .jaguarBlack
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(toggleSwitch.snp.leading).inset(10)
        }
    }
    
    private func setToggleSwitch() {
        contentView.addSubview(toggleSwitch)
        toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(14)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    @objc private func switchIsChanged() {
        
        var value = toggleSwitch.isOn
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleSwitch"), object: value)
        
    }
}


