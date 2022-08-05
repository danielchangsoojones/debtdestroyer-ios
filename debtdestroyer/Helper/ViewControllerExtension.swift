//
//  ViewControllerExtension.swift
//  nbawidget
//
//  Created by Rashmi Aher on 20/07/22.
//

import UIKit
// I (Rashmi Aher added this extension)
extension UIViewController {
    // added top bar height prperty to get height of navigation bar
    var topbarHeight: CGFloat {
       
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
        (navigationController?.navigationBar.frame.height ?? 0.0)
        return navBarHeight
    }
    
    // added this func for hide keyboard
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
