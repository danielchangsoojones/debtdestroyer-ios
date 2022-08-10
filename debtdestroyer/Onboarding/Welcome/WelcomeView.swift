//
//  WelcomeView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class WelcomeView: UIView {
    
    var loginBtn = UIButton()
    private var stackView: UIStackView!
    private var logInView: UIView!
    var logInButton: UIButton!
    var registerButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addLogInView()
        addButtons()
        addLogo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLogInView() {
        logInView = UIView()
        logInView.backgroundColor = .white
        addSubview(logInView)
        logInView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView = UIStackView()
        stackView.spacing = 9
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        logInView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(40)
            make.top.equalTo(logInView.snp.top).inset(20)
        }
    }

    
    private func addButtons() {
        logInButton = createButton(image: "logIn")
        registerButton = createButton(image: "signUp")
        stackView.addArrangedSubview(logInButton)
        logInButton.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
        stackView.addArrangedSubview(registerButton)
        registerButton.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
    }
    
    private func createButton(image: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: image), for: .normal)
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        return button
    }
    
//    func setupLoginBtn(){
//       // loginBtn = UIButton()
// loginBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
//
//        let color1 = hexStringToUIColor(hex: "FF2474")
//        let color2 = hexStringToUIColor(hex: "FF7910")
//
//        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: .zero, size: loginBtn.frame.size)
//        gradient.colors = [color1.cgColor, color2.cgColor]
//        let shape = CAShapeLayer()
//        shape.lineWidth = 3
//        shape.path = UIBezierPath(rect: loginBtn.bounds).cgPath
//        shape.strokeColor = UIColor.black.cgColor
//        shape.fillColor = UIColor.clear.cgColor
//        gradient.mask = shape
//        loginBtn.layer.addSublayer(gradient)
//
//        loginBtn.setTitle("Log In", for: .normal)
//        loginBtn.setTitleColor(.black, for: .normal)
//        loginBtn.clipsToBounds = true
//
//        addSubview(loginBtn)
////        loginBtn.snp.makeConstraints { (make) in
////            make.leading.trailing.equalToSuperview().inset(20)
////            make.bottom.equalToSuperview().offset(-40)
////        }
//
//
//    }
    
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

    
    private func addLogo() {

        let logoImageView = UIImageView()
        if let logoImage = UIImage(named: "logo") {
            logoImageView.image = logoImage
            logoImageView.contentMode = .scaleAspectFit
            addSubview(logoImageView)
            logoImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
//                make.leading.trailing.equalToSuperview().inset(50)
                make.width.equalTo(self.frame.width * 0.5 )
            }
        }
    }
    
}
extension UIView{
    
    func gradientButton(_ buttonText:String, startColor:UIColor, endColor:UIColor) {
        
        let button:UIButton = UIButton(frame: self.bounds)
        button.setTitle(buttonText, for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        self.mask = button
        
        button.layer.cornerRadius =  button.frame.size.height / 2
        button.layer.borderWidth = 5.0
    }
}
