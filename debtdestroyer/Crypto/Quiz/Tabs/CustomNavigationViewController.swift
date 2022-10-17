//
//  CustomNavigationViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/10/22.
//

import UIKit

class CustomNavigationViewController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
