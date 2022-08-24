//
//  BankView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 19/08/22.
//

import UIKit
import Reusable

class BankView: UITableViewCell, Reusable {
    
    var connectedAccountsTable = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EarnTicketCell.self)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.backgroundColor = .systemGray6
            } else {
                cell.backgroundColor = .systemGray4
            }
            
            
        } else {
            if indexPath.row == 0 {
                cell.backgroundColor = .systemGray2
            } else {
                cell.backgroundColor = .systemGray6
            }
            
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
            footer.backgroundColor = .white
            let connectLoanAccountBtn = UIButton(frame: CGRect(x:15,y: 10 ,width:footer.frame.width - 30,height:70))
            connectLoanAccountBtn.backgroundColor = .white
            
            connectLoanAccountBtn.layer.cornerRadius =  8
            connectLoanAccountBtn.titleLabel?.numberOfLines = 0
            connectLoanAccountBtn.layer.masksToBounds = false
            connectLoanAccountBtn.layer.shadowColor = UIColor.black.cgColor
            connectLoanAccountBtn.layer.shadowOpacity = 0.23
            connectLoanAccountBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
            connectLoanAccountBtn.layer.shadowRadius = 5
            connectLoanAccountBtn.layer.shouldRasterize = true
            connectLoanAccountBtn.layer.rasterizationScale = UIScreen.main.scale
            
            connectLoanAccountBtn.addDashBorder()
            connectLoanAccountBtn.setTitle("+ Connect Another Student Loan Account", for: .normal)
            connectLoanAccountBtn.setTitleColor(.black, for: .normal)
            connectLoanAccountBtn.addTarget(self, action: #selector(connectLoanAccountBtnPressed), for: .touchUpInside)
            footer.addSubview(connectLoanAccountBtn)
            return footer
            
        } else {
            let footer = UIView.init(frame: .zero)
            return footer
        }
    }
    
    @objc private func connectLoanAccountBtnPressed() {
        print("connectLoanAccountBtnPressed")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 90
    }
}
