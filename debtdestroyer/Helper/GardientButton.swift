//
//  GardientButton.swift
//  nbawidget
//
//  Created by Rashmi Aher on 27/07/22.
//

import UIKit

class GradientBtn: UIButton {
    
    let gradientLayer = CAGradientLayer()
    var color1 = UIColor()
    var color2 = UIColor()
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
//        layer.shadowOffset = CGSize.zero
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOpacity = 1.0
        
        //rounded corners
        layer.cornerRadius = frame.size.height / 2
        
        color1 = hexStringToUIColor(hex: "FF2474")
        color2 = hexStringToUIColor(hex: "FF7910")
        //gradient
//        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = gradientLayer.frame.height / 2
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        
//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}

