//
//  GardientButton.swift
//  nbawidget
//
//  Created by Rashmi Aher on 27/07/22.
//

import UIKit

class GradientBtn: UIButton {
    
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        themeConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        themeConfig()
    }
    
    private func themeConfig() {
        //shadow
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1.0
        
        //rounded corners
        layer.cornerRadius = frame.size.height / 2
        
        //gradient
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.fuchsiaPink.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}

