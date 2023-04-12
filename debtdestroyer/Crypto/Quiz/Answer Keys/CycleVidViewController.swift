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
            self.queuePlayer.insert(playerItem, after: nil)
        }
        
        playerLayer =  AVPlayerLayer(player: queuePlayer)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        queuePlayer.play()
        
        // Observe the AVPlayerItemDidPlayToEndTime notification for the current player item
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: queuePlayer.currentItem, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            if self.queuePlayer.items().count == 1 {
                // Display the alert view when the player has finished playing all items in the queue
                let alertController = UIAlertController(title: "Queue ended", message: "All videos in the queue have been played", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
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
    
}
