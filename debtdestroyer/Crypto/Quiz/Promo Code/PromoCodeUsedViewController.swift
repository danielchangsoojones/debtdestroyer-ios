//
//  PromoCodeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeUsedViewController: UIViewController {
    private var titleLbl: UILabel!
    private var promoInfoLabel: UILabel!
    private var promoUsers: [PromoUser] = []
    private let dataStore = PromoDataStore()
    private var tableView: UITableView!
    private var faqBtn: UIButton!
    
    class PromoUser {
        let user: User
        
        init(user: User) {
            self.user = user
        }
    }
    
    override func loadView() {
        super.loadView()
        let promoCodeView = PromoCodeUsedView(frame: self.view.frame)
        self.view = promoCodeView
        self.titleLbl = promoCodeView.titleLbl
        self.promoInfoLabel = promoCodeView.promoInfoLabel
        self.tableView = promoCodeView.tableView
        promoCodeView.faqBtn.addTarget(self, action: #selector(faqPressed), for: .touchUpInside)
        promoCodeView.tableView.delegate = self
        promoCodeView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invite Friends"
        loadData()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicStyle")
    }
    
    private func loadData() {
        dataStore.getPromoInfo { promoUsers, personalPromo, promo_info_str in
            self.promoUsers = promoUsers
            self.tableView.reloadData()
            
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: personalPromo, attributes: underlineAttribute)
            self.titleLbl.attributedText = underlineAttributedString
            
            self.promoInfoLabel.text = promo_info_str
        }
    }
    
    @objc private func faqPressed() {
        
    }
}

extension PromoCodeUsedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let promoUser = promoUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        cell.textLabel?.text = promoUser.user.fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    Don't need a header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        let label = UILabel()
//        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//        label.text = "Your Invited Friends"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
//        headerView.addSubview(label)
//        return headerView
//    }
}
