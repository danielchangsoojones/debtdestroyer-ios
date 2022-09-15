//
//  FinishAnimationViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/09/22.
//

import UIKit

class FinishAnimationViewController: UIViewController {
    var circularView = CircularProgressView()
    var duration: TimeInterval!
    var animationView = FinishAnimationView()
    var earnedLabel = UILabel()
    var nextButton = UIButton()
    var imgView = UIImageView()

    override func loadView() {
        super.loadView()
        
        animationView = FinishAnimationView(frame: self.view.bounds)
        self.view = animationView
        self.circularView = animationView.circularView
        self.imgView = animationView.imgView
        self.earnedLabel = animationView.earnedLabel
        self.nextButton = animationView.nextButton
        self.nextButton.addTarget(self,
                                       action: #selector(nextBtnPressed),
                                       for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duration = 3
        circularView.progressAnimation(duration: duration)
    }
    
    @objc private func nextBtnPressed() {
       print("nextBtnPressed")
    }

}
