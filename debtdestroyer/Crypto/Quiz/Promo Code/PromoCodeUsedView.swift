//
//  PromoCodeView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeUsedView: UIView {
    let titleLbl = UILabel()
    let promoInfoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setPromoInfoLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLbl.numberOfLines = 1
        titleLbl.textAlignment = .center
        titleLbl.textColor = .black
        titleLbl.font = UIFont.MontserratSemiBold(size: 25)
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().offset(10)
        }
    }
    
    private func setPromoInfoLabel() {
        promoInfoLabel.numberOfLines = 0
        promoInfoLabel.textAlignment = .center
        promoInfoLabel.textColor = .black
        promoInfoLabel.font = UIFont.MontserratLight(size: 14)
        addSubview(promoInfoLabel)
        promoInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}