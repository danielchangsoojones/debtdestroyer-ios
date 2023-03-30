//
//  PromoCodeView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeUsedView: UIView {
    let tableView = UITableView()
    var theSpinnerContainer: UIView!
    var shareButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setShareButton()
        setTableView()
        setLoadingSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShareButton() {
        shareButton = UIButton()
        shareButton.setTitle("Share link instead", for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        shareButton.titleLabel?.textColor = .white
        shareButton.backgroundColor = UIColor(red: 236/255, green: 91/255, blue: 46/255, alpha: 1)
        shareButton.layer.cornerRadius = 25
        shareButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(shareButton.snp.top).offset(-8)
        }
    }
    
    private func setLoadingSpinner() {
        theSpinnerContainer = Helpers.showActivityIndicatory(in: tableView)
        theSpinnerContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
