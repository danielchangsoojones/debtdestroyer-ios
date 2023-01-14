//
//  WaitlistViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 1/13/23.
//

import UIKit

class WaitlistViewController: UIViewController {
    private let headingTitle: String
    private let subtitle: String
    
    init(headingTitle: String, subtitle: String) {
        self.headingTitle = headingTitle
        self.subtitle = subtitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let waitlistView = WaitlistView(frame: self.view.frame)
        self.view = waitlistView
        waitlistView.subtitleLabel.text = subtitle
        waitlistView.titleLabel.text = headingTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
