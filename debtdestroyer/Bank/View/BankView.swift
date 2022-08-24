//
//  BankView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 19/08/22.
//

import UIKit
import Reusable

class BankView: UITableViewCell, Reusable {
    
    private let dataStore = BankDataStore()
    var connectedAccountsTable = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(dataStore.transactionHistoryJSON)
        self.contentView.backgroundColor = .white
        setConnectedAccountsTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConnectedAccountsTableView() {
        connectedAccountsTable = UITableView()
        connectedAccountsTable.delegate = self
        connectedAccountsTable.dataSource = self
        connectedAccountsTable.backgroundColor = .systemPink
        connectedAccountsTable.separatorStyle = .none
        connectedAccountsTable.allowsSelection = true
        connectedAccountsTable.register(cellType: EarnTicketCell.self)
        self.contentView.addSubview(connectedAccountsTable)
        connectedAccountsTable.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(500)
        }
    }
}

extension BankView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LoanAccountCell.self)
            if dataStore.transactionHistoryJSON.count == 0{
              
                
                cell.chevronImageView.image = UIImage.init(named: "")
                cell.titleLabel.text = "Connect Your Student Loan Account"
                cell.balanceLabel.textColor = hexStringToUIColor(hex: "FF1A7E")
                cell.balanceLabel.text = "to start earning tickets everytime you pay down your student loans"

            } else {
                cell.balanceLabel.textColor = .black


            }
            
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionHistoryCell.self)
            cell.titleLabel.text = "Loan Payment"
            cell.balanceLabel.text = "$386.60"
            cell.dateLabel.text = "12/05/2021"
            cell.ticketCount = "20"
            cell.setTicketsLabel()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt ",indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            headerView.backgroundColor = .blue
            let headerLbl = UILabel()
            headerLbl.backgroundColor = .red
            
            headerLbl.text = "Connected Accounts"
            headerLbl.numberOfLines = 0
            headerLbl.textColor = .black
            headerLbl.textAlignment = .left
            headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(15)
            }
            return headerView
        } else {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            headerView.backgroundColor = .blue
            let headerLbl = UILabel()
            headerLbl.backgroundColor = .red
            
            headerLbl.text = "Transaction History"
            headerLbl.numberOfLines = 0
            headerLbl.textColor = .black
            headerLbl.textAlignment = .left
            headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(15)
            }
            return headerView
        }
        
    }
    
    @objc private func connectLoanAccountBtnPressed() {
        print("connectLoanAccountBtnPressed")
    }

}
