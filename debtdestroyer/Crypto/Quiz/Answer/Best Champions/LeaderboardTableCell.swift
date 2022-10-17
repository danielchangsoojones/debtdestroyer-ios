//
//  LeaderboardTableCell.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/29/22.
//

import UIKit
import Reusable

class LeaderboardTableCell: UITableViewCell, Reusable {
    let numberLabel = UILabel()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()
    let timeLable = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setTimeLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(12)
        }
        
        timeLable.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(timeLable.snp.leading).inset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(5)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(40)
            
        }
    }
    
    private func setNumLabel() {
        numberLabel.font = UIFont.MontserratLight(size: 10)
        numberLabel.textColor = .black
        contentView.addSubview(numberLabel)
    }
    
    private func setTimeLabel() {
        timeLable.text = "2.23"
        timeLable.font = UIFont.MontserratLight(size: 13)
        timeLable.textColor = .black
        timeLable.textAlignment = .center
        contentView.addSubview(timeLable)
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont.MontserratMedium(size: 15)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
    }
    
    private func setPointsLabel() {
        pointsLabel.font = UIFont.MontserratLight(size: 13)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
        contentView.addSubview(pointsLabel)
    }
}
