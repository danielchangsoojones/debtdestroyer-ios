//
//  WinnersViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 18/10/22.
//

import UIKit
import WebKit

class WinnersViewController: UIViewController {
    private let tableView = UITableView()
    
    private var quizDatas: [QuizDataParse] = []
    private let currentIndex: Int
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int) {
        self.quizDatas = quizDatas
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        //        setTableView()
        setWebView()
    }
    
    private func setWebView() {

        let webView = WKWebView ()
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        let url = URL (string: "https://www.instagram.com/debt_destroyed/?igshid=YmMyMTA2M2Y%3D")
        let request = URLRequest(url: url! as URL)
            webView.load(request)
     //https://developer.apple.com/forums/thread/711426
        webView.allowsBackForwardNavigationGestures = true

        webView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-tabbarHeight)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.register(cellType: WinnerTableCell.self)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.topMargin.leading.trailing.bottom.equalToSuperview()
        }
    }

}
extension WinnersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WinnerTableCell.self)
        let amount = "$25"
        if #available(iOS 15.0, *) {
            if cell.giftAmountBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString(amount, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
                cell.giftAmountBtn.configuration = configuration
                
            } else {
                cell.giftAmountBtn.configuration?.attributedTitle = AttributedString(amount, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            cell.giftAmountBtn.setTitleColor(.white, for: .normal)
            cell.giftAmountBtn.setTitle(amount, for: .normal)
        }
        
        if indexPath.row == 0 {
            cell.nameLabel.text = "Daniel"
            cell.imgView.image = UIImage.init(named: "Winner")
        } else if indexPath.row == 1 {
            cell.nameLabel.text = "Daniel"
            cell.imgView.image = UIImage.init(named: "")
            cell.imgView.snp.makeConstraints { make in
                make.height.equalTo(100)
            }
        } else {
            cell.nameLabel.text = ""
            cell.imgView.image = UIImage.init(named: "Winner")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension WinnersViewController : WKNavigationDelegate {

    
}
