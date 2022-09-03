//
//  HowToEarnTicketsCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable

class HowToEarnTicketsCell: UITableViewCell, Reusable {
    
    var howToEarnTicketView = UIView()
    var lblHeader = UILabel()
    var lblRoundUps = UILabel()
    var lblOneTimePayment = UILabel()
    private let line = UIView()
    var earnTicketTable = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHowToEarnTicketView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHowToEarnTicketView() {
        howToEarnTicketView.layer.borderColor = UIColor.systemGray3.cgColor
        howToEarnTicketView.layer.borderWidth = 2
        howToEarnTicketView.layer.cornerRadius = 8
        self.contentView.addSubview(howToEarnTicketView)
        howToEarnTicketView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(180)
            make.bottom.equalToSuperview().offset(-120)
        }
        setEarnTicketTableView()
    }
  
    private func setEarnTicketTableView() {
        earnTicketTable = UITableView()
        earnTicketTable.delegate = self
        earnTicketTable.dataSource = self
        earnTicketTable.backgroundColor = .white
        earnTicketTable.separatorStyle = .none
        earnTicketTable.allowsSelection = true
        earnTicketTable.register(cellType: EarnTicketCell.self)
        howToEarnTicketView.addSubview(earnTicketTable)
        earnTicketTable.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

}

extension HowToEarnTicketsCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EarnTicketCell.self)
        if indexPath.row == 0{
            cell.setBackground(check: true)
            cell.setTitleLabel()
            cell.titleLabel.text = "How to earn tickets?"
            cell.titleLabel.textColor = .white
            cell.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            cell.setInfoBtn()
        } else if indexPath.row == 1 {
            cell.setLine()
            cell.setSetUpBtn()
            cell.setTitleLabel()
            cell.titleLabel.text = "Round Ups (2x Tickets)"
        } else if indexPath.row == 2 {
            cell.setSetUpBtn()
            cell.setTitleLabel()
            cell.titleLabel.text = "One Time Payment"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Do Nothing. Header Cell
        } else if indexPath.row == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RoundUps"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "OneTimePayment"), object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
