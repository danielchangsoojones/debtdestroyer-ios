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
    let imgView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setImgView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(imgView)
            make.width.equalTo(12)
        }
        
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.bottom.equalToSuperview().inset(5)
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(imgView)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(5)
            make.width.lessThanOrEqualToSuperview()
        }
        
        
    }
    
    private func setNumLabel() {
        numberLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        numberLabel.textColor = .black
        contentView.addSubview(numberLabel)
    }
    
    private func setImgView() {
        imgView.backgroundColor = .coinbaseBlue
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        contentView.addSubview(imgView)
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
    }
    
    private func setPointsLabel() {
        pointsLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
        pointsLabel.layer.borderColor = UIColor.darkGray.cgColor
        pointsLabel.layer.borderWidth = 0.5
        pointsLabel.layer.cornerRadius = 15
        contentView.addSubview(pointsLabel)
    }
}
