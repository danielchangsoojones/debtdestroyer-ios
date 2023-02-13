//
//  Structs.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import BRYXBanner

class BannerAlert {
    enum BannerType {
        case success
        case error
        case info
    }
    
    static func show(title: String, subtitle: String, type: BannerType, duration: TimeInterval = 5) {
        var backgroundColor: UIColor = UIColor.red
        switch type {
        case .error:
            backgroundColor = UIColor.red
        case .success:
            backgroundColor = UIColor.systemGreen
        case .info:
            backgroundColor = .purple
        }
        
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: backgroundColor)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
    }
    
    static func show(with error: Error?) {
        if let error = error {
            BannerAlert.show(title: "Error", subtitle: error.localizedDescription, type: .error)
        }
    }
    
    static func showUnknownError(functionName: String) {
        BannerAlert.show(title: "Error", subtitle: "There was an error using the \(functionName). Please contact the Ohana team at (317) 690 - 5323 to fix this.", type: .error)
    }
}

struct Helpers {
    static func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }
    
    static func open(urlString: String) {
        guard let url = URL(string: urlString) else {
            BannerAlert.show(title: "Error", subtitle: "Could not open \(urlString)", type: .error)
            return
        }
        UIApplication.shared.open(url)
    }
    
    static func showActivityIndicatory(in uiView: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 64/256, green: 64/256, blue: 64/256, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style =
            UIActivityIndicatorView.Style.large
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return container
    }
    
//    static func openHighlightSubmission(from currentVC: UIViewController, communityID: String) {
//        let submitVC = UploadViewController(communityID: communityID)
//        currentVC.navigationController?.pushViewController(submitVC, animated: true)
//    }
    
    static func getVersionStr() -> String? {
        let version_str = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version_str
    }
    
    static func getAppDisplayNameStr() -> String? {
        let appDisplayNameStr = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return appDisplayNameStr
    }
}
