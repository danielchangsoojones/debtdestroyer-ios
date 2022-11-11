//
//  ConnectAccountsCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 27/10/22.
//

import UIKit
import Reusable

class ConnectAccountsCell: UITableViewCell, Reusable {
    let containerView = UIView()
    let titleLabel = UILabel()
    let connectAccBtn = SpinningWithGradButton()
    var color1 = UIColor()
    var color2 = UIColor()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        color1 = self.hexStringToUIColor(hex: "FF2474")
        color2 = self.hexStringToUIColor(hex: "FF7910")
        setContainerView()
        setTitleLabel()
        setconnectAccBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        
        containerView.layer.cornerRadius =  15
        containerView.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: containerView.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 15
        
        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:containerView.bounds, cornerRadius:15).cgPath
        border.frame = containerView.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = 1
        gradient.mask = border
        
        containerView.layer.addSublayer(gradient)
        
    }
    
    private func setContainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(WeekPrizeCell.Constants.horizontalContainerInset)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratSemiBold(size: 19)
        let txt = "Verify your student loan accounts to start earning tickets!"
        titleLabel.halfTextColorChange(fullText: txt, changeText: "to start earning tickets!", expectedColor: color2)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = color1
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setconnectAccBtn() {
        connectAccBtn.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if connectAccBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Verify Student Loans ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                connectAccBtn.configuration = configuration
                
            } else {
                connectAccBtn.configuration?.attributedTitle = AttributedString("Verify Student Loans ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            connectAccBtn.setTitleColor(.white, for: .normal)
            connectAccBtn.setTitle("Connect Accounts ➔", for: .normal)
        }
        let height: CGFloat = 55
        connectAccBtn.layer.cornerRadius = height/2
        connectAccBtn.layer.masksToBounds = true
        containerView.addSubview(connectAccBtn)
        connectAccBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
}
