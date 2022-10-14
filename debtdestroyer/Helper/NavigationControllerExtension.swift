//
//  NavigationControllerExtension.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/10/22.
//

import UIKit
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .default
    }
    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
