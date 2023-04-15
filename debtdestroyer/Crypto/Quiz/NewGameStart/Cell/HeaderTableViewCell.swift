//
//  HeaderTableViewCell.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit
import Reusable

class HeaderTableViewCell: UITableViewCell, Reusable {
    var headerLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupHeaderLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(label: String) {
        headerLabel.text = label
    }
    
    private func setupHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 23, weight: .regular)
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
        contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
}