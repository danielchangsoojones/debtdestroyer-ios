//
//  PromoCodeView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeUsedView: UIView {

    var titleLbl = UILabel()
    var promoCodeUsedCountLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setPromoCodeUsedCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLbl.text = "Promo Code:"
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        titleLbl.textColor = .white
        titleLbl.font = UIFont.MontserratSemiBold(size: 25)
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setPromoCodeUsedCountLabel() {
        promoCodeUsedCountLbl.text = "0"
        promoCodeUsedCountLbl.numberOfLines = 0
        promoCodeUsedCountLbl.textAlignment = .center
        promoCodeUsedCountLbl.textColor = .white
        promoCodeUsedCountLbl.font = UIFont.MontserratBold(size: 35)
        addSubview(promoCodeUsedCountLbl)
        promoCodeUsedCountLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
