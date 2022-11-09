//
//  ConnectDisclosureViewController.swift

//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit
import WebKit

class ConnectDisclosureViewController: UIViewController {
    
    var connectDisclosureView = ConnectDisclosureView()
    var titleLbl = UILabel()
    var descriptionTextView = UITextView()
    var connectAccBtn = SpinningWithGradButton()
    private var messageHelper: MessageHelper?
    private let dataStore = ConnectAccountsDataStore()
    private let webview = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        connectDisclosureView = ConnectDisclosureView(frame: self.view.bounds)
        self.view = connectDisclosureView
        self.descriptionTextView = connectDisclosureView.descriptionTextView
        self.connectAccBtn = connectDisclosureView.connectAccBtn
        self.titleLbl = connectDisclosureView.titleLbl
        
        self.connectAccBtn.addTarget(self, action: #selector(connectAccBtnPressed), for: .touchUpInside)
        
        setNavBarBtns()
    }
    
    private func setNavBarBtns() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        self.navigationController?.setStatusBar(backgroundColor: .white)
        let navBtn = UIButton()
        let attStr = NSMutableAttributedString(string: "Questions?", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15)])
        
        attStr.append(NSMutableAttributedString(string: " Message us.", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor:UIColor.black]))
        
        navBtn.setAttributedTitle(attStr, for: .normal)
        navBtn.addTarget(self, action: #selector(questionsPressed), for: .touchUpInside)
        let helpButton = UIBarButtonItem(customView: navBtn)
        navigationItem.rightBarButtonItem = helpButton
    }
    
    @objc private func questionsPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
}

extension ConnectDisclosureViewController: WKNavigationDelegate {
    @objc private func connectAccBtnPressed() {
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
                
                let isExitOP = redirectedUrl.absoluteString.contains("op=exit")
                if isExitOP {
                    decisionHandler(.cancel)
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
}
