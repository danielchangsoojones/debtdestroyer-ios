//
//  GalleryCollectionViewCell.swift
//  nbawidget
//
//  Created by Rashmi Aher on 22/07/22.
//

import UIKit
import Reusable

class GalleryCollectionViewCell: UICollectionViewCell, Reusable{
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgView = UIImageView(frame: self.bounds.inset(by: .init(top: 2, left: 2, bottom: 2, right: 2)))
        imgView.backgroundColor = .systemGray6
        imgView.layer.cornerRadius = 8
        contentView.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
            imgView.layer.cornerRadius = 8
        }
    }
}

