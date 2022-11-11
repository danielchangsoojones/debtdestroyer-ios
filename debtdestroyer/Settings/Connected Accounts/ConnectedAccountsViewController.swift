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
    private var debtAccountsData: [ConnectAccountsDataStore.DebtAccount] = []
    private let webview = WKWebView()
    private let dataStore = ConnectAccountsDataStore()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setNavBarBtns()
        loadDebtAccounts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func loadDebtAccounts() {
        dataStore.loadDebtAccounts { debtAccounts in
            self.debtAccountsData = debtAccounts
            self.tableView.reloadData()
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
        cell.recentPaymentLabel.text = "Most Recent Payment: $" + recent_payment + " ="
        cell.setChevron(imageName: "chevronGrey")

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

extension ConnectedAccountsViewController: WKNavigationDelegate {
    @objc private func connectLoanAccountBtnPressed() {
        dataStore.createMethodEntityAndAuthToken { method_entity_id, auth_element_url, error in
            //TODO: stop spinner
            if let method_entity_id = method_entity_id, let auth_element_url = auth_element_url {
                self.showMethodWebview(with: auth_element_url)
                User.current()?.method_entity_id = method_entity_id
            } else {
                let errorMsg = error?.localizedDescription ?? "unknown error with the createMethodEntityAndAuthToken"
                BannerAlert.show(title: "Error", subtitle: errorMsg, type: .error)
                
            }
        }
    }
    
    private func showMethodWebview(with auth_element_url: String) {
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        webview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        if let url = URL(string: auth_element_url) {
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
