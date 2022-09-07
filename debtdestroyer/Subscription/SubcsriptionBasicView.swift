//
//  SubcsriptionCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/08/22.
//

import UIKit

class SubcsriptionBasicView: UIView {
    let background = UIView()
    let topBtn = UIButton()
    let ticketsLbl = UILabel()
    let emailNewsLetterLbl = UILabel()
    let loanConnectionsLbl = UILabel()
    let priceLbl = UILabel()
    let ticketsInfo = UIButton()
    let emailNewsLetterInfo = UIButton()
    let loanConnectionsInfo = UIButton()
    let priceInfo = UIButton()
    
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let stackView1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let stackView2 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let stackView3 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
       setBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackground() {    
        addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        setTopBtn()
        setStack()
        setStack1()
        setStack2()
        setStack3()
    }

    func setStack(){
        stackView.backgroundColor = .clear
        background.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(topBtn.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        setTicketsLbl()
        setTicketsBtn()
    }
    
    func setStack1(){
        stackView1.backgroundColor = .clear
        background.addSubview(stackView1)
        stackView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(ticketsLbl.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        setEmailNewsLetterLbl()
        setEmailNewsLetterBtn()
    }
    
    func setStack2(){
        stackView2.backgroundColor = .clear
        background.addSubview(stackView2)
        stackView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(emailNewsLetterLbl.snp.bottom).offset(20)
            make.height.equalTo(70)
        }
        setLoanConnectionsLbl()
        setLoanConnectionsBtn()
    }
    
    func setStack3(){
        stackView3.backgroundColor = .clear
        background.addSubview(stackView3)
        stackView3.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(loanConnectionsLbl.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        setPriceLbl()
        setPriceBtn()
    }
    
    func setPriceLbl() {
        priceLbl.text = "Price"
        priceLbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        priceLbl.textColor = .jaguarBlack
        priceLbl.numberOfLines = 0
        priceLbl.textAlignment = .left
        priceLbl.backgroundColor = .clear
        stackView3.addArrangedSubview(priceLbl)
        priceLbl.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setPriceBtn() {
        priceInfo.setBackgroundImage(UIImage.init(named: "InfoBlack"), for: .normal)
        stackView3.addArrangedSubview(priceInfo)
        priceInfo.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(15)
        }
    }
    
    func setLoanConnectionsLbl() {
        loanConnectionsLbl.text = "Loan Account Connections"
        loanConnectionsLbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        loanConnectionsLbl.adjustsFontSizeToFitWidth = true
        loanConnectionsLbl.textColor = .jaguarBlack
        loanConnectionsLbl.numberOfLines = 0
        loanConnectionsLbl.textAlignment = .left
        loanConnectionsLbl.backgroundColor = .clear
        stackView2.addArrangedSubview(loanConnectionsLbl)
        loanConnectionsLbl.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setLoanConnectionsBtn() {
        loanConnectionsInfo.setBackgroundImage(UIImage.init(named: "InfoBlack"), for: .normal)
        stackView2.addArrangedSubview(loanConnectionsInfo)
        loanConnectionsInfo.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(15)
        }
    }
    
    func setEmailNewsLetterLbl() {
        emailNewsLetterLbl.text = "Email Newsletter"
        emailNewsLetterLbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        emailNewsLetterLbl.textColor = .jaguarBlack
        emailNewsLetterLbl.numberOfLines = 0
        emailNewsLetterLbl.textAlignment = .left
        emailNewsLetterLbl.backgroundColor = .clear
        stackView1.addArrangedSubview(emailNewsLetterLbl)
        emailNewsLetterLbl.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setEmailNewsLetterBtn() {
        emailNewsLetterInfo.setBackgroundImage(UIImage.init(named: "InfoBlack"), for: .normal)
        stackView1.addArrangedSubview(emailNewsLetterInfo)
        emailNewsLetterInfo.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(15)
        }
    }

    
    func setTopBtn() {
        topBtn.backgroundColor = .clear
        topBtn.isUserInteractionEnabled = false
        background.addSubview(topBtn)
        topBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(15)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }
    
    func setTicketsLbl() {
        ticketsLbl.text = "Tickets"
        ticketsLbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        ticketsLbl.textColor = .jaguarBlack
        ticketsLbl.numberOfLines = 0
        ticketsLbl.textAlignment = .left
        ticketsLbl.backgroundColor = .clear
        stackView.addArrangedSubview(ticketsLbl)
        ticketsLbl.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    func setTicketsBtn() {
        ticketsInfo.setBackgroundImage(UIImage.init(named: "InfoBlack"), for: .normal)
        stackView.addArrangedSubview(ticketsInfo)
        ticketsInfo.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(15)
        }
    }

}
