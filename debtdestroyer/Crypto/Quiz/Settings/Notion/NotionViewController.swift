//
//  WebsiteViewController.swift
//  debtdestroyer
//
//  Created by DK on 4/8/23.
//

import UIKit
import WebKit

class NotionViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private var webView: WKWebView!
    // the handler name injected into the web app for iOS webviews.
    let vouchedHandler = "onVouchedVerify"
    let appUrl: String!
    
    init(notionURL: String!) {
        self.appUrl = notionURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        DispatchQueue.main.async {
            if let url = URL(string: self.appUrl) {
                self.webView.load(URLRequest(url: url))
            }
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func loadView() {
        super.loadView()
        let notionView = NotionView(frame: self.view.bounds)
        self.view = notionView
        webView = notionView.webView
        
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: vouchedHandler)
        config.allowsInlineMediaPlayback = true
        webView.navigationDelegate = self
    }
    
    // implements WKScriptMessageHandler. For our callback, we will look
    // for messages sent by the vouchedHandler, and operate on them
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == vouchedHandler {
            
            guard let verifyData =
                    convertResponseToDict(payload: message.body as! String),
                  let results = verifyData["result"] as? [String: AnyObject],
                  let successCode = results["success"] as? Bool  else {
                print("Unable to process verification result")
                return
            }
            // todo: navigate according to success code, and/or results
            print("User was successfully verified: \(successCode)")
            print(results)
        }
    }
    
    // if using the iOS SDK, you can decode the payload into SDK objects,
    // but given we are bridging between two platforms, we'll create a
    // generic dictionary from the payload
    func convertResponseToDict(payload: String) -> [String:AnyObject]? {
        if let data = payload.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Unable to convert verification response")
            }
        }
        return nil
    }
}
