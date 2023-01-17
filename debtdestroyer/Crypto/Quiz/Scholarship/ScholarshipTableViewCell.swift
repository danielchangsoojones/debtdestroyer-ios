//
//  ScholarshipTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/12/22.
//

import UIKit
import Reusable

class ScholarshipTableViewCell: UITableViewCell, Reusable {
    
    let amountLabel = UILabel()
    let titleLabel = UILabel()
    let dueDateLabel = UILabel()
    var chevronImageView = UIImageView()
    private let containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
        setAmountLblForScholership()
        setChevron(imageName: "arrow")
        setTitleLabel()
        setDueDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
   
    
    private func setAmountLblForScholership() {
        let dimension: CGFloat = 60

        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(dimension)
        }
        amountLabel.numberOfLines = 1
        amountLabel.textColor = .white
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.MontserratMedium(size: 12)
        amountLabel.adjustsFontSizeToFitWidth = true
        containerView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(10)
//            make.height.width.equalTo(dimension)
            make.edges.equalToSuperview()
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratMedium(size: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(containerView.snp.trailing).offset(10)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
        }
    }
    
    private func setDueDateLabel() {
        dueDateLabel.font = UIFont.MontserratRegular(size: 15)
        dueDateLabel.textColor = .gray
        dueDateLabel.numberOfLines = 0
        addSubview(dueDateLabel)
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.trailing).offset(10)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func setChevron(imageName: String) {
        chevronImageView = UIImageView(image: UIImage(named: imageName))
        chevronImageView.contentMode = .scaleAspectFit
        addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        
        containerView.setGradientBackground(color1: hexStringToUIColor(hex: "FF2474"), color2: hexStringToUIColor(hex: "FF7910"),radi: 8)
    }
}
