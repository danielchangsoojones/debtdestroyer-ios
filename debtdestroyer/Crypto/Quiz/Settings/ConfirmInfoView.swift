//
//  ConfirmInfoView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit

class ConfirmInfoView: UIView {

    private let titleLbl = UILabel()
    private let firstNameLbl = UILabel()
    private let lastNameLbl = UILabel()
    private let phNumberLbl = UILabel()
    let firstNameTxt = UITextField()
    let lastNameTxt = UITextField()
    let phNumberTxt = UITextField()
    let firstNameEditBtn = UIButton()
    let lastNameEditBtn = UIButton()
    let phNumberEditBtn = UIButton()
    let nextBtn = SpinningWithGradButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setFirstNameLabel()
        setFirstNameEditBtn()
        setFirstNameTextField()
        setLastNameLabel()
        setLastNameEditBtn()
        setLastNameTextField()
        setPhoneNumberLabel()
        setPhoneNumberEditBtn()
        setPhoneNumberTextField()
        setNextBtn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLbl.text = "Confirm your info"
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        titleLbl.textColor = .black
        titleLbl.font = UIFont.MontserratBold(size: 26)
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func setFirstNameLabel() {
        firstNameLbl.text = "First Name:"
        firstNameLbl.numberOfLines = 0
        firstNameLbl.textAlignment = .left
        firstNameLbl.textColor = .black
        firstNameLbl.font = UIFont.MontserratSemiBold(size: 16)
        addSubview(firstNameLbl)
        firstNameLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
            
        }
    }

    private func setFirstNameEditBtn() {
        firstNameEditBtn.setImage(UIImage.init(named: "pencil"), for: .normal)
        addSubview(firstNameEditBtn)
        firstNameEditBtn.snp.makeConstraints { make in
            make.centerY.equalTo(firstNameLbl)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(20)
        }
    }
        
    private func setFirstNameTextField() {
        firstNameTxt.textAlignment = .right
        firstNameTxt.textColor = .black
        firstNameTxt.font = UIFont.MontserratRegular(size: 16)
        firstNameTxt.isUserInteractionEnabled = false
        addSubview(firstNameTxt)
        firstNameTxt.snp.makeConstraints { make in
            make.centerY.equalTo(firstNameLbl)
            make.trailing.equalTo(firstNameEditBtn.snp.leading).offset(-5)
            make.leading.equalTo(firstNameLbl.snp.trailing).offset(5)
        }
    }
    
    private func setLastNameLabel() {
        lastNameLbl.text = "Last Name:"
        lastNameLbl.numberOfLines = 0
        lastNameLbl.textAlignment = .left
        lastNameLbl.textColor = .black
        lastNameLbl.font = UIFont.MontserratSemiBold(size: 16)
        addSubview(lastNameLbl)
        lastNameLbl.snp.makeConstraints { make in
            make.top.equalTo(firstNameLbl.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setLastNameEditBtn() {
        lastNameEditBtn.setImage(UIImage.init(named: "pencil"), for: .normal)
        addSubview(lastNameEditBtn)
        lastNameEditBtn.snp.makeConstraints { make in
            make.centerY.equalTo(lastNameLbl)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(20)
        }
    }
    
    private func setLastNameTextField() {
        lastNameTxt.textAlignment = .right
        lastNameTxt.textColor = .black
        lastNameTxt.font = UIFont.MontserratRegular(size: 16)
        lastNameTxt.isUserInteractionEnabled = false
        addSubview(lastNameTxt)
        lastNameTxt.snp.makeConstraints { make in
            make.centerY.equalTo(lastNameLbl)
            make.trailing.equalTo(lastNameEditBtn.snp.leading).offset(-5)
            make.leading.equalTo(lastNameLbl.snp.trailing).offset(5)
        }
    }
    
    private func setPhoneNumberLabel() {
        phNumberLbl.text = "Phone Number:"
        phNumberLbl.numberOfLines = 0
        phNumberLbl.textAlignment = .left
        phNumberLbl.textColor = .black
        phNumberLbl.font = UIFont.MontserratSemiBold(size: 16)
        addSubview(phNumberLbl)
        phNumberLbl.snp.makeConstraints { make in
            make.top.equalTo(lastNameLbl.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            
        }
    }
    
    private func setPhoneNumberEditBtn() {
        phNumberEditBtn.setImage(UIImage.init(named: "pencil"), for: .normal)
        addSubview(phNumberEditBtn)
        phNumberEditBtn.snp.makeConstraints { make in
            make.centerY.equalTo(phNumberLbl)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(20)
        }
    }
    
    private func setPhoneNumberTextField() {
        phNumberTxt.textAlignment = .right
        phNumberTxt.textColor = .black
        phNumberTxt.font = UIFont.MontserratRegular(size: 16)
        phNumberTxt.isUserInteractionEnabled = false
        addSubview(phNumberTxt)
        phNumberTxt.snp.makeConstraints { make in
            make.centerY.equalTo(phNumberLbl)
            make.trailing.equalTo(phNumberEditBtn.snp.leading).offset(-5)
            make.leading.equalTo(phNumberLbl.snp.trailing).offset(5)
        }
    }


    private func setNextBtn() {
        nextBtn.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if nextBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Next ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                nextBtn.configuration = configuration
                
            } else {
                nextBtn.configuration?.attributedTitle = AttributedString("Next ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            nextBtn.setTitleColor(.white, for: .normal)
            nextBtn.setTitle("Next ➔", for: .normal)
        }
        let height: CGFloat = 55
        nextBtn.layer.cornerRadius = height/2
        nextBtn.layer.masksToBounds = true
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
    
    
}
