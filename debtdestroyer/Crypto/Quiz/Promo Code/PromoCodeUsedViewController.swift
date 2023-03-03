//
//  PromoCodeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeUsedViewController: UIViewController {
    var titleLbl = UILabel()
    var promoCodeUsedCountLbl = UILabel()
    
    override func loadView() {
        super.loadView()
        let promoCodeView = PromoCodeUsedView(frame: self.view.frame)
        self.view = promoCodeView
        self.titleLbl = promoCodeView.titleLbl
        self.promoCodeUsedCountLbl = promoCodeView.promoCodeUsedCountLbl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
