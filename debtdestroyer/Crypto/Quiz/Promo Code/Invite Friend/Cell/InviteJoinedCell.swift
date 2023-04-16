//
//  InviteJoinedCell.swift
//  debtdestroyer
//
//  Created by DK on 3/24/23.
//

import UIKit

class InviteJoinedCell: InviteContactCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        subtitleLabel.removeFromSuperview()
        textButton.isEnabled = false
        textButton.setTitle("Joined", for: .normal)
        textButton.backgroundColor = .gray
        textButton.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
