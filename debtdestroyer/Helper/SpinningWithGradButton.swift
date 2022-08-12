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
    var color1 = UIColor()
    var color2 = UIColor()
    var customImage : UIImage? {
        didSet {
            updateImageView()
        }
    }
    let customImageView = UIImageView()
    
    convenience init(image: UIImage) {
        self.init()
    
        customImage = image
        updateImageView()
        
        setSpinner()
        setGradient()
        setTitleColor(.white, for: .normal)
        setOriginalInsets()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSpinner()
        setGradient()
        setTitleColor(.white, for: .normal)
        
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
        color1 = hexStringToUIColor(hex: "FF2474")
        color2 = hexStringToUIColor(hex: "FF7910")
        //gradient
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.8)
        gradientLayer.frame = bounds
     
        layer.insertSublayer(gradientLayer, at: 0)
        layer.layoutIfNeeded()
        
        addSubview(customImageView)
        customImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customImageView.contentMode = .scaleAspectFit

    }
    
    func updateImageView() {
        customImageView.image = customImage
        customImageView.image = customImageView.image?.withRenderingMode(.alwaysTemplate)
        customImageView.tintColor = UIColor.white
        customImageView.alpha = 0.2
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}

