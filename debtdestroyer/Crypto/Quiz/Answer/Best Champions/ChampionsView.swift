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
    let containerView = UIView()
    let leaderboardTableView = UITableView()
    let numberLabel = UILabel()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()
    let timeLable = UILabel()
    let bottomViewContainer = UIView()
    let bottomView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradientBackground()
        setContainerView()
        setTableView()
        setBottomViewContainer()
        setBottomView()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Current Leading Score"
        titleLabel.font = UIFont.MontserratBold(size: 30)
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
        descriptionLabel.font = UIFont.MontserratRegular(size: 14)
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

    private func setContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(180)
            make.bottom.equalToSuperview().offset(-95)
        }
    }
    
    private func setBottomViewContainer() {
        bottomViewContainer.backgroundColor = .clear
        addSubview(bottomViewContainer)
        bottomViewContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
            make.bottomMargin.equalToSuperview().offset(-10)
        }
    }
    
    private func setBottomView() {
        bottomView.backgroundColor = .clear
        bottomView.setTopCurve()
        bottomViewContainer.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        setNumLabel()
        setNameLabel()
        setPointsLabel()
        setTimeLabel()
        setConstraints()
    }
    
    private func setConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(15)
        }
        
        timeLable.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(timeLable.snp.leading).inset(10)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(5)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(40)

        }
    }
    
    private func setNumLabel() {
        numberLabel.text = "23"
        numberLabel.font = UIFont.MontserratLight(size: 10)
        numberLabel.textColor = .black
        bottomView.addSubview(numberLabel)
    }
    
    private func setTimeLabel() {
        timeLable.text = "2.23"
        timeLable.font = UIFont.MontserratLight(size: 13)
        timeLable.textColor = .black
        timeLable.textAlignment = .center

        bottomView.addSubview(timeLable)
    }
    
    private func setNameLabel() {
        nameLabel.text = "test"
        nameLabel.font = UIFont.MontserratMedium(size: 15)
        nameLabel.textColor = .black
        bottomView.addSubview(nameLabel)
    }
    
    private func setPointsLabel() {
        pointsLabel.text = "12"
        pointsLabel.font = UIFont.MontserratLight(size: 13)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
        bottomView.addSubview(pointsLabel)
    }
    
    private func setTableView() {
        containerView.addSubview(leaderboardTableView)
        leaderboardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
