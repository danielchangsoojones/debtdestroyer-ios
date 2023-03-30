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
    let winnerPhoto = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setPhoto()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        winnerPhoto.isHidden = true
//        winnerPhoto.snp.removeConstraints()
//        winnerPhoto.removeFromSuperview()
    }
    
    func addImg() {
        nameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(5)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(40)
        }
        
        winnerPhoto.isHidden = false
        winnerPhoto.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(300)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(25)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
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
        numberLabel.textAlignment = .center
        contentView.addSubview(numberLabel)
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
    
    private func setPhoto() {
        winnerPhoto.contentMode = .scaleAspectFit
        contentView.addSubview(winnerPhoto)
    }
}
