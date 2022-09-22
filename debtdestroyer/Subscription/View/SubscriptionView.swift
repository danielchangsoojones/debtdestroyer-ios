//
//  SubscriptionView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 03/09/22.
//

import UIKit

class SubscriptionView: UIView {

    let cell1 = SubcsriptionBasicView()
    let cell2 = SubscriptionCurrentView()
    let cell3 = SubscriptionDiamondView()
    let suggestedLbl = UILabel()
    let upgradeBtn = SpinningWithGradButton()

    let mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let scrollView = UIScrollView()
    let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setScrollView()
        setMainStackView()
        setSuggestedLbl()
        setUpgradeBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
            make.height.equalTo(650)
        }
    }
    
    private func setMainStackView() {
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints{ make in
            make.top.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView)
            make.height.equalTo(400)
            
        }
        
        mainStackView.addArrangedSubview(cell1)
        cell1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(110)
        }
        mainStackView.addArrangedSubview(cell2)
        cell2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo((self.frame.width - 130) * 0.5)
        }
        mainStackView.addArrangedSubview(cell3)
        cell3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo((self.frame.width - 130) * 0.5)
        }
    }
    
    func setSuggestedLbl() {
        suggestedLbl.text = "Suggested"
        suggestedLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        suggestedLbl.textAlignment = .center
        suggestedLbl.backgroundColor = .clear
        contentView.addSubview(suggestedLbl)
        suggestedLbl.snp.makeConstraints { make in
            make.bottom.equalTo(mainStackView.snp.top).inset(-5)
            make.trailing.equalTo(contentView)
            make.width.equalTo((self.frame.width - 130) * 0.5)
        }
    }
    
    func setUpgradeBtn() {
        upgradeBtn.setTitle("Upgrade to Diamond", for: .normal)
        upgradeBtn.layer.cornerRadius =  8
        upgradeBtn.clipsToBounds = true
        upgradeBtn.backgroundColor = .clear
        contentView.addSubview(upgradeBtn)
        upgradeBtn.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(mainStackView.snp.bottom).offset(50)
//            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
