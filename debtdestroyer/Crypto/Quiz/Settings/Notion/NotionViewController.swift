//
//  WebsiteViewController.swift
//  debtdestroyer
//
//  Created by DK on 4/8/23.
//

import UIKit
import WebKit

class NotionViewController: UIViewController {
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private var theSpinnerContainer: UIView!
    let appUrl: String!
    
    init(notionURL: String) {
        self.appUrl = notionURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(webView)
        theSpinnerContainer = Helpers.showActivityIndicatory(in: webView)
        view.addSubview(theSpinnerContainer)
        webView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.topMargin)
        }
        theSpinnerContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        DispatchQueue.main.async {
            if let url = URL(string: self.appUrl) {
                self.webView.load(URLRequest(url: url))
            }
        }
        
        webView.navigationDelegate = self
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension NotionViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        theSpinnerContainer.isHidden = true
    }
}
