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
    let champPointsLabel = UILabel()
    let numberTagLabel = UILabel()
    let containerView = UIView()
    let leaderboardTableView = UITableView()
    let numberLabel = UILabel()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()
    let imgView = UIImageView()
    let bottomViewContainer = UIView()
    let bottomView = MyRoundBottomView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradientBackground()
        setBottomViewContainer()
        setBottomView()
        setContainerView()
        setTableView()
        setTitleLabel()
        setDescriptionLabel()
        setChampImgView()
        setNumberTagLabel()
        setChampNameLabel()
        setChampPointsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Current Leading Score"
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
    
    private func setChampNameLabel() {
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
    
    private func setNumberTagLabel() {
        numberTagLabel.text = "1"
        numberTagLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        numberTagLabel.textColor = .white
        numberTagLabel.textAlignment = .center
        numberTagLabel.backgroundColor = .fuchsiaPink
        numberTagLabel.layer.cornerRadius = 12.5
        numberTagLabel.layer.masksToBounds = true

        addSubview(numberTagLabel)
        numberTagLabel.snp.makeConstraints { make in
            make.top.equalTo(champImgView.snp.top).inset(8)
            make.trailing.equalTo(champImgView.snp.trailing).inset(8)
            make.height.width.equalTo(25)
        }
    }
    
    private func setChampPointsLabel() {
        champPointsLabel.text = " 0 Points "
        champPointsLabel.textColor = .white
        champPointsLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        champPointsLabel.textAlignment = .center
        champPointsLabel.layer.borderColor = UIColor.white.cgColor
        champPointsLabel.layer.borderWidth = 1
        champPointsLabel.layer.cornerRadius = 15
        let dimenssion = 30
        addSubview(champPointsLabel)
        champPointsLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(champNameLabel.snp.bottom).offset(10)
        }
    }
    
    private func setContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(375)
            make.bottom.equalTo(bottomViewContainer.snp.top)
        }
    }
    
    private func setBottomViewContainer() {
        bottomViewContainer.backgroundColor = .white
        addSubview(bottomViewContainer)
        bottomViewContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.bottomMargin.equalToSuperview().offset(-10)
        }
    }
    
    private func setBottomView() {
        bottomView.backgroundColor = .fuchsiaPink
//        let circlePath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize.init(width: bounds.size.width/3, height: bounds.size.width/6))
//        let circleShape = CAShapeLayer()
//        circleShape.path = circlePath.cgPath
//        bottomView.layer.mask = circleShape
        
        bottomViewContainer.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setImgView()
        setConstraints()
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(imgView)
            make.width.equalTo(15)
        }
        
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(50)
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(imgView)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(5)
            make.width.lessThanOrEqualToSuperview()
            make.centerY.equalTo(imgView)

        }
        
        
    }
    
    private func setNumLabel() {
        numberLabel.text = "23"
        numberLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        numberLabel.textColor = .black
        bottomView.addSubview(numberLabel)
    }
    
    private func setImgView() {
        imgView.backgroundColor = .coinbaseBlue
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        bottomView.addSubview(imgView)
    }
    
    private func setNameLabel() {
        nameLabel.text = "test"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        nameLabel.textColor = .black
        bottomView.addSubview(nameLabel)
    }
    
    private func setPointsLabel() {
        pointsLabel.text = "12 Points"
        pointsLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
        pointsLabel.layer.borderColor = UIColor.darkGray.cgColor
        pointsLabel.layer.borderWidth = 0.5
        pointsLabel.layer.cornerRadius = 15
        bottomView.addSubview(pointsLabel)
    }
    
    private func setTableView() {
        containerView.addSubview(leaderboardTableView)
        leaderboardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
