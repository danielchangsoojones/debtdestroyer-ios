//
//  ProfileImageTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import Reusable

class ProfileImageTableViewCell: UITableViewCell, Reusable {
    let profileImg = UIImageView()
    var editBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        selectionStyle = .none
        setProfileImg()
        setEditButtonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProfileImg() {
        profileImg.image = UIImage.init(systemName: "person")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        profileImg.contentMode = .scaleAspectFill
        profileImg.clipsToBounds = true
        let dimension: CGFloat = 120
        profileImg.layer.cornerRadius = dimension / 2
        profileImg.layer.borderColor = UIColor.gray.cgColor
        profileImg.layer.borderWidth = 1
        addSubview(profileImg)
        profileImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(dimension)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setEditButtonView() {
        editBtn.setImage(UIImage.init(systemName: "camera.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        editBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        editBtn.backgroundColor = .clear
        let dimension: CGFloat = 45
        editBtn.layer.cornerRadius = dimension / 2
        addSubview(editBtn)
        editBtn.snp.makeConstraints { make in
            make.height.width.equalTo(dimension)
            make.bottom.equalTo(-30)
            make.leading.equalTo(110)
        }
    }
}
