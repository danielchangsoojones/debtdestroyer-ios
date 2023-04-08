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
    
    init(videoURLs: [String], currentIndex: Int) {
        self.currentIndex = currentIndex
        self.videoUrls = videoURLs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if videoUrls.isEmpty {
            let answer_urls = Array(AnswerKeysViewController.answer_dict.values.map { $0.answer_url })
            self.videoUrls.append(contentsOf: answer_urls)
            getVidURLS()
        } else {
            Timer.runThisAfterDelay(seconds: 3.0) {
                self.configurePlayer()
            }
        }
    }
    
    // MARK: - Configuration
    
    func configurePlayer() {
        let url = videoUrls[currentIndex]
        print(url)
        let videoURL = URL(string: url)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    // MARK: - Helper Methods
    var observerStatus: NSKeyValueObservation?
    @objc func playerDidFinishPlaying() {
        currentIndex += 1
        
        if currentIndex >= videoUrls.count {
            showAllVideosFinishedAlert()
        } else {
            let url = videoUrls[currentIndex]
            print(url)
            let item = AVPlayerItem(url: URL(string: url)!)
            player?.replaceCurrentItem(with: item)
            player?.play()
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            observerStatus = item.observe(\.status, changeHandler: { (item, value) in
                debugPrint("status: \(item.status.rawValue)")
                if item.status == .failed {
                    // enqueue new asset with diff url
                    print("failed")
                    //we make it push to a new viewcontroller because I have no idea what is wrong with apple. But, sometimes it can't load a url, even though the url is fine. This seems to fix it. I'm not sure yet.
                    let vc = CycleVidViewController(videoURLs: self.videoUrls, currentIndex: self.currentIndex)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
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
    
    func getSwitchQuizData() {
        dataStore.getSwitchQuizDatas { result, error  in
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
                BannerAlert.showUnknownError(functionName: "getSwitchQuizDatas")
            }
        }
    }
    
}
