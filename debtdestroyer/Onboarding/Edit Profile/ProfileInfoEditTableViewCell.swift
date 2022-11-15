//
//  ProfileInfoEditTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import Reusable
import SkyFloatingLabelTextField

class ProfileInfoEditTableViewCell: UITableViewCell, Reusable {
    
    let firstNameTxt = SkyFloatingLabelTextField()
    let lastNameTxt = SkyFloatingLabelTextField()
    let phNumberTxt = SkyFloatingLabelTextField()
    let textFieldHeightConst = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
       setFirstNameTextField()
        setLastNameTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFirstNameTextField() {
        firstNameTxt.textAlignment = .left
        firstNameTxt.placeholder = "First Name"
        firstNameTxt.textColor = .black
        firstNameTxt.font = UIFont.MontserratRegular(size: 16)
        addSubview(firstNameTxt)
        firstNameTxt.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
    }

    private func setLastNameTextField() {
        lastNameTxt.textAlignment = .left
        lastNameTxt.placeholder = "Last Name"
        lastNameTxt.textColor = .black
        lastNameTxt.font = UIFont.MontserratRegular(size: 16)
        addSubview(lastNameTxt)
        lastNameTxt.snp.makeConstraints { make in
            make.top.equalTo(firstNameTxt.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

}
