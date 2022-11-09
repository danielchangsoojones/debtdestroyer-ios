//
//  BestChampionsView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class ChampionsView: UIView {
   
//    let descriptionLabel = UILabel()
//    let titleLabel = UILabel()
    let containerView = UIView()
    let leaderboardTableView = UITableView()
    let numberLabel = UILabel()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()
    let timeLable = UILabel()
    let bottomViewContainer = UIView()
    let bottomView = UIView()
    var toggleSegment = HBSegmentedControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradientBackground()
        setSegmentedSwitch()
        setContainerView()
        setTableView()
        setBottomViewContainer()
        setBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toggleSegment.layer.cornerRadius = 20
        toggleSegment.layer.masksToBounds = true
        toggleSegment.clipsToBounds = true
    }
    
    private func setSegmentedSwitch() {
        let items = ["Leaderboard", "Past Winners"]
        toggleSegment.items = items
        toggleSegment.font = UIFont.MontserratSemiBold(size: 14)
        toggleSegment.borderColor = UIColor(white: 1.0, alpha: 0.3)
        toggleSegment.selectedIndex = 0
        toggleSegment.padding = 1
        toggleSegment.backgroundColor = .systemGray4
        toggleSegment.selectedLabelColor = .black
        toggleSegment.unselectedLabelColor = .black
        
        addSubview(toggleSegment)
        toggleSegment.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(100)
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
            make.top.equalTo(toggleSegment.snp.bottom).offset(15)
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
