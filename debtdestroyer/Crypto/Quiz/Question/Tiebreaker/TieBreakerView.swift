//
//  TieBreakerView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/17/23.
//

import Foundation
import UIKit

class TieBreakerView: UIView {
    private let titleLbl = UILabel()
    let descriptionLbl = UILabel()

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
        titleLbl.text = "Tiebreaker Round"
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().offset(10)
        }
    }
    
    private func setPromoInfoLabel() {
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .center
        descriptionLbl.textColor = .black
        descriptionLbl.font = UIFont.MontserratLight(size: 14)
        addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
//    private func setTableView() {
//        addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(faqBtn.snp.bottom).offset(10)
//        }
//    }
}
