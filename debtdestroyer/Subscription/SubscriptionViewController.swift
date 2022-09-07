//
//  SubscriptionViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/08/22.
//

import UIKit

class SubscriptionViewController: UIViewController {
    var ticketsLbl = UILabel()
    var emailNewsLetterLbl = UILabel()
    var loanConnectionsLbl = UILabel()
    var priceLbl = UILabel()
    var subscriptionView = SubscriptionView()
    var background = UIView()
    var suggestedLbl = UILabel()

    let cell1 = SubcsriptionBasicView()
    let cell2 = SubscriptionCurrentView()
    let cell3 = SubscriptionDiamondView()
    let upgradeBtn = SpinningWithGradButton()
    
    let mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptionView = SubscriptionView(frame: self.view.bounds)
        self.view = subscriptionView
        self.navigationItem.title = "Subscription"
        self.navigationController?.navigationBar.tintColor = .black
        self.ticketsLbl = subscriptionView.cell3.ticketsLbl
        self.emailNewsLetterLbl = subscriptionView.cell3.emailNewsLetterLbl
        self.loanConnectionsLbl = subscriptionView.cell3.loanConnectionsLbl
        self.priceLbl = subscriptionView.cell3.priceLbl
        self.background = subscriptionView.cell3.background
        self.suggestedLbl = subscriptionView.suggestedLbl
        setNavBarBtns()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: background.frame.size)
        let color1 = hexStringToUIColor(hex: "FF2474")
        let color2 = hexStringToUIColor(hex: "FF7910")
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 8

        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:background.bounds, cornerRadius:8).cgPath
        border.frame = background.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = 2
        gradient.mask = border

        background.layer.addSublayer(gradient)

        let gradientLabel = view.getGradientLayer(bounds: suggestedLbl.bounds)
        suggestedLbl.textColor = view.gradientColor(bounds: suggestedLbl.bounds, gradientLayer: gradientLabel)

        let gradientLabel1 = view.getGradientLayer(bounds: ticketsLbl.bounds)
        ticketsLbl.textColor = view.gradientColor(bounds: ticketsLbl.bounds, gradientLayer: gradientLabel1)

        let gradientLabel2 = view.getGradientLayer(bounds: emailNewsLetterLbl.bounds)
        emailNewsLetterLbl.textColor = view.gradientColor(bounds: emailNewsLetterLbl.bounds, gradientLayer: gradientLabel2)

        let gradientLabel3 = view.getGradientLayer(bounds: loanConnectionsLbl.bounds)
        loanConnectionsLbl.textColor = view.gradientColor(bounds: loanConnectionsLbl.bounds, gradientLayer: gradientLabel3)

        let gradientLabel4 = view.getGradientLayer(bounds: priceLbl.bounds)
        priceLbl.textColor = view.gradientColor(bounds: priceLbl.bounds, gradientLayer: gradientLabel4)


    }
    
    private func setNavBarBtns() {
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func ticktsInfoBtnClicked() {
        print("ticktsInfoBtnClicked")
    }
    
}
