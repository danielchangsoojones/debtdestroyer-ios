//
//  PromoCodeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit

class PromoCodeViewController: UIViewController {
    var titleLbl = UILabel()
    var promoCodeUsedCountLbl = UILabel()
    private let cryptoSettingsDataStore = CryptoSettingsDataStore()
    
    override func loadView() {
        super.loadView()
        let promoCodeView = PromoCodeView(frame: self.view.frame)
        self.view = promoCodeView
        self.titleLbl = promoCodeView.titleLbl
        self.promoCodeUsedCountLbl = promoCodeView.promoCodeUsedCountLbl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        setNavBarBtns()
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
    
    private func LoadData() {
        cryptoSettingsDataStore.getPromoCodeRightAnswers(promoCode: "") { result in
            print(result as Any)
        }
    }
}
