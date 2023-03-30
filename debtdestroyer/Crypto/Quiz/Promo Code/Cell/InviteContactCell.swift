//
//  InviteContactCell.swift
//  debtdestroyer
//
//  Created by DK on 3/23/23.
//

import UIKit
import Reusable

class InviteContactCell: UITableViewCell, Reusable {
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var textButton: UIButton!
    var startTextAction: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpTitleLabel()
        setUpSubtitleLabel()
        setUpTextButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
    }
    
    private func setUpSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = UIColor(red: 236/255, green: 91/255, blue: 46/255, alpha: 1)
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func set(name: String, friendCount: Int) {
        titleLabel.text = name
        subtitleLabel.text = friendCount > 1 ? "\(friendCount) friends on Debt Destroyer" : "\(friendCount) friend on Debt Destroyer"
    }
    
    private func setUpTextButton() {
        textButton = UIButton()
        textButton.tintColor = .white
        textButton.setTitle("Invite", for: .normal)
        textButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        textButton.layer.cornerRadius = 8
        textButton.setTitleColor(.white, for: .normal)
        textButton.backgroundColor = UIColor(red: 236/255, green: 91/255, blue: 46/255, alpha: 1)
        textButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textButton.addTarget(self, action: #selector(textButtonPressed), for: .touchUpInside)
        contentView.addSubview(textButton)
        textButton.imageView?.contentMode = .scaleAspectFit
        textButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    @objc private func textButtonPressed() {
        startTextAction?()
    }
}
