//
//  InviteInfoCell.swift
//  debtdestroyer
//
//  Created by DK on 3/24/23.
//

import UIKit
import Reusable

class InviteInfoCell: UITableViewCell, Reusable {
    private var titleLabel: UILabel!
    private var promoInfoLabel: UILabel!
    var searchBar: UISearchBar!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTitleLabel()
        setPromoInfoLabel()
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(title: NSAttributedString, subtitle: String) {
        titleLabel.attributedText = title
        promoInfoLabel.text = subtitle
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.MontserratSemiBold(size: 25)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setPromoInfoLabel() {
        promoInfoLabel = UILabel()
        promoInfoLabel.numberOfLines = 0
        promoInfoLabel.textAlignment = .center
        promoInfoLabel.textColor = .black
        promoInfoLabel.font = UIFont.MontserratLight(size: 14)
        contentView.addSubview(promoInfoLabel)
        promoInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        contentView.addSubview(searchBar)
        searchBar.placeholder = "Search friends"
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(promoInfoLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
