//
//  HowToEarnTicketsCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable

class HowToEarnTicketsCell: UITableViewCell, Reusable {
    struct TicketsInfo {
        let description: String
        let ticketCount: Int
    }
    
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let ticketsStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContainerView()
        setTitleLabel()
        setTicketsStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerView() {
        containerView.layer.cornerRadius = 15
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        containerView.layer.borderWidth = 0.5
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(WeekPrizeCell.Constants.horizontalContainerInset)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratSemiBold(size: 32)
        titleLabel.text = "How To Earn Tickets"
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setTicketsStackView() {
        ticketsStackView.axis = .vertical
        ticketsStackView.distribution = .fill
        ticketsStackView.alignment = .leading
        ticketsStackView.spacing = 15
        contentView.addSubview(ticketsStackView)
        ticketsStackView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        let studentLoanTicket = TicketsInfo(description: "For every $1 paid towards your student loans. Just pay your student loans like normal, and you earn tickets!",
                                            ticketCount: 1)
        let dailyTriviaTicket = TicketsInfo(description: "For every question you get correct in our daily trivia. Play now.",
                                            ticketCount: 1)
        let ticketsInfos = [studentLoanTicket, dailyTriviaTicket]
        for ticketsInfo in ticketsInfos {
            let ticketCountsCell = createTicketsCountCell(ticketsInfo: ticketsInfo)
            ticketsStackView.addArrangedSubview(ticketCountsCell)
        }
    }
    
    private func createTicketsCountCell(ticketsInfo: TicketsInfo) -> UIView {
        let elementView = UIView()
        
        let ticketCountsView = TicketsCountView(ticketsCount: ticketsInfo.ticketCount)
        ticketCountsView.layer.cornerRadius = 10
        ticketCountsView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        ticketCountsView.layer.borderWidth = 0.5
        elementView.addSubview(ticketCountsView)
        ticketCountsView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        descriptionLabel.text = ticketsInfo.description
        descriptionLabel.font = UIFont.MontserratRegular(size: 14)
        descriptionLabel.numberOfLines = 0
        elementView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ticketCountsView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return elementView
    }
}
