//
//  IAPManager.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/09/22.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    // MARK: - Custom Types
    enum IAPManagerError: Error {
        case noProductIDsFound
        case noProductsFound
        case paymentWasCancelled
        case productRequestFailed
    }

    static let shared = IAPManager()
    
    var onReceiveProductsHandler: ((Result<[SKProduct], IAPManagerError>) -> Void)?
    
    var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
    
    var totalRestoredPurchases = 0

    private override init() {
        super.init()
    }
    
    // MARK: - General Methods
    fileprivate func getProductIDs() -> [String]? {
        guard let url = Bundle.main.url(forResource: "IAP_ProductIDs", withExtension: "plist") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let productIDs = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String] ?? []
            return productIDs
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func getPriceFormatted(for product: SKProduct) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)
    }
    
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    
    // MARK: - Get IAP Products
    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], IAPManagerError>) -> Void) {
        onReceiveProductsHandler = productsReceiveHandler
        
        guard let productIDs = getProductIDs() else {
            productsReceiveHandler(.failure(.noProductIDsFound))
            return
        }
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        
        request.delegate = self
        request.start()
    }
    
    // MARK: - Purchase Products
    func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        // Keep the completion handler.
        onBuyProductHandler = handler
    }
    
    func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        onBuyProductHandler = handler
        totalRestoredPurchases = 0
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}

// MARK: - SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
                case .purchased:
                    complete(transaction: transaction)
                case .restored:
                  restore(transaction: transaction)
                case .failed:
                  fail(transaction: transaction)

                case .deferred, .purchasing: break
                @unknown default: break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        onBuyProductHandler?(.success(true))
        SKPaymentQueue.default().finishTransaction(transaction)
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)

    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        print("restore... \(productIdentifier)")
        totalRestoredPurchases += 1
        SKPaymentQueue.default().finishTransaction(transaction)
        deliverPurchaseNotificationFor(identifier: productIdentifier)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        if let error = transaction.error as? SKError {
            if error.code != .paymentCancelled {
                onBuyProductHandler?(.failure(error))
            } else {
                onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
            }
            print("IAP Error:", error.localizedDescription)
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if totalRestoredPurchases != 0 {
            onBuyProductHandler?(.success(true))
        } else {
            print("IAP: No purchases to restore!")
            onBuyProductHandler?(.success(false))
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError {
            if error.code != .paymentCancelled {
                print("IAP Restore Error:", error.localizedDescription)
                onBuyProductHandler?(.failure(error))
            } else {
                onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
      
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // Get the available products contained in the response.
        let products = response.products
        
        // Check if there are any products available.
        if products.count > 0 {
            // Call the following handler passing the received products.
            onReceiveProductsHandler?(.success(products))
        } else {
            // No products were found.
            onReceiveProductsHandler?(.failure(.noProductsFound))
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        onReceiveProductsHandler?(.failure(.productRequestFailed))
    }
    
    func requestDidFinish(_ request: SKRequest) {
        // Implement this method OPTIONALLY and add any custom logic
        // you want to apply when a product request is finished.
    }
}

// MARK: - IAPManagerError Localized Error Descriptions
extension IAPManager.IAPManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
            case .noProductsFound: return "No In-App Purchases were found."
            case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
            case .paymentWasCancelled: return "In-App Purchase process was cancelled."
        }
    }
}