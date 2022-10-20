//
//  ScoreViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 20/10/22.
//

import UIKit

class ScoreViewController: UIViewController {
    var scoreView = ScoreView()
    private var pointsLbl = UILabel()
    private var shareButton = GradientBtn()
    private var skipButton: UIButton!
    var color1 = UIColor()
    var color2 = UIColor()
    private var quizDatas: [QuizDataParse] = []
    private let currentIndex: Int
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int) {
        self.quizDatas = quizDatas
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreView = ScoreView(frame: self.view.bounds)
        self.view = scoreView
        self.shareButton = scoreView.shareButton
        self.skipButton = scoreView.skipButton
        self.pointsLbl = scoreView.pointsLbl
        color1 = scoreView.hexStringToUIColor(hex: "FF2474")
        color2 = scoreView.hexStringToUIColor(hex: "FF7910")
        self.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        self.skipButton.addTarget(self, action: #selector(SkipButtonPressed), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        skipButton.layer.cornerRadius =  25
        skipButton.clipsToBounds = true
        let gradientForText = scoreView.getGradientLayer(bounds: skipButton.bounds)
        skipButton.setTitleColor(scoreView.gradientColor(bounds: skipButton.bounds, gradientLayer: gradientForText), for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: skipButton.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 25
        
        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:skipButton.bounds, cornerRadius:25).cgPath
        border.frame = skipButton.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = 4
        gradient.mask = border
        
        skipButton.layer.addSublayer(gradient)
        
        let gradientLabel = scoreView.getGradientLayer(bounds: pointsLbl.bounds)
        pointsLbl.textColor = scoreView.gradientColor(bounds: pointsLbl.bounds, gradientLayer: gradientLabel)
        
        Timer.runThisAfterDelay(seconds: 120.0) {
            self.SkipButtonPressed()
        }
        
    }

    @objc private func shareButtonPressed() {
        if let storiesUrl = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storiesUrl) {
                guard let image = UIImage(named: "ticketB") else { return }
                guard let imageData = image.pngData() else { return }
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": "#FF2474",
                    "com.instagram.sharedSticker.backgroundBottomColor": "#FF7910"
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate:
                        Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options:
                                                pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:],
                                          completionHandler: nil)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Sorry the application is not installed")
            }
        }
    }
    
    @objc private func SkipButtonPressed() {
        let leaderboardVC = ChampionsViewController(quizTopic: currentData.quizTopic)
        self.navigationController?.pushViewController(leaderboardVC, animated: true)
        
    }

}
