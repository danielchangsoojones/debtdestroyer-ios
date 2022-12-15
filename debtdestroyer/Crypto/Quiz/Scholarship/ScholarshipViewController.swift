//
//  ScholarshipViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/12/22.
//

import UIKit

class ScholarshipViewController: UIViewController {
    
    struct Scholarship {
        let scholarshipName: String
        let deadline: String
        let amount: String
        let url : String
    }
  
    private var tableView: UITableView!
    private var scholarshipData : [Scholarship] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        scholarshipData.append(.init(scholarshipName: "$1,000 All Star Verified Scholarship", deadline: "08/31/2022", amount: "$1,000", url: "https://www.verifiedscholarships.com/scholarship-program/?utm_source=www.discover.com&utm_medium=weblink&utm_campaign=ss-api"))
        scholarshipData.append(.init(scholarshipName: "$1,000 JumpStart Scholarship", deadline: "10/17/2022", amount: "$1,000", url: "https://www.jumpstart-scholarship.net/?utm_source=notDefined&utm_medium=weblink&utm_campaign=ss-api"))
        scholarshipData.append(.init(scholarshipName: "$1,000 Moolahspot Scholarship", deadline: "08/31/2022", amount: "$1,000", url: "http://www.moolahspot.com/index.cfm?scholarship=1&utm_source=notDefined&utm_medium=weblink&utm_campaign=ss-api"))
        scholarshipData.append(.init(scholarshipName: "Cashtelligent Financial Literacy Scholarship", deadline: "09/30/2022", amount: "$1,000", url: "https://www.scholarshipengine.com/go/go.cfm?key=51B6554F-CD67-1405-68DDED8B5A8AC8C6"))
        scholarshipData.append(.init(scholarshipName: "SuperCollege Scholarship", deadline: "09/31/2022", amount: "$1,000", url: "https://www.scholarshipengine.com/go/go.cfm?key=EC15A704-1372-063F-7E51AB29FB04B3B6"))
        scholarshipData.append(.init(scholarshipName: "Academic Excellence Award", deadline: "11/12/2022", amount: "$1,000", url: "https://www.scholarshipengine.com/go/go.cfm?key=1D5449CC-F564-FE84-A969D66404373FDC"))
        scholarshipData.append(.init(scholarshipName: "Achieving Your Goals Scholarship", deadline: "09/30/2022", amount: "$1,000", url: "https://www.scholarshipengine.com/go/go.cfm?key=C2FBB211-842B-2B69-6026BE85C30AC87E"))
        scholarshipData.append(.init(scholarshipName: "Adelman Travel Scholarship Award", deadline: "11/30/2022", amount: "$500", url: "https://www.scholarshipengine.com/go/go.cfm?key=CD41CA4E-A4EF-A199-810095924EB51F5D"))
        scholarshipData.append(.init(scholarshipName: "AES Scholarship", deadline: "10/08/2022", amount: "$500", url: "https://www.scholarshipengine.com/go/go.cfm?key=2B234B2C-C7BE-DE88-C9BF772338F9A415"))
        scholarshipData.append(.init(scholarshipName: "Ag Day Essay Contest", deadline: "01/31/2023", amount: "$1,000", url: "https://www.scholarshipengine.com/go/go.cfm?key=0E5C9B1B-842B-2B69-602630F236E80385"))
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.register(cellType: ScholarshipTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
}
extension ScholarshipViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarshipData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ScholarshipTableViewCell.self)
        cell.titleLabel.text = scholarshipData[indexPath.row].scholarshipName
        cell.dueDateLabel.text = "due date: " + scholarshipData[indexPath.row].deadline

        cell.amountLabel.text = scholarshipData[indexPath.row].amount


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: scholarshipData[indexPath.row].url)!
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // MARK: Connected Accounts Section
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        let headerTitle = UILabel()
        
        headerTitle.text = "Find scholarships and grants."
        headerTitle.numberOfLines = 0
        headerTitle.textColor = .black
        headerTitle.textAlignment = .left
        headerTitle.font = UIFont.MontserratBold(size: 30)
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        let headerSubTitle = UILabel()
        
        headerSubTitle.text = "We'll notify you when new scholarships become available that fit your profile!"
        headerSubTitle.numberOfLines = 0
        headerSubTitle.textColor = .black
        headerSubTitle.textAlignment = .left
        headerSubTitle.font = UIFont.MontserratMedium(size: 24)
        headerView.addSubview(headerSubTitle)
        headerSubTitle.snp.makeConstraints{ make in
            make.top.equalTo(headerTitle.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    @objc private func editConnectedAccountsBtnClicked() {
        let vc = ConnectedAccountsViewController()
        self.navigationController?.pushViewController(vc.self, animated: true)
    }
    
}
