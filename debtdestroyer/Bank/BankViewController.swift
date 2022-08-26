//
//  BankViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 04/08/22.
//

import UIKit
import SwiftyJSON

class BankViewController: UIViewController {
    
    private var tableView: UITableView!
    private let dataStore = BankDataStore()
    private var messageHelper: MessageHelper?
    private var transactionHistory: [TransactionParse] = []
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        loadTransactions()
    }
    
    private func setTableView() {
        tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.register(cellType: TicketTopView.self)
        tableView.register(cellType: LoanAccountCell.self)
        tableView.register(cellType: PowerUpsCell.self)
        tableView.register(cellType: TransactionHistoryCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func loadTransactions() {
        dataStore.loadTransactionHistory { transactionHistory in
            self.transactionHistory = transactionHistory
            self.tableView.reloadData()
        }
    }
    
}

extension BankViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // MARK: Ticket Top View Section
            return 1
        } else if section == 1 {
            // MARK: Connected Accounts Section
            return 1
        } else if section == 1 {
            // MARK: Power ups Section
            return 1
        } else {
            // MARK: transaction History Section
            return self.transactionHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {
            // MARK: Ticket Top View Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TicketTopView.self)
            cell.lblAmntPaidTo.text = UserDefaults.standard.string(forKey: "progress_meter_title")
            cell.lblAmntPaid.text = "$" + (UserDefaults.standard.string(forKey: "totalAmountPaidToLoan") ?? "")
            cell.ticketCount = UserDefaults.standard.string(forKey: "ticketCount") ?? ""
            cell.setLblNoOfTickets()
            return cell
        } else if indexPath.section == 1 {
            // MARK: Connected Accounts Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LoanAccountCell.self)
            
            cell.titleLabel.text = "Connect Your Student Loan Account"
            cell.balanceLabel.textColor = hexStringToUIColor(hex: "FF1A7E")
            cell.balanceLabel.text = "to start earning tickets everytime you pay down your student loans"
            return cell
            
        }else if indexPath.section == 2 {
            // MARK: Power ups Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PowerUpsCell.self)
            
            cell.titleLabel.text = "Connect Your Student Loan Account"
            cell.balanceLabel.textColor = hexStringToUIColor(hex: "FF1A7E")
            cell.balanceLabel.text = "to start earning tickets everytime you pay down your student loans"
            return cell
            
        } else {
            // MARK: transaction History Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionHistoryCell.self)
            print("self.transactionHistory",self.transactionHistory)
            let transaction = transactionHistory[indexPath.row]

            cell.titleLabel.text = transaction.value(forKey: "title") as? CVarArg as? String ?? "Loan Payment"
 
            let amount =  transaction.value(forKey: "amountPaidToLoan") as? CVarArg ?? " "
            cell.amountPaidToLoanLabel.text = amount as? String
//            print("transaction.updatedAt",transaction.value(forKey: "title") as? String )
            cell.dateLabel.text = "12/05/2021"
            cell.ticketCount = transaction.value(forKey: "ticketsEarned") as? CVarArg as? String ?? "0"
            cell.setTicketsLabel()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt ",indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // MARK: Ticket Top View Section
            return nil
        } else if section == 1 {
            // MARK: Connected Accounts Section
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = .white
            let headerLbl = UILabel()
            
            headerLbl.text = "Connected Accounts"
            headerLbl.numberOfLines = 0
            headerLbl.textColor = .black
            headerLbl.textAlignment = .left
            headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(15)
            }
            return headerView
        } else if section == 2 {
            // MARK: Power ups Section
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = .white
            let headerLbl = UILabel()
            
            headerLbl.text = "Power ups"
            headerLbl.numberOfLines = 0
            headerLbl.textColor = .black
            headerLbl.textAlignment = .left
            headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(15)
            }
            return headerView
        } else {
            // MARK: transaction History Section
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = .white
            let headerLbl = UILabel()
            
            headerLbl.text = "Transaction History"
            headerLbl.numberOfLines = 0
            headerLbl.textColor = .black
            headerLbl.textAlignment = .left
            headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(15)
            }
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            return 40
        }
    }
}

