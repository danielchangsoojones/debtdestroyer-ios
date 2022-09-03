//
//  SubscriptionViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/08/22.
//

import UIKit

class SubscriptionViewController: UIViewController {
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        self.navigationItem.title = "Subscription"
        self.navigationController?.navigationBar.tintColor = .black
        self.view.backgroundColor = .white
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
    
    private func setupCollectionView(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: SubcsriptionCell.self)
        collectionView.register(cellType: SubscriptionCurrentCell.self)
        collectionView.register(cellType: SubscriptionDiamondCell.self)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo((self.view.frame.width) * 1.5)
//            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func ticktsInfoBtnClicked() {
        print("ticktsInfoBtnClicked")
    }
}

extension SubscriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubcsriptionCell.self)
            
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubscriptionCurrentCell.self)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubscriptionDiamondCell.self)
//            let gradientLabel = cell.getGradientLayer(bounds: cell.priceLbl.bounds)
//            cell.priceLbl.textColor = cell.gradientColor(bounds: cell.priceLbl.bounds, gradientLayer: gradientLabel)
            return cell
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubcsriptionCell.self)

        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubscriptionCurrentCell.self)

        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SubscriptionDiamondCell.self)
            let gradientLabel = cell.getGradientLayer(bounds: cell.priceLbl.bounds)
            cell.priceLbl.textColor = cell.gradientColor(bounds: cell.priceLbl.bounds, gradientLayer: gradientLabel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 110, height: (self.view.frame.width) * 1.5)
        } else {
            return CGSize(width: (self.view.frame.width - 120) * 0.5, height: (self.view.frame.width) * 1.5)
        }
    }
    
}
