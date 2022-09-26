//
//  ViewModel.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/09/22.
//

import Foundation
import StoreKit

protocol ViewModelDelegate {
    func willStartLongProcess()
    func didFinishLongProcess()
    func showIAPRelatedError(_ error: Error)
    func shouldUpdateUI()
    func didFinishRestoringPurchasesWithZeroProducts()
    func didFinishRestoringPurchasedProducts()
}

class ViewModel {
    var delegate: ViewModelDelegate?
    
    private let model = Model()
    
    var didUnlockDiamondSubscription: Bool {
        return model.subscriptionData.didUnlockDiamondSubscription
    }

    init() {

    }

    fileprivate func updateSubscriptionDataWithPurchasedProduct(_ product: SKProduct) {
        if product.productIdentifier.contains("diamond_subscription") {
            model.subscriptionData.didUnlockDiamondSubscription = true
        }
        
        // Store changes.
        _ = model.subscriptionData.update()
        
        // Ask UI to be updated and reload the view.
        delegate?.shouldUpdateUI()
    }
    
    fileprivate func restoreUnlockedMaps() {
        model.subscriptionData.didUnlockDiamondSubscription = true
        
        // Save changes and update the UI.
        _ = model.subscriptionData.update()
        delegate?.shouldUpdateUI()
    }
    
    // MARK: - Internal Methods
    func getProductForItem(at index: Int) -> SKProduct? {
        let keyword: String
        
        switch index {
        case 0: keyword = "diamond_subscription"
        default: keyword = ""
        }
  
        guard let product = model.getProduct(containing: keyword) else { return nil }
        return product
    }
    
    // MARK: - Methods To Implement
    func viewDidSetup() {
        delegate?.willStartLongProcess()
        
        IAPManager.shared.getProducts { (result) in
            DispatchQueue.main.async {
                self.delegate?.didFinishLongProcess()
                
                switch result {
                    case .success(let products): self.model.products = products
                    case .failure(let error): self.delegate?.showIAPRelatedError(error)
                }
            }
        }
    }
    
    func purchase(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            return false
        } else {
//            delegate?.willStartLongProcess()
            
            IAPManager.shared.buy(product: product) { (result) in
                DispatchQueue.main.async {
                    self.delegate?.didFinishLongProcess()

                    switch result {
                    case .success(_): self.updateSubscriptionDataWithPurchasedProduct(product)
                    case .failure(let error): self.delegate?.showIAPRelatedError(error)
                    }
                }
            }
        }

        return true
    }
    
    func restorePurchases() {
        delegate?.willStartLongProcess()
        IAPManager.shared.restorePurchases { (result) in
            DispatchQueue.main.async {
                self.delegate?.didFinishLongProcess()

                switch result {
                case .success(let success):
                    if success {
                        self.restoreUnlockedMaps()
                        self.delegate?.didFinishRestoringPurchasedProducts()
                    } else {
                        self.delegate?.didFinishRestoringPurchasesWithZeroProducts()
                    }

                case .failure(let error): self.delegate?.showIAPRelatedError(error)
                }
            }
        }
    }
}
