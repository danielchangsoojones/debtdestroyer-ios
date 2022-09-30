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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(nameLabel)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel)
            make.top.bottom.equalToSuperview().inset(30)
            make.trailing.equalTo(pointsLabel.snp.leading)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalTo(nameLabel)
        }
    }
    
    private func setNumLabel() {
        numberLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        numberLabel.textColor = .black
        contentView.addSubview(numberLabel)
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
    }
    
    private func setPointsLabel() {
        pointsLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        pointsLabel.textColor = .black
        contentView.addSubview(pointsLabel)
    }
}
