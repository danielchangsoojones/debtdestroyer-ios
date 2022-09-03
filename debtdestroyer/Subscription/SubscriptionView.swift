//
//  SubscriptionView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 03/09/22.
//

import UIKit

class SubscriptionView: UIView {

    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    

}
