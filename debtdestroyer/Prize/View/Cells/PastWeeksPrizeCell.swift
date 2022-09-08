//
//  PastWeeksPrizeCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable
import AVFoundation
import Parse

class PastWeeksPrizeCell: UITableViewCell, Reusable {
    
    var playerContainerView: UIView!
    var playPauseButton: GradientBtn!
    private var playerView: PlayerView!
    var isPlaying = false
    
    var obj : AnyObject!
    private let videoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setUpPlayerContainerView()
        setUpPlayerView()
        setUpPlayerPalyPauseButton()
        
//        let query = PFQuery(className: "Winner")
//        query.getObjectInBackground(withId: obj as! String) { object, error in
//            if (error == nil && object != nil) {
//                let videoFile = object!["keyForVideoPFFile"] as! PFFileObject
//                self.videoURL = videoFile.url ?? "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
//            }
//
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        contentView.addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
            make.height.equalTo(180)
        }
    }
       
    private func setUpPlayerPalyPauseButton() {
        playPauseButton = GradientBtn()
        playPauseButton.setTitle("▶︎", for: .normal)
        playPauseButton.setTitleColor(.white, for: .normal)
        playPauseButton.layer.cornerRadius = 15
        playPauseButton.clipsToBounds = true
        playPauseButton.addTarget(self, action: #selector(playPauseBtnPressed), for: .touchUpInside)
        
        contentView.addSubview(playPauseButton)
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

    private func setUpPlayerView() {
        playerView = PlayerView()
        playerContainerView.addSubview(playerView)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor, multiplier: 16/9).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
    }
    
//    func playVideo() {
//        guard let url = URL(string: videoURL) else { return }
//        playerView.play(with: url)
//    }
}
