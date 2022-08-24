//
//  BankViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 04/08/22.
//

import UIKit

class BankViewController: UIViewController {
    
    private var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(cellType: BankView.self)
        tableView.register(cellType: TicketTopView.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
}

extension BankViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TicketTopView.self)
            cell.lblAmntPaidTo.text = UserDefaults.standard.string(forKey: "progress_meter_title")
            cell.lblAmntPaid.text = "$" + (UserDefaults.standard.string(forKey: "totalAmountPaidToLoan") ?? "")
            cell.ticketCount = UserDefaults.standard.string(forKey: "ticketCount") ?? ""
            cell.setLblNoOfTickets()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BankView.self)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

