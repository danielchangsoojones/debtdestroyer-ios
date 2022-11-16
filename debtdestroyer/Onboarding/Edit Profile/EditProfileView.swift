//
//  EditProfileView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileView: UIView {
    let profileImg = UIImageView()
    var editBtn = UIButton()
    let firstNameTxt = SkyFloatingLabelTextField()
    let lastNameTxt = SkyFloatingLabelTextField()
    let phNumberTxt = SkyFloatingLabelTextField()
    let emailTxt = SkyFloatingLabelTextField()
    let passwordTxt = SkyFloatingLabelTextField()
    let textFieldHeightConst = 50
    let scrollView = UIScrollView()
    let contentView = UIView()
    var chevronImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        setScrollView()
        setProfileImg()
        setEditButtonView()
        setFirstNameTextField()
        setLastNameTextField()
        setPhoneNumberTextField()
        setEmailTextField()
        setPasswordTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.height.equalTo(1200)
        }
    }

    
    private func setProfileImg() {
        profileImg.image = UIImage.init(systemName: "person")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        profileImg.contentMode = .scaleAspectFill
        profileImg.clipsToBounds = true
        let dimension: CGFloat = 120
        profileImg.layer.cornerRadius = dimension / 2
        profileImg.layer.borderColor = UIColor.gray.cgColor
        profileImg.layer.borderWidth = 1
        contentView.addSubview(profileImg)
        profileImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(dimension)
            make.topMargin.equalToSuperview().inset(30)
        }
    }
    
    private func setEditButtonView() {
        editBtn.setImage(UIImage.init(systemName: "camera.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        editBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        editBtn.backgroundColor = .clear
        let dimension: CGFloat = 45
        editBtn.layer.cornerRadius = dimension / 2
        contentView.addSubview(editBtn)
        editBtn.snp.makeConstraints { make in
            make.height.width.equalTo(dimension)
            make.bottom.equalTo(profileImg.snp.bottom).offset(-20)
            make.leading.equalTo(105)
        }
    }

    private func setFirstNameTextField() {
        firstNameTxt.textAlignment = .left
        firstNameTxt.placeholder = "First Name"
        firstNameTxt.textColor = .black
        firstNameTxt.selectedTitleColor = .gray
        firstNameTxt.font = UIFont.MontserratRegular(size: 16)
        contentView.addSubview(firstNameTxt)
        firstNameTxt.snp.makeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
    }
    
    private func setLastNameTextField() {
        lastNameTxt.textAlignment = .left
        lastNameTxt.placeholder = "Last Name"
        lastNameTxt.textColor = .black
        lastNameTxt.selectedTitleColor = .gray
        lastNameTxt.font = UIFont.MontserratRegular(size: 16)
        contentView.addSubview(lastNameTxt)
        lastNameTxt.snp.makeConstraints { make in
            make.top.equalTo(firstNameTxt.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
    }
    
    private func setPhoneNumberTextField() {
        phNumberTxt.textAlignment = .left
        phNumberTxt.placeholder = "Phone Number"
        phNumberTxt.textColor = .black
        phNumberTxt.selectedTitleColor = .gray
        phNumberTxt.font = UIFont.MontserratRegular(size: 16)
        contentView.addSubview(phNumberTxt)
        phNumberTxt.snp.makeConstraints { make in
            make.top.equalTo(lastNameTxt.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
        
        setChevron()
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(phNumberTxt)
            make.height.width.equalTo(15)
        }
    }

    private func setEmailTextField() {
        emailTxt.textAlignment = .left
        emailTxt.placeholder = "Email"
        emailTxt.textColor = .black
        emailTxt.selectedTitleColor = .gray
        emailTxt.font = UIFont.MontserratRegular(size: 16)
        contentView.addSubview(emailTxt)
        emailTxt.snp.makeConstraints { make in
            make.top.equalTo(phNumberTxt.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
        
        setChevron()
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(emailTxt)
            make.height.width.equalTo(15)
        }
    }

    private func setPasswordTextField() {
        passwordTxt.textAlignment = .left
        passwordTxt.placeholder = "Password"
        passwordTxt.textColor = .black
        passwordTxt.selectedTitleColor = .gray
        passwordTxt.font = UIFont.MontserratRegular(size: 16)
        contentView.addSubview(passwordTxt)
        passwordTxt.snp.makeConstraints { make in
            make.top.equalTo(emailTxt.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(textFieldHeightConst)
        }
        
        setChevron()
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(passwordTxt)
            make.height.width.equalTo(15)
        }
    }
    
    func setChevron() {
        chevronImageView = UIImageView(image: UIImage(named: "chevronGrey"))
        chevronImageView.contentMode = .scaleAspectFit
        contentView.addSubview(chevronImageView)
    }
    
}
