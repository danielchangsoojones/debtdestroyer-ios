//
//  AnswerCollectionViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 05/12/22.
//

import UIKit
import Reusable

class AnswerCollectionViewCell: UICollectionViewCell, Reusable{
    var ansLabel = UILabel()
    let gifImgView = UIImageView()
    var progressBar = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setUpProgressBar()
        setLabel()
        setGifImage()
        
    }
    
    private func setLabel() {
        ansLabel.text = "option"
        ansLabel.numberOfLines = 0
        ansLabel.textColor = .black
        ansLabel.textAlignment = .center
        ansLabel.font = UIFont.MontserratSemiBold(size: 18)
        ansLabel.adjustsFontSizeToFitWidth = true
        addSubview(ansLabel)
        ansLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func setGifImage() {
        gifImgView.backgroundColor = .clear
        addSubview(gifImgView)
        gifImgView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
    }
    
    private func setUpProgressBar() {
        progressBar.trackTintColor = .clear
        progressBar.progress = 0.0
        progressBar.layer.cornerRadius = 8
        addSubview(progressBar)
        
        progressBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
            contentView.layer.cornerRadius = 8
        }
    }
}

