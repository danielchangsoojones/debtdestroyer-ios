//
//  RegisterView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class RegisterView: UIView {
    var stackView: UIStackView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var emailLabel: UILabel!
    var passwordLabel: UILabel!
    var nextButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        setUpStackView()
        setUpStackViewContent()
        setUpNextButton()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setUpStackView() {
        stackView = UIStackView()
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    private func setUpStackViewContent() {
        emailLabel = createLabel(title: "Email")
        emailTextField = createTextField(placeHolder: "example@domain.com")
        passwordLabel = createLabel(title: "Password")
        passwordTextField = createTextField(placeHolder: "**********")
    }
    
    private func setUpNextButton() {
        nextButton = UIButton()
        let dimenssion = 45
        nextButton.setBackgroundImage(UIImage.init(named: "nextButton"), for: .normal)
        nextButton.layer.cornerRadius = CGFloat(dimenssion / 2)
        nextButton.clipsToBounds = true
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(dimenssion)
        }
    }
    
    private func createLabel(title: String) -> UILabel {

        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .jaguarBlack
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        stackView.addArrangedSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        return label
    }
    
    
    private func createTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor =  UIColor.systemGray2.cgColor
        textField.layer.cornerRadius = 8
        textField.textColor = .black
        textField.placeholder = placeHolder
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.setLeftPaddingPoints(10)
        stackView.addArrangedSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        return textField
    }
}
