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
        layer.cornerRadius = frame.size.height / 2
        
        color1 = hexStringToUIColor(hex: "FF2474")
        color2 = hexStringToUIColor(hex: "FF7910")
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
