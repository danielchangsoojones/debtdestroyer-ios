//
//  SubscriptionViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/08/22.
//

import UIKit
import SCLAlertView
import StoreKit

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
    var upgradeBtn = SpinningWithGradButton()
    var dataStore = SubscriptionDataStore()
    var ticketsInfo = UIButton()
    var emailNewsLetterInfo = UIButton()
    var loanConnectionsInfo = UIButton()
    var priceInfo = UIButton()
    
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
    var activityIndicator = UIActivityIndicatorView()
    var viewModel = ViewModel()

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
        self.upgradeBtn = subscriptionView.upgradeBtn
        self.priceInfo = subscriptionView.cell1.priceInfo
        self.ticketsInfo = subscriptionView.cell1.ticketsInfo
        self.loanConnectionsInfo = subscriptionView.cell1.loanConnectionsInfo
        self.emailNewsLetterInfo = subscriptionView.cell1.emailNewsLetterInfo
        setNavBarBtns()
        
        self.upgradeBtn.addTarget(self, action: #selector(upgradeToPremiumSubscription), for: .touchUpInside)
        
        self.ticketsInfo.addTarget(self, action: #selector(ticktsInfoBtnClicked), for: .touchUpInside)
        
        self.priceInfo.addTarget(self, action: #selector(priceInfoBtnClicked), for: .touchUpInside)
        
        self.loanConnectionsInfo.addTarget(self, action: #selector(loanConnectionsInfoBtnClicked), for: .touchUpInside)
        
        self.emailNewsLetterInfo.addTarget(self, action: #selector(emailNewsLetterInfoBtnClicked), for: .touchUpInside)
        
        viewModel.delegate = self
        
         activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
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

        // Notify the ViewModel object that the View part is ready.
        viewModel.viewDidSetup()
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
        self.showAlertTicktsInfo()
    }
    
    @objc private func priceInfoBtnClicked() {
        print("priceInfoBtnClicked")
        self.showAlertPriceInfo()
    }
    
    @objc private func loanConnectionsInfoBtnClicked() {
        print("loanConnectionsInfoBtnClicked")
        self.showAlertLoanConnectionsInfo()
    }
    
    @objc private func emailNewsLetterInfoBtnClicked() {
        print("emailNewsLetterInfoBtnClicked")
        self.showAlertEmailNewsLetterInfo()
    }
    
    private func showAlertTicktsInfo() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            print("hello")
        })
        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
    
    private func showAlertPriceInfo() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            print("hello")
        })
        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
    
    private func showAlertLoanConnectionsInfo() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            print("hello")
        })
        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
    
    private func showAlertEmailNewsLetterInfo() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            print("hello")
        })
        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
    
    @objc private func upgradeToPremiumSubscription() {
        
        guard let product = viewModel.getProductForItem(at: 0) else {
            showSingleAlert(withMessage: "Renewing this item is not possible at the moment.")
            activityIndicator.stopAnimating()
            return
        }
        activityIndicator.stopAnimating()

        showAlert(for: product)
        
//        self.dataStore.upgradeToPremiumSubscription { result, error in
//            if result != nil {
//               
//            } else {
//                BannerAlert.show(with: error)
//            }
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }
    
    func showSingleAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Subscription Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(for product: SKProduct) {
        guard let price = IAPManager.shared.getPriceFormatted(for: product) else { return }
        
        let alertController = UIAlertController(title: product.localizedTitle,
                                                message: product.localizedDescription,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Buy now for \(price)", style: .default, handler: { (_) in
            
            if !self.viewModel.purchase(product: product) {
                self.showSingleAlert(withMessage: "In-App Purchases are not allowed in this device.")
                self.activityIndicator.stopAnimating()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.activityIndicator.stopAnimating()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

// MARK: - ViewModelDelegate
extension SubscriptionViewController: ViewModelDelegate {
    func willStartLongProcess() {
        activityIndicator.startAnimating()
    }
    
    func didFinishLongProcess() {
        activityIndicator.stopAnimating()
    }
    
    
    func showIAPRelatedError(_ error: Error) {
        let message = error.localizedDescription
        showSingleAlert(withMessage: message)
    }
    
    
    func shouldUpdateUI() {
//        tableView.reloadData()
        // ToDoMark: - update UI for success manege here

    }
    
    
    func didFinishRestoringPurchasesWithZeroProducts() {
        showSingleAlert(withMessage: "There are no purchased items to restore.")
    }
    
    
    func didFinishRestoringPurchasedProducts() {
        showSingleAlert(withMessage: "All previous In-App Purchases have been restored!")
    }
}
