//
//  AddressView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class AddressView: UIView {
    var stackView: UIStackView!
    var addTextField: UITextField!
    var addLabel: UILabel!
    var descriptionLabel: UILabel!
    var nextButton: SpinningWithGradButton!
    
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
            make.leading.trailing.equalToSuperview().inset(20).priority(.high)
            make.topMargin.equalToSuperview().offset(20)
        }
    }
    
    private func setUpStackViewContent() {
        addLabel = createLabel(title: "Enter Your Nano Address", font: UIFont.MontserratLight(size: 15))
        addLabel.numberOfLines = 0
        addTextField = createTextField(placeHolder: "nano_sfjlsdfisdlfjsljfls")
        descriptionLabel = createLabel(title: "This is the address where you would like to have your nano sent. It takes us up to 24 hours to send you your coin rewards since we currently have to manually send out the rewards.", font: UIFont.MontserratThin(size: 12))
    }
    
    private func setUpNextButton(){
        nextButton = SpinningWithGradButton()
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("→", for: .normal)
        let dimenssion = 45
        nextButton.layer.cornerRadius = CGFloat(dimenssion / 2)
        nextButton.clipsToBounds = true
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(dimenssion)
        }
    }
    
    private func createLabel(title: String,font: UIFont) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .jaguarBlack
        label.font = font
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
