//
//  ConnectedAccountsViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/08/22.
//

import UIKit
import WebKit

class ConnectedAccountsViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var tableView: UITableView!
    private var debtAccountsData: [DebtAccountsParse] = []
    private let webview = WKWebView()
    private let dataStore = ConnectAccountsDataStore()

    init(debtAccounts: [DebtAccountsParse]) {
        self.debtAccountsData = debtAccounts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setNavBarBtns()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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
        cell.removeButton.addTarget(self, action: #selector(removeStudentLoanAccBtnPressed), for: .touchUpInside)
        return cell
    }
    
    @objc private func removeStudentLoanAccBtnPressed() {
     print("removeStudentLoanAccBtnPressed")
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
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        footer.backgroundColor = .white
        let connectLoanAccountBtn = UIButton(frame: CGRect(x:15,y: 10 ,width:footer.frame.width - 30,height:70))
        connectLoanAccountBtn.backgroundColor = .white
        connectLoanAccountBtn.titleLabel?.textAlignment = .center
        connectLoanAccountBtn.titleLabel?.numberOfLines = 0
        connectLoanAccountBtn.layer.cornerRadius =  8
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
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 90
    }
}

extension ConnectedAccountsViewController: WKNavigationDelegate {
    @objc private func connectLoanAccountBtnPressed() {
        dataStore.createMethodEntityAndAuthToken { method_entity_id, method_auth_token, error in
            //TODO: stop spinner
            if let method_entity_id = method_entity_id, let method_auth_token = method_auth_token {
                self.showMethodWebview(with: method_auth_token)
                User.current()?.method_entity_id = method_entity_id
            } else {
                let errorMsg = error?.localizedDescription ?? "unknown error with the createMethodEntityAndAuthToken"
                BannerAlert.show(title: "Error", subtitle: errorMsg, type: .error)
                
            }
        }
    }
    
    private func showMethodWebview(with elementToken: String) {
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        webview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let link = "https://elements.dev.methodfi.com" + "?token=" + elementToken
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            let _ = webview.load(request)
        } else {
            BannerAlert.show(title: "Error", subtitle: "error creating a url for the method webview", type: .error)
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if(navigationAction.navigationType == .other) {
            if let redirectedUrl = navigationAction.request.url  {
                //we are trying to see if we got the redirect url from Method's auth
                //https://docs.methodfi.com/guides/quick-start/retrieve-an-entitys-debts#2-create-an-auth-element-token
                let hasSuccess = redirectedUrl.absoluteString.contains("op=success")
                let hasAuth = redirectedUrl.absoluteString.contains("element_type=auth")
                let hasMethodElement = redirectedUrl.absoluteString.contains("methodelements:")
                if hasMethodElement && hasSuccess && hasAuth {
                    print("we got the success callback that they succesfully authorized")
                    decisionHandler(.cancel)
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
}
