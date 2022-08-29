//
//  SubscriptionView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/08/22.
//

import UIKit

class SubscriptionView: UIView {

    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .systemGray6
        
        return stack
    }()
    
    
    private func setStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.frame.width).multipliedBy(1.5)
        }


    }


}
