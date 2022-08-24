//
//  TransactionHistoryCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/08/22.
//

import UIKit
import Reusable

class TransactionHistoryCell: UITableViewCell, Reusable {
    
    var ticketCount = String()
    let titleLabel = UILabel()
    let balanceLabel = UILabel()
    let dateLabel = UILabel()
    let ticketsLabel = UILabel()
    private let background = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
        setBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setBackground() {
        background.backgroundColor = .white
        background.layer.cornerRadius = 8
        // add shadow on cell
        background.layer.masksToBounds = false
        background.layer.shadowOpacity = 0.23
        background.layer.shadowRadius = 4
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowColor = UIColor.black.cgColor
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
            make.top.equalTo(contentView.snp.top).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        setTitleLabel()
        setBalanceLabel()
        setDateLabel()
        setTitleLabel()
    }

    private func setTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .jaguarBlack
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    private func setBalanceLabel() {
        balanceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        balanceLabel.textColor = .jaguarBlack
        balanceLabel.textAlignment = .right
        background.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(15)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.equalTo(80)
        }
    }

    private func setDateLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dateLabel.textColor = .jaguarBlack
        background.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setTicketsLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "tickets-alt")
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: " " + ticketCount + " Tickets ")
        lblString.append(attachmentString)
        let space = NSMutableAttributedString(string: " ")
        lblString.append(space)
        ticketsLabel.attributedText = lblString
        ticketsLabel.textColor = .black
        ticketsLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        ticketsLabel.textAlignment = .right
        background.addSubview(ticketsLabel)
        ticketsLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top)
            make.trailing.equalToSuperview().inset(15)
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.width.equalTo(120)
        }
    }

    
    
}
