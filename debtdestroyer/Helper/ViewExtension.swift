//
//  ViewExtension.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 12/08/22.
//

import Foundation
import UIKit

extension UIView {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func addDashBorder() {
        let color = UIColor.white.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 3
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 8).cgPath
        
        self.layer.masksToBounds = false
        
        self.layer.addSublayer(shapeLayer)
        
        //        How to remove border again
        //        let _ = vw.layer.sublayers?.filter({$0.name == "DashBorder"}).map({$0.removeFromSuperlayer()})
        
    }
    
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        gradientLayer.cornerRadius = 8
        self.layoutIfNeeded()
        gradientLayer.masksToBounds = true
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context )
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIColor(patternImage: image!)
        }
        return UIColor()
    }
    
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        clipsToBounds = true
        let color1 = hexStringToUIColor(hex: "FF2474")
        let color2 = hexStringToUIColor(hex: "FF7910")
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }
        
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        let color1 = hexStringToUIColor(hex: "FF2474")
        let color2 = hexStringToUIColor(hex: "FF7910")
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
