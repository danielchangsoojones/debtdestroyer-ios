//
//  QuizQuestionTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 31/01/23.
//

import UIKit
import Reusable
import AVFoundation

class QuizQuestionTableViewCell: UITableViewCell, Reusable {
    
    let questionLabel = UILabel()
    let answersLabel = UILabel()
    var playerContainerView: UIView!
    var playPauseButton: GradientBtn!
    private var playerView: PlayerView!
    var isPlaying = false
    
    var videoURL = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
  
        setQuestionLabel()
        setAnswersLabel()
        setUpPlayerContainerView()
        setUpPlayerView()
        setUpPlayerPalyPauseButton()
        
//        NotificationCenter.default
//            .addObserver(self,
//                         selector: #selector(playerDidFinishPlaying),
//                         name: .AVPlayerItemDidPlayToEndTime,
//                         object: .none
//            )

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setQuestionLabel() {
        questionLabel.font = UIFont.MontserratMedium(size: 18)
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byCharWrapping
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setAnswersLabel() {
        answersLabel.font = UIFont.MontserratRegular(size: 15)
        answersLabel.textColor = .gray
        answersLabel.numberOfLines = 0
        addSubview(answersLabel)
        answersLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            //            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(200)
            make.top.equalTo(answersLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setUpPlayerPalyPauseButton() {
        playPauseButton = GradientBtn()
        playPauseButton.setTitle("▶︎", for: .normal)
        playPauseButton.setTitleColor(.white, for: .normal)
        playPauseButton.layer.cornerRadius = 15
        playPauseButton.clipsToBounds = true
        playPauseButton.addTarget(self, action: #selector(playPauseBtnPressed), for: .touchUpInside)
        
        playerContainerView.addSubview(playPauseButton)
        playPauseButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
    
    @objc private func playPauseBtnPressed() {
        if isPlaying {
            playerView.pause()
            playPauseButton.setTitle("▶︎", for: .normal)
        } else {
            guard let url = URL(string: videoURL) else { return }
            playerView.play(with: url)
            playPauseButton.setTitle("⎮⎮", for: .normal)
        }
        
        isPlaying.toggle()
    }
    
//    @objc private func playerDidFinishPlaying(notification: NSNotification) {
//        playPauseButton.setTitle("▶︎", for: .normal)
//        isPlaying.toggle()
//    }
//
    private func setUpPlayerView() {
        playerView = PlayerView()
        playerContainerView.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

