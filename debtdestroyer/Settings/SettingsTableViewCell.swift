//
//  SettingsTableViewCell.swift
//  nbawidget
//
//  Created by Rashmi Aher on 01/08/22.
//

import UIKit
import Reusable

class SettingsTableViewCell: UITableViewCell, Reusable {
    let logoImg = UIImageView()
    let titleLabel = UILabel()
    private let line = UIView()
    private let lineWhite = UIView()

    let chevronImageView = UIImageView(image: UIImage(named: "chevronGrey"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setLogoImg()
        setTitleLabel()
        setChevron()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLogoImg() {
        logoImg.contentMode = .scaleAspectFill
        logoImg.clipsToBounds = true
        let dimension: CGFloat = 50
        logoImg.layer.cornerRadius = dimension * 0.2
        contentView.addSubview(logoImg)
        logoImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(dimension)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .jaguarBlack
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImg.snp.trailing).offset(20)
        }
    }
    
    func whitePadding() {
        lineWhite.backgroundColor = .systemGray4
        contentView.addSubview(lineWhite)
        lineWhite.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(3)
            make.bottom.equalToSuperview()
        }
    }
    
    func setLine(check : Bool) {
        if check {
            line.backgroundColor = .systemGray6
            contentView.addSubview(line)
            line.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(70)
                make.trailing.equalToSuperview().inset(10)
                make.height.equalTo(1)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func setChevron() {
        chevronImageView.contentMode = .scaleAspectFit
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
}

extension UIColor {
    
    class func formerColor() -> UIColor {
        return UIColor(red: 0.14, green: 0.16, blue: 0.22, alpha: 1)
    }
    
    class func formerSubColor() -> UIColor {
        return UIColor(red: 0.9, green: 0.55, blue: 0.08, alpha: 1)
    }
    
    class func formerHighlightedSubColor() -> UIColor {
        return UIColor(red: 1, green: 0.7, blue: 0.12, alpha: 1)
    }
}
