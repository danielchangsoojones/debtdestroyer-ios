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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTableView()
        setLoadingSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setLoadingSpinner() {
        theSpinnerContainer = Helpers.showActivityIndicatory(in: tableView)
        theSpinnerContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
