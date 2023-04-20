//
//  LiveChatTableViewCell.swift
//  debtdestroyer
//
//  Created by DK on 4/19/23.
//

import UIKit
import Reusable

class LiveChatTableViewCell: UITableViewCell, Reusable {
    private var messageLabel: UILabel!
    private var nameLabel: UILabel!
    
    func set(name: String, message: String) {
        nameLabel.text = name
        messageLabel.text = message
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setTextView()
        setNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextView() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        messageLabel.textColor = .white
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setNameLabel() {
        nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        nameLabel.textColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(messageLabel.snp.top).offset(-5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
    }
}
