//
//  WinnerTableCell.swift
//  nbawidget
//
//  Created by Daniel Jones on 7/1/22.
//

import UIKit
import Reusable

class WinnerTableCell: UITableViewCell, Reusable {
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let imgView = UIImageView()
    private var stackViewForlbls: UIStackView!
    private var stackView: UIStackView!
    let giftAmountBtn = SpinningWithGradButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setUpStackView()
        setNameAndDateLabel()
        setPhoto()
        setGiftAmountBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        stackView = UIStackView()
        stackView.spacing = 35
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setNameAndDateLabel() {
        
        stackViewForlbls = UIStackView()
        stackViewForlbls.spacing = 9
        stackViewForlbls.axis = .horizontal
        stackViewForlbls.distribution = .fillEqually
        stackViewForlbls.alignment = .center
        stackView.addArrangedSubview(stackViewForlbls)
        stackViewForlbls.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        setNameLabel()
        setDateLabel()
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont.MontserratSemiBold(size: 20)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        stackViewForlbls.addArrangedSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setDateLabel() {
        dateLabel.text = "Jan 14th"
        dateLabel.font = UIFont.MontserratRegular(size: 18)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .right
        stackViewForlbls.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
        }
    }
    
    private func setPhoto() {
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .clear
        stackView.addArrangedSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.height.equalTo(imgView.snp.width).multipliedBy(0.7).priority(.high)
            make.bottom.equalToSuperview().inset(-20)
        }
    }
    
    private func setGiftAmountBtn(){
        giftAmountBtn.setTitleColor(.white, for: .normal)
        giftAmountBtn.setTitle("$25", for: .normal)
        
        let dimenssion = 60
        giftAmountBtn.layer.cornerRadius = CGFloat(dimenssion / 2)
        giftAmountBtn.clipsToBounds = true
        addSubview(giftAmountBtn)
        giftAmountBtn.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.bottom).offset(-40)
            make.trailing.equalToSuperview().inset(25)
            make.height.width.equalTo(dimenssion)
        }
    }
}
