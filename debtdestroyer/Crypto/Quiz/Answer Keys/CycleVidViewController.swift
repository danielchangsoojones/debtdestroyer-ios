//
//  CycleVidViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 4/5/23.
//

import UIKit
import AVKit
import SCLAlertView

class CycleVidViewController: UIViewController {
    
    // MARK: - Properties
    
    var videoUrls: [String] = []
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var currentIndex = 0
    private let dataStore = QuizDataStore()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let answer_urls = Array(AnswerKeysViewController.answer_dict.values.map { $0.answer_url })
        self.videoUrls.append(contentsOf: answer_urls)
        getVidURLS()
    }
    
    // MARK: - Configuration
    
    func configurePlayer() {
        let videoURL = URL(string: videoUrls[currentIndex])
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    // MARK: - Helper Methods
    @objc func playerDidFinishPlaying() {
        currentIndex += 1
        
        if currentIndex >= videoUrls.count {
            showAllVideosFinishedAlert()
        } else {
            player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: videoUrls[currentIndex])!))
            player?.play()
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
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
                let questionURLS = quizDatas.map { quizData in
                    return quizData.video_url_string
                }
                self.videoUrls.append(contentsOf: questionURLS)
                self.configurePlayer()
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
    
}
