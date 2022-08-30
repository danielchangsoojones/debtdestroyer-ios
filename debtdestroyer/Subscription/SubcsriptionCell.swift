//
//  SubcsriptionCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/08/22.
//

import UIKit
import Reusable

class SubcsriptionCell: UICollectionViewCell, Reusable{
    let background = UIView()
    let topBtn = UIButton()
    let ticketsLbl = UILabel()
    let emailNewsLetterLbl = UILabel()
    let LoanConnectionsLbl = UILabel()
    let priceLbl = UILabel()
    let ticketsInfo = UIButton()
    let emailNewsLetterInfo = UIButton()
    let LoanConnectionsInfo = UIButton()
    let priceInfo = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
       setBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackground() {
        background.backgroundColor = .systemGray5
        background.layer.cornerRadius = 8
    
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
        setTopBtn()
        setTicketsLbl()
        setTicketsBtn()

    }
    
    func setTopBtn() {
        topBtn.backgroundColor = .blue
        topBtn.isUserInteractionEnabled = false
        background.addSubview(topBtn)
        topBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(50)
            make.height.width.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    
    func setTicketsLbl() {
        ticketsLbl.text = "Tickets"
        ticketsLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        ticketsLbl.textColor = .jaguarBlack
        ticketsLbl.numberOfLines = 0
        ticketsLbl.textAlignment = .left
        ticketsLbl.backgroundColor = .clear
        background.addSubview(ticketsLbl)
        ticketsLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(topBtn.snp.bottom).offset(15)
        }
    }

    func setTicketsBtn() {
        ticketsInfo.setBackgroundImage(UIImage.init(named: "InfoBlack"), for: .normal)
//        ticketsInfo.addTarget(SubscriptionViewController(),
//                          action: #selector(ticktsInfoBtnClicked),
//                          for: .touchUpInside)
        background.addSubview(ticketsInfo)
        ticketsInfo.snp.makeConstraints{ make in
            make.top.equalTo(ticketsLbl.snp.top)
            make.leading.equalTo(ticketsLbl.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }

}
