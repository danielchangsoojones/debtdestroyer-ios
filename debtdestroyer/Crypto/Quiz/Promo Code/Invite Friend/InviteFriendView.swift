//
//  PromoCodeView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class InviteFriendView: UIView {
    let tableView = UITableView()
    var theSpinnerContainer: UIView!
    var shareButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setShareButton()
        setTableView()
        setLoadingSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShareButton() {
        let blueColor = UIColor(red: 95/255, green: 205/255, blue: 236/255, alpha: 1)
        shareButton = UIButton()
        shareButton.setTitle("Share link instead", for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        shareButton.setTitleColor(blueColor, for: .normal)
        shareButton.backgroundColor = .black
        shareButton.layer.borderWidth = 2
        shareButton.layer.borderColor = blueColor.cgColor
        shareButton.layer.cornerRadius = 25
        shareButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .black
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
