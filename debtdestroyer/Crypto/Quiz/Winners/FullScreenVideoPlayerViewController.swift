//
//  FullScreenVideoPlayerViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 19/10/22.
//

import UIKit
import AVFoundation

class FullScreenVideoPlayerViewController: UIViewController {
    
    private var playerContainerView: UIView!
    private var playerView: PlayerView!
    private let videoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    private let swipeUpLbl = UILabel()
    private let arrowLbl = UILabel()
    private var alreadyAppear = false
    private let logoImgView = UIImageView()
    private let nameLabel = UILabel()
    private let startQuizButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpPlayerContainerView()
        setUpPlayerView()
        setSwipUpLabel()
        setLogoImgView()
        setNameLabel()
        setStartQuizButton()
        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        
        swipeGestureRecognizerUp.direction = .up
        
        playerView.addGestureRecognizer(swipeGestureRecognizerUp)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        playVideo()
        activityIndicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
       // position of player & swipe up adjusted back to position
        if alreadyAppear {
            playerView.play()
            
            let logoPosition = CGPoint(x: logoImgView.frame.origin.x, y: logoImgView.frame.origin.y + 300.0)
            logoImgView.frame = CGRect(x: logoPosition.x, y: logoPosition.y, width: logoImgView.frame.size.width, height: logoImgView.frame.size.height)
            
            let namePosition = CGPoint(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + 300.0)
            nameLabel.frame = CGRect(x: namePosition.x, y: namePosition.y, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height)
            
            let viewPosition = CGPoint(x: playerView.frame.origin.x, y: playerView.frame.origin.y + 300.0)
            playerView.frame = CGRect(x: viewPosition.x, y: viewPosition.y, width: playerView.frame.size.width, height: playerView.frame.size.height)
            
            
            let swipeLblPosition = CGPoint(x: swipeUpLbl.frame.origin.x, y: swipeUpLbl.frame.origin.y + 300.0)
            swipeUpLbl.frame = CGRect(x: swipeLblPosition.x, y: swipeLblPosition.y, width: swipeUpLbl.frame.size.width, height: swipeUpLbl.frame.size.height)
            
            
            let arrowLblPosition = CGPoint(x: arrowLbl.frame.origin.x, y: arrowLbl.frame.origin.y + 300.0)
            arrowLbl.frame = CGRect(x: arrowLblPosition.x, y: arrowLblPosition.y, width: arrowLbl.frame.size.width, height: arrowLbl.frame.size.height)
        }
        
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .up) {
            print("Swipe")
            
            PlayerView.animate(withDuration: 1, animations: { [self] in
                alreadyAppear = true
                
                let logoPosition = CGPoint(x: logoImgView.frame.origin.x, y: logoImgView.frame.origin.y - 300.0)
                logoImgView.frame = CGRect(x: logoPosition.x, y: logoPosition.y, width: logoImgView.frame.size.width, height: logoImgView.frame.size.height)
                
                let namePosition = CGPoint(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y - 300.0)
                nameLabel.frame = CGRect(x: namePosition.x, y: namePosition.y, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height)
                
                let viewPosition = CGPoint(x: playerView.frame.origin.x, y: playerView.frame.origin.y - 300.0)
                playerView.frame = CGRect(x: viewPosition.x, y: viewPosition.y, width: playerView.frame.size.width, height: playerView.frame.size.height)
                
                
                let swipeLblPosition = CGPoint(x: swipeUpLbl.frame.origin.x, y: swipeUpLbl.frame.origin.y - 300.0)
                swipeUpLbl.frame = CGRect(x: swipeLblPosition.x, y: swipeLblPosition.y, width: swipeUpLbl.frame.size.width, height: swipeUpLbl.frame.size.height)
                
                
                let arrowLblPosition = CGPoint(x: arrowLbl.frame.origin.x, y: arrowLbl.frame.origin.y - 300.0)
                arrowLbl.frame = CGRect(x: arrowLblPosition.x, y: arrowLblPosition.y, width: arrowLbl.frame.size.width, height: arrowLbl.frame.size.height)
                
            })
            Timer.runThisAfterDelay(seconds: 1.0) {
                self.tabBarController?.tabBar.isHidden = false
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        playerContainerView.frame = self.view.frame
        view.addSubview(playerContainerView)
    }
    
    private func setUpPlayerView() {
        playerView = PlayerView()
        playerView.playerLayer.videoGravity = .resizeAspectFill
        playerView.playerLayer.frame = self.playerContainerView.frame
        playerContainerView.addSubview(playerView)
    }
    
    private func setLogoImgView() {
        logoImgView.image = UIImage.init(named: "drop")
        logoImgView.contentMode = .scaleAspectFill
        view.addSubview(logoImgView)
        logoImgView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.width.equalTo(18)
            
        }
    }
    
    private func setNameLabel() {
        nameLabel.text = "Debt Destroyed"
        nameLabel.font = UIFont.MontserratSemiBold(size: 18)
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .clear
        nameLabel.numberOfLines = 0
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImgView)
            make.leading.equalTo(logoImgView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setStartQuizButton() {
        startQuizButton.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if startQuizButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Start Quiz", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                startQuizButton.configuration = configuration
                
            } else {
                startQuizButton.configuration?.attributedTitle = AttributedString("Start Quiz", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            startQuizButton.setTitleColor(.white, for: .normal)
            startQuizButton.setTitle("Start Quiz", for: .normal)
        }
        view.addSubview(startQuizButton)
        startQuizButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoImgView)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    
    private func setSwipUpLabel() {
        swipeUpLbl.text = "Swipe up to skip"
        swipeUpLbl.textColor = .white
        swipeUpLbl.textAlignment = .center
        swipeUpLbl.font = UIFont.MontserratSemiBold(size: 18)
        
        view.addSubview(swipeUpLbl)
        swipeUpLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        arrowLbl.text = "︿"
        arrowLbl.textColor = .white
        arrowLbl.textAlignment = .center
        arrowLbl.font = UIFont.MontserratSemiBold(size: 18)
        
        view.addSubview(arrowLbl)
        arrowLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.bottom.equalTo(swipeUpLbl.snp.top).offset(-10)
        }
        
    }
    
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return }
        playerView.play(with: url)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        playerView.pause()
    }
}
