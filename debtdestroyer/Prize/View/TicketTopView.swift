//
//  TicketTopView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 22/08/22.
//

import UIKit
import Reusable

class TicketTopView: UITableViewCell, Reusable {
    
    var earnedTicketView = UIView()
    var earnedTicketBackgroundImgView = UIImageView()
    var lblAmntPaidTo = UILabel()
    var lblAmntPaid = UILabel()
    var lblNoOfTickets = UILabel()
    var ticketProgressBar = UIProgressView()
    var lblAutomatically = UILabel()
    var ticketCount = String()
    let infoBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setEarnedTicketView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setEarnedTicketView() {
        
        self.contentView.addSubview(earnedTicketView)
        earnedTicketView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        setEarnedTicketBackgroundImgView()
        setAmountPaidToLbl()
        setInfoBtn()
        setAmountPaidLbl()
        setLblNoOfTickets()
        setProgressBar()
    }
    
    private func setProgressBar() {
        //        var arrPointsRange = [0, 10, 20, 30, 40, 50]
        //        var currenPoint = 18
        //        let totalPoints = 50
        ticketProgressBar.progressImage = UIImage.init(named: "backgroundGrad")
        let dimension: CGFloat = 30
        ticketProgressBar.layer.cornerRadius = dimension / 2
        ticketProgressBar.clipsToBounds = true
        ticketProgressBar.progress = 0.18
        ticketProgressBar.trackTintColor = .progrssBarBackgroundColor
        earnedTicketView.addSubview(ticketProgressBar)
        ticketProgressBar.snp.makeConstraints{ make in
            //            make.top.equalTo(lblNoOfTickets.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func setStackForProgress() {
        
    }
    
    private func setEarnedTicketBackgroundImgView() {
        earnedTicketBackgroundImgView.image = UIImage.init(named: "ticketB")
        earnedTicketView.addSubview(earnedTicketBackgroundImgView)
        earnedTicketBackgroundImgView.snp.makeConstraints{ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setAmountPaidToLbl() {
        lblAmntPaidTo.text = "Amount Paid To Your Student Loans This Week"
        lblAmntPaidTo.textColor = .white
        lblAmntPaidTo.numberOfLines = 1
        lblAmntPaidTo.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        earnedTicketView.addSubview(lblAmntPaidTo)
        lblAmntPaidTo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    private func setInfoBtn() {
        infoBtn.setBackgroundImage(UIImage.init(named: "Info"), for: .normal)
        infoBtn.addTarget(self,
                          action: #selector(infoBtnClicked),
                          for: .touchUpInside)
        earnedTicketView.addSubview(infoBtn)
        infoBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(lblAmntPaidTo.snp.centerY)
            make.leading.equalTo(lblAmntPaidTo.snp.trailing).offset(5)
            make.height.width.equalTo(15)
        }
    }
    
    @objc private func infoBtnClicked() {
        print("infoBtnClicked")
    }
    
    private func setAmountPaidLbl() {
        lblAmntPaid.text = "$" + "20.22"
        lblAmntPaid.textColor = .white
        lblAmntPaid.numberOfLines = 0
        lblAmntPaid.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        let dimension: CGFloat = 30
        earnedTicketView.addSubview(lblAmntPaid)
        lblAmntPaid.snp.makeConstraints{ make in
            make.top.equalTo(lblAmntPaidTo.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
        }
    }
    
    func setLblNoOfTickets() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "tickets-alt")
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: " " + ticketCount + " Tickets ")
        lblString.append(attachmentString)
        let space = NSMutableAttributedString(string: " ")
        lblString.append(space)
        lblNoOfTickets.attributedText = lblString
        lblNoOfTickets.textColor = .black
        lblNoOfTickets.backgroundColor = .sunGlow
        let dimension: CGFloat = 30
        lblNoOfTickets.layer.cornerRadius = dimension / 2
        lblNoOfTickets.layer.masksToBounds = true
        lblNoOfTickets.numberOfLines = 0
        lblNoOfTickets.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        earnedTicketView.addSubview(lblNoOfTickets)
        lblNoOfTickets.snp.makeConstraints{ make in
            make.top.equalTo(lblAmntPaidTo.snp.bottom).offset(10)
            make.leading.equalTo(lblAmntPaid.snp.trailing).offset(10)
            make.height.equalTo(dimension)
        }
    }
    
    private func setAutomaticallyEnteredLbl() {
        lblAutomatically.text = "your tickets are automatically entered into the weekly prize pool"
        lblAutomatically.textColor = .white
        lblAutomatically.numberOfLines = 0
        lblAutomatically.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        earnedTicketView.addSubview(lblAutomatically)
        lblAutomatically.snp.makeConstraints{ make in
            make.top.equalTo(ticketProgressBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-20)
            
        }
    }
}
