//
//  PastWinnerCollectionTableViewCell.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit
import Reusable

class PastWinnerCollectionTableViewCell: UICollectionViewCell, Reusable {
    private var nameLabel: UILabel!
    private var winningsLabel: UILabel!
    private var container: UIView!
    private var defaultImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContainer()
        setUpDefaultImg()
        setUpWinningLabel()
        setUpNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        defaultImageView.image = nil
    }
    
    func set(name: String, amountWon: String, winnerImage: UIImage? = nil) {
        nameLabel.text = name
        winningsLabel.text = amountWon
        let image = winnerImage ?? UIImage(named: "logo")
        defaultImageView.image = image
        defaultImageView.layer.cornerRadius = winnerImage == nil ? 35 : 10
        defaultImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(winnerImage == nil ? 70 : 100)
            make.height.equalTo(winnerImage == nil ? 70 : 130)
        }
        winningsLabel.snp.remakeConstraints { make in
            make.top.equalTo(defaultImageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(container).inset(15)
        }
    }
    
    private func setUpContainer() {
        container = UIView()
        container.backgroundColor = .black
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor(red: 95/255, green: 205/255, blue: 236/255, alpha: 1).cgColor
        container.layer.shadowColor = UIColor.white.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 0)
        container.layer.shadowOpacity = 0.4
        container.layer.shadowRadius = 10
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
    }

    private func setUpDefaultImg() {
        defaultImageView = UIImageView()
        defaultImageView.contentMode = .scaleAspectFit
        defaultImageView.clipsToBounds = true
        container.addSubview(defaultImageView)
        defaultImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    private func setUpWinningLabel() {
        winningsLabel = UILabel()
        winningsLabel.textColor = UIColor(red: 95/255, green: 205/255, blue: 236/255, alpha: 1)
        winningsLabel.textAlignment = .center
        winningsLabel.font = .systemFont(ofSize: 25, weight: .bold)
        container.addSubview(winningsLabel)
        winningsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(defaultImageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(container).inset(15)
        }
    }
    
    private func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(container)
            make.top.equalTo(container.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
