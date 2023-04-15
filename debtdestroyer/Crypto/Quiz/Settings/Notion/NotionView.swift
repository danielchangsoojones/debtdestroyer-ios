//
//  NotionView.swift
//  debtdestroyer
//
//  Created by DK on 4/8/23.
//

import UIKit
import WebKit

class NotionView: UIView {
    var webView: WKWebView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpNotionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNotionView() {
        webView = WKWebView()
        addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.snp.topMargin)
        }
    }
}
