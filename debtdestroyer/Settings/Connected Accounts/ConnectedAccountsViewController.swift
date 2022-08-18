//
//  ConnectedAccountsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/08/22.
//

import UIKit

class ConnectedAccountsViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    var dataArr = [String]()
    var imgNameArr = [String]()
    var balanceArr = [String]()

    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNameArr = ["accounts", "contactUs","legal"]
        dataArr = ["Connected Accounts", "Contact Us", "Legal Disclosures"]
        balanceArr = ["36,245", "36,245", "36,245"]
    }
    
    
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(cellType: ConnectedAccountsTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
extension ConnectedAccountsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ConnectedAccountsTableViewCell.self)
        cell.titleLabel.text = dataArr[indexPath.row]
        cell.balanceLabel.text = "Balance: $" + balanceArr[indexPath.row]
        cell.logoImg.image = UIImage.init(named: imgNameArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footer.backgroundColor = UIColor.blue
        let connectLoanAccountBtn = UIButton(frame: CGRect(x:10,y: 10 ,width:footer.frame.width - 20,height:50))
        connectLoanAccountBtn.setTitle("+ Connect Another Student Loan Account", for: .normal)
        connectLoanAccountBtn.setTitleColor(.black, for: .normal)
        connectLoanAccountBtn.addTarget(self, action: #selector(connectLoanAccountBtnPressed), for: .touchUpInside)
        footer.addSubview(connectLoanAccountBtn)
        return footer
    }
    
    @objc private func connectLoanAccountBtnPressed() {
        print("connectLoanAccountBtnPressed")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 70
    }
}
