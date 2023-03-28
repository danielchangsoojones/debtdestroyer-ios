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
    var shareButton: UIButton!
    var searchBar: UISearchBar!
    var startShareAction: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTitleLabel()
        setPromoInfoLabel()
        setUpShareButton()
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(subtitle: String) {
        promoInfoLabel.text = subtitle
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "How do referrals work?"
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.MontserratSemiBold(size: 25)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }
    
    private func setPromoInfoLabel() {
        promoInfoLabel = UILabel()
        promoInfoLabel.numberOfLines = 0
        promoInfoLabel.textAlignment = .left
        promoInfoLabel.textColor = .black
        promoInfoLabel.font = UIFont.MontserratMedium(size: 16)
        contentView.addSubview(promoInfoLabel)
        promoInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    
    private func setUpShareButton() {
        shareButton = UIButton()
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.setTitle("Share Link", for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        shareButton.titleLabel?.textColor = .white
        shareButton.backgroundColor = UIColor(red: 236/255, green: 91/255, blue: 46/255, alpha: 1)
        shareButton.layer.cornerRadius = 25
        shareButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        contentView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(promoInfoLabel.snp.bottom).offset(25)
        }
    }
    
    @objc private func shareButtonPressed() {
        startShareAction?()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        contentView.addSubview(searchBar)
        searchBar.placeholder = "Search friends"
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(shareButton.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
