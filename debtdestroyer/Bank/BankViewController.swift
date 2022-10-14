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
    private var debtAccountsData: [DebtAccountsParse] = []
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTransactions()
        loadDebtAccounts()
        
    }
    
    private func setTableView() {
        tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
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
    
    private func loadDebtAccounts() {
        dataStore.loadDebtAccounts { debtAccounts in
            self.debtAccountsData = debtAccounts
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
            if self.debtAccountsData.count > 0 {
                return self.debtAccountsData.count
            } else {
                return 1
            }
        } else if section == 2 {
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
            let progressValue = (Int(cell.ticketCount) ?? 0)
            cell.ticketProgressBar.progress = Float(progressValue)/50
            
            if progressValue >= 40 {
                cell.stepImgView10.image = UIImage.init(named: "stepC")
                cell.stepImgView20.image = UIImage.init(named: "stepC")
                cell.stepImgView30.image = UIImage.init(named: "stepC")
                cell.stepImgView40.image = UIImage.init(named: "stepC")
                
                cell.Label10.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label20.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label30.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label40.textColor = hexStringToUIColor(hex: "FF385E")
            } else if progressValue >= 30 {
                cell.stepImgView10.image = UIImage.init(named: "stepC")
                cell.stepImgView20.image = UIImage.init(named: "stepC")
                cell.stepImgView30.image = UIImage.init(named: "stepC")
                
                cell.Label10.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label20.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label30.textColor = hexStringToUIColor(hex: "FF385E")
            } else if progressValue >= 20 {
                cell.stepImgView10.image = UIImage.init(named: "stepC")
                cell.stepImgView20.image = UIImage.init(named: "stepC")
                
                cell.Label10.textColor = hexStringToUIColor(hex: "FF385E")
                cell.Label20.textColor = hexStringToUIColor(hex: "FF385E")
            } else if progressValue >= 10 {
                cell.stepImgView10.image = UIImage.init(named: "stepC")
                
                cell.Label10.textColor = hexStringToUIColor(hex: "FF385E")
            }
            return cell
        } else if indexPath.section == 1 {
            // MARK: Connected Accounts Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LoanAccountCell.self)
            
            if self.debtAccountsData.count > 0 {
                let debtAccount = debtAccountsData[indexPath.row]
                cell.balanceLabel.textColor = .black
                
                if let title = debtAccount.value(forKey: "title")
                {
                    cell.titleLabel.text = title as? String
                }else {
                    cell.titleLabel.text = "Loan Account"
                }
                
                if let remaining_balance = debtAccount.value(forKey: "remaining_balance")
                {
                    cell.balanceLabel.text = "Balance: $" + String(describing: remaining_balance)
                }
                
                cell.logoImg.loadFromFile(debtAccount.logoImg)
               // cell.setChevron(imageName: "chevronGrey")
                
            }
            
            else {
                cell.logoImg.image = UIImage.init(named: "Plus")
                cell.titleLabel.text = "Connect Your Student Loan Account"
                cell.balanceLabel.textColor = hexStringToUIColor(hex: "FF1A7E")
                cell.balanceLabel.text = "to start earning tickets everytime you pay down your student loans"
            }
            return cell
            
        }else if indexPath.section == 2 {
            // MARK: Power ups Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PowerUpsCell.self)
            
            cell.titleLabel.text = "Earn 10x tickets and more..."
            cell.balanceLabel.textColor = hexStringToUIColor(hex: "FF1A7E")
            cell.balanceLabel.text = "When you upgrade to the Diamond subscription"
            return cell
            
        } else {
            // MARK: transaction History Section
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionHistoryCell.self)
            let transaction = transactionHistory[indexPath.row]
            
            if let title = transaction.title
            {
                if title == ""{
                    cell.titleLabel.text = "Loan Payment"
                } else {
                    cell.titleLabel.text = title
                }
            }
            
            if let amount = transaction.value(forKey: "amountPaidToLoan")
            {
                cell.amountPaidToLoanLabel.text = "$" + String(describing: amount)
            }
            
            if let ticketCount = transaction.value(forKey: "ticketsEarned")
            {
                cell.ticketCount = String(describing: ticketCount)
                cell.setTicketsLabel()
            }
            
            if let updatedAt = transaction.value(forKey: "updatedAt")
            {
                let from = dateTimeStatus(date: String(describing: updatedAt))
                //                let dateFormatter = DateFormatter()
                //                dateFormatter.dateFormat = "2022-08-23 06:11:13 +0000"
                //                let date = dateFormatter.date(from: String(describing: from))
                //                dateFormatter.dateFormat = "yyyy-MM-dd"
                //                let resultString = dateFormatter.string(from: date ?? Date())
                
                cell.dateLabel.text = String(describing: from)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt ",indexPath.row)
        if indexPath.section == 0 {
            // MARK: Ticket Top View Section
            
        } else if indexPath.section == 1 {
            // MARK: Connected Accounts Section
            
        }else if indexPath.section == 2 {
            // MARK: Power ups Section
            let vc = SubscriptionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            // MARK: transaction History Section
            
        }
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
            headerLbl.font = UIFont.MontserratMedium(size: 20)
            headerView.addSubview(headerLbl)
            headerLbl.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview().inset(15)
            }
            
            if self.debtAccountsData.count > 0 {
                let editBtn = UIButton()
                editBtn.setTitle("edit", for: .normal)
                let dimenssion = 25
                editBtn.layer.cornerRadius = CGFloat(dimenssion / 2)
                editBtn.layer.borderWidth = 1
                editBtn.layer.borderColor = UIColor.black.cgColor
                editBtn.setTitleColor(.black, for: .normal)
                editBtn.titleLabel?.font = UIFont.MontserratMedium(size: 15)
                editBtn.addTarget(self,
                                  action: #selector(editConnectedAccountsBtnClicked),
                                  for: .touchUpInside)
                headerView.addSubview(editBtn)
                editBtn.snp.makeConstraints{ make in
                    make.centerY.equalToSuperview()
                    make.leading.equalTo(headerLbl.snp.trailing).offset(10)
                    make.width.equalTo(dimenssion * 2)
                    make.height.equalTo(dimenssion)
                }
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
            headerLbl.font = UIFont.MontserratMedium(size: 20)
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
            headerLbl.font = UIFont.MontserratMedium(size: 20)
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
    
    @objc private func editConnectedAccountsBtnClicked() {
        let vc = ConnectedAccountsViewController(debtAccounts: debtAccountsData)
        self.navigationController?.pushViewController(vc.self, animated: true)
    }
    
}

