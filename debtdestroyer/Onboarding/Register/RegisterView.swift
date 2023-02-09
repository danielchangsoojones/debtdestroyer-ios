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
    var nextButton: NextButton!
    var imageView: UIImageView!
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        setUpStackView()
        setUpStackViewContent()
        setUpNextButton()
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupImageView() {
        imageView = UIImageView()
        // Center imageView in the middle of screen and give it full width and automatic height with inset of 20
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(self.frame.width * 0.9)
        }
        imageView.contentMode = .scaleAspectFit
        // Make imageView default hidden
        imageView.isHidden = true

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
        stackView.addArrangedSubview(titleLabel)
        titleLabel.isHidden = true
        titleLabel.font = UIFont.MontserratBold(size: 24)
        titleLabel.textColor = .jaguarBlack
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        subtitleLabel.isHidden = true
        subtitleLabel.font = UIFont.MontserratLight(size: 18)
        subtitleLabel.textColor = .jaguarBlack
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        emailLabel = createLabel(title: "Email")
        emailTextField = createTextField(placeHolder: "example@domain.com")
        passwordLabel = createLabel(title: "Password")
        passwordTextField = createTextField(placeHolder: "**********")
    }

    private func setUpNextButton(){
        nextButton = NextButton()
        nextButton.clipsToBounds = true
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func createLabel(title: String) -> UILabel {

        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .jaguarBlack
        label.font = UIFont.MontserratLight(size: 18)
        stackView.addArrangedSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
        }

        return label
    }


    private func createTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.MontserratRegular(size: 18)
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
