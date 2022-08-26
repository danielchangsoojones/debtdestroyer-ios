//
//  PrizeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 05/08/22.
//

import UIKit
import AVFoundation

class PrizeViewController: UIViewController {

    private var tableView: UITableView!
    private let dataStore = PrizeDataStore()
    private var messageHelper: MessageHelper?
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        ForceUpdate.checkIfForceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataStore.savingsInfo()
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(cellType: TicketTopView.self)
        tableView.register(cellType: WeekPrizeCell.self)
        tableView.register(cellType: PastWeeksPrizeCell.self)
        tableView.register(cellType: HowToEarnTicketsCell.self)

        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension PrizeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TicketTopView.self)
            cell.lblAmntPaidTo.text = UserDefaults.standard.string(forKey: "progress_meter_title")
            cell.lblAmntPaid.text = "$" + (UserDefaults.standard.string(forKey: "totalAmountPaidToLoan") ?? "")
            cell.ticketCount = UserDefaults.standard.string(forKey: "ticketCount") ?? ""
            cell.setLblNoOfTickets()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeekPrizeCell.self)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PastWeeksPrizeCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HowToEarnTicketsCell.self)
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
