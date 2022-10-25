//
//  ConfettiViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 10/24/22.
//

import UIKit
import SwiftConfettiView

class ConfettiViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        let confettiView = SwiftConfettiView(frame: frame)
        confettiView.backgroundColor = .blue
        confettiView.layer.cornerRadius = frame.height / 2
        confettiView.type = .confetti
        confettiView.intensity = 0.85
        confettiView.clipsToBounds = true
        self.view.addSubview(confettiView)
        confettiView.startConfetti()
        
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "50 tickets"
        confettiView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        // Do any additional setup after loading the view.
    }

}
