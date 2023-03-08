//
//  NotificationTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/02/23.
//

import UIKit
import Reusable

class NotificationTableViewCell: UITableViewCell, Reusable {
    let titleLabel = UILabel()
    var toggleSegment = HBSegmentedControl()
    private let disclosureLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setToggleSegment()
        setTitleLabel()
        setDisclosureLabel()
        toggleSegment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
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
            make.centerY.equalTo(toggleSegment)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(toggleSegment.snp.leading).inset(10)
        }
    }

    private func setToggleSegment() {
        let items = ["ON", "OFF"]
        toggleSegment.items = items
        toggleSegment.font = UIFont.MontserratSemiBold(size: 14)
        toggleSegment.borderColor = .blue
        toggleSegment.selectedIndex = 0
        toggleSegment.padding = 1
        toggleSegment.backgroundColor = .blue
        toggleSegment.selectedLabelColor = .blue
        toggleSegment.unselectedLabelColor = .white
        
        toggleSegment.layer.cornerRadius = 17.5
        toggleSegment.layer.masksToBounds = true
        toggleSegment.clipsToBounds = true
        contentView.addSubview(toggleSegment)
        toggleSegment.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(90)
            make.height.equalTo(35)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        var value = 1
        if toggleSegment.selectedIndex == 0 {
            value = 1
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleSegmentForNotification"), object: value)
        } else {
            value = 0
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleSegmentForNotification"), object: value)
        }
    }
    
    private func setDisclosureLabel() {
        disclosureLbl.text = "Turn on your notifications to get notified 15 minutes before a game is starting."
        disclosureLbl.numberOfLines = 0
        disclosureLbl.textAlignment = .left
        disclosureLbl.textColor = .black
        disclosureLbl.font = UIFont.MontserratRegular(size: 15)
        contentView.addSubview(disclosureLbl)
        disclosureLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}


