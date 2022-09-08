//
//  DeleteAccountView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 17/08/22.
//

import UIKit

class DeleteAccountView: UIView {

    var color1 = UIColor()
    let infoLabel = UILabel()
    let deleteAccButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        color1 = hexStringToUIColor(hex: "EB4D3D")
        setInfoLabel()
        setDeleteAccountButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setInfoLabel() {
        infoLabel.text = "Are you sure that you want to delete your account? Deleting your account takes up to 48 hours. THIS ACTION CAN NOT BE UNDONE. Our support team will manually delete your account and data. You may submit an account deletion request below, and our team will email you once your account has been officially deleted."
        infoLabel.textAlignment = .center
        infoLabel.textColor = color1
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.numberOfLines = 0
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(100)            
        }
    }
    
    private func setDeleteAccountButton() {
        deleteAccButton.setTitle("SEND DELETE ACCOUNT REQUEST", for: .normal)
        deleteAccButton.backgroundColor = color1
        deleteAccButton.setTitleColor(.white, for: .normal)
        deleteAccButton.layer.cornerRadius = 8
        deleteAccButton.titleLabel?.adjustsFontSizeToFitWidth = true
        let spacing: CGFloat = 8.0
        deleteAccButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        let dimenssion = 50
        addSubview(deleteAccButton)
        deleteAccButton.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(infoLabel.snp.bottom).offset(40)
            make.height.equalTo(dimenssion)
            
        }
        
    }
}
