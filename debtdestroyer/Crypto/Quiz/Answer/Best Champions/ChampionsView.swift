//
//  BestChampionsView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class ChampionsView: UIView {
   
    let descriptionLabel = UILabel()
    let titleLabel = UILabel()
    let champImgView = UIImageView()
    let champNameLabel = UILabel()
    let pointsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradientBackground()
        setTitleLabel()
        setDescriptionLabel()
        setChampImgView()
        setNameLabel()
        setpointsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Best Champions"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.text = "The winner will be announced at 12pm PT."
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setChampImgView() {
        champImgView.image = UIImage.init(systemName: "person.circle")?.withRenderingMode(.alwaysTemplate)
        champImgView.tintColor = .darkGray
        champImgView.contentMode = .scaleAspectFill
        let dimenssion = 100
        champImgView.layer.cornerRadius = CGFloat(dimenssion / 2)
        addSubview(champImgView)
        champImgView.snp.makeConstraints { make in
            make.height.width.equalTo(dimenssion)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setNameLabel() {
        champNameLabel.text = "Anny Maxwell"
        champNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        champNameLabel.textColor = .white
        champNameLabel.textAlignment = .center
        champNameLabel.backgroundColor = .clear
        champNameLabel.numberOfLines = 0
        addSubview(champNameLabel)
        champNameLabel.snp.makeConstraints { make in
            make.top.equalTo(champImgView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setpointsLabel() {
        pointsLabel.text = " 6 Points "
        pointsLabel.textColor = .white
        pointsLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        pointsLabel.textAlignment = .center
        pointsLabel.layer.borderColor = UIColor.white.cgColor
        pointsLabel.layer.borderWidth = 1
        pointsLabel.layer.cornerRadius = 15
        let dimenssion = 30
        addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(champNameLabel.snp.bottom).offset(10)
        }
    }


}
