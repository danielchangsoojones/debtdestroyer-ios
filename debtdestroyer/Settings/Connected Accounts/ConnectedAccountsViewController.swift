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
    private var debtAccountsData: [ConnectAccountsDataStore.DebtAccount] = []
    private let dataStore = ConnectAccountsDataStore()
    private var timer: Timer?
    private let spinnerContainer = UIView()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Student Loan Accounts"
        tabBarController?.tabBar.isHidden = true
        setNavBarBtns()
        startTimer()
//        loadDebtAccounts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        tabBarController?.tabBar.isHidden = false
    }
    
    private func startTimer() {
        addSpinnerContainer()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.loadDebtAccounts()
        }
    }
    
    private func addSpinnerContainer() {
        spinnerContainer.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.view.addSubview(spinnerContainer)
        spinnerContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let disclosureLabel = UILabel()
        disclosureLabel.text = "Verifying your accounts can take up to 1 minute. Please wait while we verify your student loan accounts."
        disclosureLabel.textColor = .white
        disclosureLabel.textAlignment = .center
        disclosureLabel.numberOfLines = 0
        spinnerContainer.addSubview(disclosureLabel)
        disclosureLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.color = .white
        spinnerContainer.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(disclosureLabel.snp.bottom).offset(10)
        }
        activityIndicator.startAnimating()
    }
    
    private func loadDebtAccounts() {
        dataStore.loadDebtAccounts { debtAccounts in
            if !debtAccounts.isEmpty {
                self.timer?.invalidate()
                self.spinnerContainer.removeFromSuperview()
                self.debtAccountsData = debtAccounts
                self.tableView.reloadData()
            }
        }
    }
    
    private func setNavBarBtns() {
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }

    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(cellType: ConnectedAccountsTableViewCell.self)
        tableView.register(cellType: LoanAccountCell.self)
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
        return self.debtAccountsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ConnectedAccountsTableViewCell.self)
        
        let debtAccount = debtAccountsData[indexPath.row]
        cell.balanceLabel.textColor = .black
        
        cell.titleLabel.text = debtAccount.debtAccountParse.title
        cell.balanceLabel.text = "Balance: " + debtAccount.debtAccountParse.remaining_balance_dollars
        
//        cell.logoImg.loadFromFile(debtAccount.logoImg)
        let recent_payment = debtAccount.debtAccountParse.last_payment_amount_dollars
        let ticketAmount = String(debtAccount.last_payment_ticket_amount)
        cell.recentPaymentLabel.text = "Most Recent Payment: " + recent_payment + " =\(ticketAmount) tickets"
        cell.setChevron(imageName: "chevronGrey")

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
