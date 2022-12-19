//
//  GameStartNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 19/12/22.
//

import UIKit
import AVFoundation

class GameStartNewUIView: UIView {
    var descContainer = UIView()
    var startLbl = UILabel()
    var countDownTimerLbl = UILabel()
    var dayDateLbl = UILabel()
    var headingLbl = UILabel()
    var descriptionLbl = UILabel()
    var prizeBtn = GradientBlueButton()
    var videoContainer = UIView()
    var playerLooper: AVPlayerLooper!
    var player: AVQueuePlayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setContainerForVideo()
        setStartLabel()
        setCountDownTimerLabel()
        setDayDateLabel()
        setDescriptionContainer()
        
        setPrizeButton()
        setHeadingLabel()
        setDescriptionLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerForVideo() {
        addSubview(videoContainer)
        videoContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        playVideo(from: "silverCup.mp4", on: videoContainer)
        
    }
    
    private func playVideo(from file:String , on view: UIView) {
        let file = file.components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        
//        player = AVQueuePlayer(items: [playerItem])
        player = AVQueuePlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)

        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = view.bounds
        view.layer.insertSublayer(playerLayer, at: 0)
        view.backgroundColor = .clear.withAlphaComponent(0.5)
        player.play()
    }
    
    
    private func setDescriptionContainer() {
        descContainer.backgroundColor = .clear
        descContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        descContainer.layer.cornerRadius = 15
        descContainer.clipsToBounds = true
        addSubview(descContainer)
        descContainer.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setStartLabel() {
        startLbl.text = "NEXT GAME STARTING IN:"
        startLbl.numberOfLines = 0
        startLbl.textAlignment = .center
        startLbl.textColor = .white
        startLbl.font = UIFont.MontserratSemiBold(size: 25)
        videoContainer.addSubview(startLbl)
        startLbl.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setCountDownTimerLabel() {
        countDownTimerLbl.text = "0"
        countDownTimerLbl.numberOfLines = 0
        countDownTimerLbl.textAlignment = .center
        countDownTimerLbl.textColor = .white
        countDownTimerLbl.font = UIFont.MontserratBold(size: 35)
        videoContainer.addSubview(countDownTimerLbl)
        countDownTimerLbl.snp.makeConstraints { make in
            make.top.equalTo(startLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setDayDateLabel() {
        dayDateLbl.numberOfLines = 0
        dayDateLbl.textAlignment = .center
        dayDateLbl.textColor = .white
        dayDateLbl.font = UIFont.MontserratSemiBold(size: 16)
        videoContainer.addSubview(dayDateLbl)
        dayDateLbl.snp.makeConstraints { make in
            make.top.equalTo(countDownTimerLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setHeadingLabel() {
        headingLbl.numberOfLines = 0
        headingLbl.text = "Compete in our live trivia."
        headingLbl.textAlignment = .left
        headingLbl.textColor = .white
        headingLbl.font = UIFont.MontserratBold(size: 25)
        descContainer.addSubview(headingLbl)
        headingLbl.snp.makeConstraints { make in
            make.top.equalTo(prizeBtn.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLbl.text = "Answer all 15 of our questions to win!"
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .left
        descriptionLbl.textColor = .white
        descriptionLbl.font = UIFont.MontserratMedium(size: 22)
        descContainer.addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(headingLbl.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func setPrizeButton() {
        prizeBtn.layer.cornerRadius = 33
        prizeBtn.clipsToBounds = true
        prizeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        descContainer.addSubview(prizeBtn)
        prizeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(66)
            make.width.greaterThanOrEqualTo(66)
            make.top.equalToSuperview().offset(30)
        }
    }
    
}
