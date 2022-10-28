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
        let description: String//NSMutableAttributedString
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
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratSemiBold(size: 28)
        titleLabel.text = "How To Earn Tickets"
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setTicketsStackView() {
        ticketsStackView.axis = .vertical
        ticketsStackView.distribution = .fill
        ticketsStackView.alignment = .leading
        ticketsStackView.spacing = 5
        contentView.addSubview(ticketsStackView)
        ticketsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        let studentLoanTicket = TicketsInfo(description: "For every $1 paid towards your student loans. Just pay your student loans like normal, and you earn tickets!",
                                            ticketCount: 1)
        let dailyTriviaTicket = TicketsInfo(description: "For every question you get correct in our daily trivia. Play now.",
                                            ticketCount: 1)
        
//        let studentLoanTicket = TicketsInfo(description: NSMutableAttributedString(string: "For every $1 paid towards your student loans. Just pay your student loans like normal, and you earn tickets!"), ticketCount: 1)
//
//
//
//        let attributedString = NSMutableAttributedString(string: "For every question you get correct in our daily trivia. Play now ➔")
//        let text = "For every question you get correct in our daily trivia. Play now ➔"
//        let str = NSString(string: text)
//        let theRangeTerm = str.range(of: "Play now ➔")
//
//        attributedString.addAttribute(.underlineStyle, value: 1, range: theRangeTerm)
//        attributedString.addAttribute(.foregroundColor, value: UIColor.gradPink, range: theRangeTerm)
//        let dailyTriviaTicket = TicketsInfo(description: attributedString, ticketCount: 1)
        

        let studentCell = createTicketsCountCell(ticketsInfo: studentLoanTicket)
        ticketsStackView.addArrangedSubview(studentCell)
        
        lineView()
        
        let dailyTriviaCell = createTicketsCountCell(ticketsInfo: dailyTriviaTicket)
        ticketsStackView.addArrangedSubview(dailyTriviaCell)
        
    }
    
    private func lineView() {
        let line = UILabel()
        line.backgroundColor =  UIColor.black.withAlphaComponent(0.2)
        ticketsStackView.addArrangedSubview(line)

        line.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.trailing.equalToSuperview()
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
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        descriptionLabel.text = ticketsInfo.description
   //     descriptionLabel.attributedText = ticketsInfo.description
        descriptionLabel.font = UIFont.MontserratRegular(size: 14)
        descriptionLabel.numberOfLines = 0
//        descriptionLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        elementView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ticketCountsView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(40)
        }
        return elementView
    }
//
//    @objc func tapLabel(gesture: UITapGestureRecognizer) {
//        let text = "For every question you get correct in our daily trivia. Play now ➔"
//        let str = NSString(string: text)
//        let theRangeTerm = str.range(of: "Play now ➔")
//
//                if gesture.didTapAttributedTextInLabel(label: descriptionLabel, inRange: theRangeTerm) {
////                    self.tabBarController?.selectedIndex = 1
////                    self.navigationController?.popToRootViewController(animated: true)
//
//                }else {
//                    print("Tapped none")
//                }
//    }

}
