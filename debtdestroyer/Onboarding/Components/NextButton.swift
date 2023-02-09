import UIKit

class NextButton: UIButton {
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
    
    func startSpinning() {
        //TODO
    }
    
    func stopSpinning() {
        //TODO
    }
    
    private func themeConfig() {
        layer.cornerRadius = frame.size.height / 2
        
        color1 = hexStringToUIColor(hex: "FF2474")
        color2 = hexStringToUIColor(hex: "FF7910")
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
        if #available(iOS 15.0, *) {
            if self.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Continue", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
                self.configuration = configuration
                
            } else {
                self.configuration?.attributedTitle = AttributedString("Continue", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            self.setTitleColor(.white, for: .normal)
            self.setTitle("Continue", for: .normal)
        }
        self.layer.cornerRadius = globalCornerRadius
        self.clipsToBounds = true
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        self.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
