//
//  PastWinnerTableViewCell.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit
import Reusable

class PastWinnerTableViewCell: UITableViewCell, Reusable {
    var collectionView: UICollectionView!
    var winnerContent: [WinnerInfo]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.contentView.frame.width,
                           height: self.contentView.frame.height)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .black
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: PastWinnerCollectionTableViewCell.self)
    }
    
}

extension PastWinnerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func updateCellWith(row: [WinnerInfo]) {
        self.winnerContent = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.winnerContent?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PastWinnerCollectionTableViewCell.self)
        if let winner = winnerContent?[indexPath.row] {
            let name = winner.user.fullName
            let amountWon = self.numberToDollar(amount: winner.prizeWon)
            let image = winner.user.objectId == "KlcsxyBBZb" ? UIImage(named: "winner_img") : nil
            cell.set(name: name, amountWon: amountWon, winnerImage: image)
        }
        
        return cell
    }
    
    //TODO: make the cells clickable so that we show a video of the winner prize (esp for the $15k winner)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //TODO: hardcoded but should be sized dynamically 
        let width: CGFloat = 160
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func numberToDollar(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let formattedAmount = formatter.string(from: NSNumber(value: amount)) ?? "$\(Int(amount))"
        return formattedAmount
    }
}
