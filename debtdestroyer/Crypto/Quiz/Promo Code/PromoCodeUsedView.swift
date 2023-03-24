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
    let tableView = UITableView()
    let faqBtn = UIButton()
    var theSpinnerContainer: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setPromoInfoLabel()
        setFaqButton()
        setTableView()
        setLoadingSpinner()
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
    
    private func setFaqButton() {
        //TODO: What do we want the FAQ to do? Link to a Notion page? 
//        faqBtn.setTitle("See FAQ", for: .normal)
        faqBtn.setTitleColor(UIColor(red: 99/255, green: 180/255, blue: 239/255, alpha: 1), for: .normal)
        addSubview(faqBtn)
        faqBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(promoInfoLabel.snp.bottom).offset(5)
        }
    }
    
    private func setTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(faqBtn.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setLoadingSpinner() {
        theSpinnerContainer = Helpers.showActivityIndicatory(in: tableView)
        theSpinnerContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
