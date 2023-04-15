//
//  CycleVidViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 4/5/23.
//

import UIKit
import AVKit
import AVFoundation
import SCLAlertView

class CycleVidViewController: UIViewController {
    
    // MARK: - Properties
    
    var videoUrls: [String] = []
    var playerLayer: AVPlayerLayer!
    private let dataStore = QuizDataStore()
    let queuePlayer = AVQueuePlayer()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let answer_urls = Array(AnswerKeysViewController.answer_dict.values.map { $0.answer_url })
        self.videoUrls.append(contentsOf: answer_urls)
        getVidURLS()
    }
    
    func configurePlayer() {
        let playerItems = self.videoUrls.map { AVPlayerItem(url: URL(string: $0)!) }
        for playerItem in playerItems {
            // Add observer for AVPlayerItemDidPlayToEndTime for each item in the player's items array
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
            // Add observer for AVPlayerItemFailedToPlayToEndTime
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidFailToPlayToEnd(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: playerItem)
            self.queuePlayer.insert(playerItem, after: nil)
        }
        
        playerLayer =  AVPlayerLayer(player: queuePlayer)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        queuePlayer.play()
        
        let nextButton = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 50))
        nextButton.backgroundColor = .blue
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
    }
    
    @objc func playerItemDidFinishPlaying(_ notification: Notification) {
            if let playerItem = notification.object as? AVPlayerItem {
                if let avAsset = playerItem.asset as? AVURLAsset {
                    if self.videoUrls.last == avAsset.url.absoluteString {
                        showAllVideosFinishedAlert()
                    }
                    print("Finished playing: \(avAsset.url.absoluteString)")
                }
                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        }
    }
    
    @objc func nextButtonTapped() {
        if let player = self.playerLayer?.player as? AVQueuePlayer {
            player.advanceToNextItem()
        }
    }
    
    @objc func playerItemDidFailToPlayToEnd(_ notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            // Handle the error of the player item here
            if let avAsset = playerItem.asset as? AVURLAsset {
                print("Error playing: \(avAsset.url.absoluteString)")
            }
            print("Failed to play: \(playerItem.error?.localizedDescription ?? "Unknown error")")
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemFailedToPlayToEndTime, object: playerItem)
        }
    }
    
    func showAllVideosFinishedAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true,
            shouldAutoDismiss: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            // Handle "OK" option
        })
        alertView.showSuccess("All Videos Finished", subTitle: "All videos have been played.")
    }
    
    private func getVidURLS() {
        dataStore.getQuizData { result, error  in
            if let quizDatas = result as? [QuizDataParse] {
                self.addToVids(quizDatas: quizDatas)
                self.getSwitchQuizData()
            } else if let error = error {
                if error.localizedDescription.contains("error-force-update") {
                    let forceUpdateShown  = ForceUpdate.forceUpdateShown?.withAddedMinutes(minutes: 2)
                    
                    if forceUpdateShown == nil || forceUpdateShown! <= Date() {
                        ForceUpdate.showAlert()
                    }
                } else {
                    BannerAlert.show(with: error)
                }
            } else {
                BannerAlert.showUnknownError(functionName: "getQuizData")
            }
        }
    }
    
    private func addToVids(quizDatas: [QuizDataParse]) {
        let questionURLS = quizDatas.map { quizData in
            return quizData.video_url_string
        }
        self.videoUrls.append(contentsOf: questionURLS)
        let answerVideoURLs: [String] = quizDatas.map { quizData in
            return quizData.videoAnswer?.video_url_string ?? ""
        }.filter { str in
            return !str.isEmpty
        }
        self.videoUrls.append(contentsOf: answerVideoURLs)
    }
    
    func getSwitchQuizData() {
        dataStore.getSwitchQuizDatas { result, error  in
            if let quizDatas = result as? [QuizDataParse] {
                self.addToVids(quizDatas: quizDatas)
                self.getTieBreakerQuestions()
            } else if let error = error {
                if error.localizedDescription.contains("error-force-update") {
                    let forceUpdateShown  = ForceUpdate.forceUpdateShown?.withAddedMinutes(minutes: 2)
                    
                    if forceUpdateShown == nil || forceUpdateShown! <= Date() {
                        ForceUpdate.showAlert()
                    }
                } else {
                    BannerAlert.show(with: error)
                }
            } else {
                BannerAlert.showUnknownError(functionName: "getSwitchQuizDatas")
            }
        }
    }
    
    func getTieBreakerQuestions() {
        let tieDataStore = TieBreakerDataStore()
        tieDataStore.getTieQuizDatas { quizDatas in
            self.addToVids(quizDatas: quizDatas)
            self.configurePlayer()
        }
    }
    
    private func removePlayer() {
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        // Pause player
        playerLayer?.player?.pause()
        
        // Remove playerLayer from superlayer
        playerLayer?.removeFromSuperlayer()
        
        // Set playerLayer player to nil
        playerLayer?.player = nil
    }
    
}
