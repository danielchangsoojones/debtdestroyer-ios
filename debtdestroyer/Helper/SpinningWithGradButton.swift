//
//  SpinningWithGradButton.swift
//  nbawidget
//
//  Created by Rashmi Aher on 27/07/22.
//

import UIKit

class SpinningWithGradButton: UIButton {
    private let spinner = UIActivityIndicatorView()
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSpinner()
        setGradient()
//        setTitle("", for: .disabled)
//        setTitleColor(.white, for: .normal)
        
        setOriginalInsets()
    }
    
    private func setOriginalInsets() {
        let edgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        set(edgeInsets: edgeInsets)
    }
    
    private func set(edgeInsets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            var filled = UIButton.Configuration.plain()
            filled.contentInsets = NSDirectionalEdgeInsets(top: edgeInsets.top,
                                                           leading: edgeInsets.left,
                                                           bottom: edgeInsets.bottom,
                                                           trailing: edgeInsets.right)
            configuration = filled
        } else {
            contentEdgeInsets = edgeInsets
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinning() {
        set(edgeInsets: UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50))
        spinner.startAnimating()
        isEnabled = false
    }
    
    func stopSpinning() {
        setOriginalInsets()
        spinner.stopAnimating()
        isEnabled = true
    }
    
    private func setSpinner() {
        spinner.color = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
    
    func setGradient() {
        //shadow
        //        layer.shadowOffset = CGSize.zero
        //        layer.shadowColor = UIColor.gray.cgColor
        //        layer.shadowOpacity = 1.0
        
        //gradient
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.8)
        gradientLayer.frame = bounds
        //rounded corners
//        gradientLayer.cornerRadius = gradientLayer.frame.height / 2
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = gradientLayer.frame.height / 2

    }
}

