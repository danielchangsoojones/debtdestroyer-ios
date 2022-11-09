//
//  PrizeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 05/08/22.
//

import UIKit
import AVFoundation
import Parse

class PrizeViewController: UIViewController {
    
    private var tableView: UITableView!
    private let dataStore = PrizeDataStore()
    private var messageHelper: MessageHelper?
    var earningTicketsBtn : UIButton!
    private var pastWinnersData: [WinnerParse] = []
    private var hasNoAccountsConnected = false
    private var debtAccountsData: [DebtAccountsParse] = []
    private var ticketCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTableView()
        setEarningTicketsBtn()
        ForceUpdate.checkIfForceUpdate()
        checkIfAuthed()
        
        NotificationCenter.default.addObserver(self, selector: #selector(roundUpsClicked), name: NSNotification.Name(rawValue: "RoundUps"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(oneTimePaymentClicked), name: NSNotification.Name(rawValue: "OneTimePayment"), object: nil)
        setNavBarBtns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavingsInfo()
        loadSweepstakesInfo()
        loadTicketCount()
//        loadPastWinners()
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.hidesBackButton = true
        
        let navBtn = UIButton()
        let attStr = NSMutableAttributedString(string: "help?", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15)])
        
        attStr.append(NSMutableAttributedString(string: " Message us.", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor:UIColor.black]))
        
        navBtn.setAttributedTitle(attStr, for: .normal)
        navBtn.addTarget(self, action: #selector(helpPressed), for: .touchUpInside)
        let helpButton = UIBarButtonItem(customView: navBtn)
        navigationItem.rightBarButtonItem = helpButton
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func roundUpsClicked() {
        let vc = ScrollableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func oneTimePaymentClicked() {
        
    }
    
    private func checkIfAuthed() {
        dataStore.checkIfMethodAuthed { isAuthed in
            self.hasNoAccountsConnected = !isAuthed
            self.tableView.reloadData()
        }
    }
    
    private func loadTicketCount() {
        dataStore.getTickets { ticketAmount in
            self.ticketCount = ticketAmount
            self.tableView.reloadData()
        }
    }
    
    private func loadPastWinners() {
        dataStore.loadPastWinners { pastWinners in
            self.pastWinnersData = pastWinners
            self.tableView.reloadData()
        }
    }

    private func loadSavingsInfo() {
        dataStore.savingsInfo()
        tableView.reloadData()
    }
    
    private func loadSweepstakesInfo() {
        dataStore.sweepstakesInfo()
        tableView.reloadData()
    }

    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(cellType: WeekPrizeCell.self)
        tableView.register(cellType: ConnectAccountsCell.self)
        tableView.register(cellType: HowToEarnTicketsCell.self)
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.topMargin.leftMargin.rightMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview().offset(-120)
        }
    }
    
    private func setEarningTicketsBtn() {
        let tabBarHeight =  (self.tabBarController?.tabBar.frame.height ?? 50) as CGFloat
        earningTicketsBtn = UIButton(frame: .init(x: 30, y: self.view.frame.height - tabBarHeight - 90, width: self.view.frame.width - 60, height: 70))
        earningTicketsBtn.setTitle("Earn Tickets For This Week’s Prize", for: .normal)
        earningTicketsBtn.titleLabel?.numberOfLines = 0
        earningTicketsBtn.setTitleColor(hexStringToUIColor(hex: "FF2078"), for: .normal)
        earningTicketsBtn.titleLabel?.textAlignment = .center
        earningTicketsBtn.addTarget(self,
                                    action: #selector(earningTicketsBtnClicked),
                                    for: .touchUpInside)
        
        let gradientLayer = CAGradientLayer.init()
        
        let color1 = hexStringToUIColor(hex: "FF2474")
        let color2 = hexStringToUIColor(hex: "FF7910")
        gradientLayer.colors = [color1.cgColor, color2.cgColor]

        gradientLayer.frame = CGRect.init(
            x: earningTicketsBtn.frame.minX - 30,
            y: earningTicketsBtn.frame.minY - 30,
            width: earningTicketsBtn.frame.width + 60,
            height: earningTicketsBtn.frame.height + 50)
        gradientLayer.masksToBounds = true
        
        
        let shadowLayer = CALayer.init()
        shadowLayer.frame = gradientLayer.bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.99
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
        
        shadowLayer.shadowRadius = 30
        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        
        gradientLayer.mask = shadowLayer
        view.layer.insertSublayer(gradientLayer, below: earningTicketsBtn.layer)

        let dimension: CGFloat = 70
        earningTicketsBtn.layer.cornerRadius = dimension / 2
        earningTicketsBtn.backgroundColor = .white
        view.addSubview(earningTicketsBtn)
    }
    
    @objc private func earningTicketsBtnClicked() {
        
    }
    
    @objc private func setUpBtnClicked() {
        print("setUpBtnClicked")
    }
    
    @objc private func connectAccBtnClicked() {
        let vc = ConnectedAccountsViewController(debtAccounts: debtAccountsData)
        self.navigationController?.pushViewController(vc.self, animated: true)    }
}

extension PrizeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if hasNoAccountsConnected {
            return 3
        }
            return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // MARK: weekPrizeCell
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeekPrizeCell.self)
            cell.prizeDescriptionLabel.text = UserDefaults.standard.string(forKey: "deadlineTxt")
            cell.prizeAmountLabel.text = UserDefaults.standard.string(forKey: "prizeAmountTxt")
            cell.ticketsAmountLabel.text = "\(ticketCount) Tickets"
            return cell
        }
        if hasNoAccountsConnected {
            if indexPath.section == 1 {
                // MARK: Connect Account
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ConnectAccountsCell.self)
                cell.connectAccBtn.addTarget(self, action: #selector(connectAccBtnClicked), for: .touchUpInside)
                return cell
            } else if indexPath.section == 2 {
                // MARK: How to earn tickets
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HowToEarnTicketsCell.self)
                return cell
            }
        } else {
             if indexPath.section == 1 {
                // MARK: How to earn tickets
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HowToEarnTicketsCell.self)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
