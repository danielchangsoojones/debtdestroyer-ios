//
//  ScoreView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 20/10/22.
//

import UIKit

class ScoreView: UIView {
    private let yourScoreLbl = UILabel()
    let pointsLbl = UILabel()
    private let descriptionLbl = UILabel()
    let shareButton = GradientBtn()
    var skipButton: UIButton!
    private let containerViewForPointsLbl = UIView()
    private let imgView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setScoreLabel()
        setContainerViewForPointsLbl()
        setDescriptionLabel()
        setShareButton()
        setSkipButton()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScoreLabel() {
        yourScoreLbl.text = "Your Score"
        yourScoreLbl.numberOfLines = 0
        yourScoreLbl.textAlignment = .center
        yourScoreLbl.textColor = .black
        yourScoreLbl.font = UIFont.MontserratSemiBold(size: 16)
        addSubview(yourScoreLbl)
        yourScoreLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setContainerViewForPointsLbl() {
        addSubview(containerViewForPointsLbl)
        containerViewForPointsLbl.snp.makeConstraints { make in
            make.top.equalTo(yourScoreLbl.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        let ticketsStackView = UIStackView()
        ticketsStackView.axis = .horizontal
        ticketsStackView.distribution = .fill
        ticketsStackView.alignment = .leading
        ticketsStackView.spacing = 5
        containerViewForPointsLbl.addSubview(ticketsStackView)
        ticketsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        pointsLbl.text = " "
        pointsLbl.numberOfLines = 0
        pointsLbl.textAlignment = .center
        pointsLbl.textColor = .black
        pointsLbl.font = UIFont.MontserratBold(size: 36)
        ticketsStackView.addArrangedSubview(pointsLbl)
        pointsLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        imgView.image = UIImage.init(named: "ticketC")
        ticketsStackView.addArrangedSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(28)
        }
    }
    
//    private func setPointsLabel() {
//    pointsLbl.text = " "
//    pointsLbl.numberOfLines = 0
//    pointsLbl.textAlignment = .center
//    pointsLbl.textColor = .black
//    pointsLbl.font = UIFont.MontserratBold(size: 36)
//    ticketsStackView.addArrangedSubview(pointsLbl)
//    pointsLbl.snp.makeConstraints { make in
//        //            make.top.equalToSuperview()
//        //            make.leading.equalToSuperview()
//        //            make.centerY.equalToSuperview()
//        make.centerY.equalToSuperview()
//    }
//    }
//
//
//    private func setTicketImage() {
//        imgView.image = UIImage.init(named: "ticketC")
//        ticketsStackView.addArrangedSubview(imgView)
//        imgView.snp.makeConstraints { make in
//            make.height.width.equalTo(28)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(pointsLbl.snp.trailing)
//            make.trailing.equalToSuperview()
//        }
//    }
    private func setDescriptionLabel() {
        descriptionLbl.text = "Earn an extra point by sharing your score on your Instagram Story"
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .center
        descriptionLbl.textColor = .black
        descriptionLbl.font = UIFont.MontserratRegular(size: 14)
        addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(containerViewForPointsLbl.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func setShareButton() {
        if #available(iOS 15.0, *) {
            if shareButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Share", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
                shareButton.configuration = configuration
                
            } else {
                shareButton.configuration?.attributedTitle = AttributedString("Share", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            shareButton.setTitleColor(.white, for: .normal)
            shareButton.setTitle("Share", for: .normal)
        }
        shareButton.layer.cornerRadius = 25
        shareButton.clipsToBounds = true
        shareButton.titleLabel?.adjustsFontSizeToFitWidth = true
        let horizontalInset: CGFloat = 5
        let verticalInset: CGFloat = 20
        shareButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLbl.snp.bottom).offset(50)

        }
    }
    
    func setSkipButton(){
        skipButton = UIButton()
        if #available(iOS 15.0, *) {
            if skipButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Skip", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "FF2474")]))
                skipButton.configuration = configuration
                
            } else {
                skipButton.configuration?.attributedTitle = AttributedString("Skip", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "FF2474")]))
            }
            
        } else {
            skipButton.setTitle("Skip", for: .normal)
        }
        skipButton.layer.cornerRadius =  25
        skipButton.backgroundColor = .clear
        skipButton.clipsToBounds = true
       
        addSubview(skipButton)
        skipButton.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
}
