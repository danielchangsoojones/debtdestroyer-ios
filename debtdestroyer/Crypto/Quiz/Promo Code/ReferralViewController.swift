//
//  ReferralViewController.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit

class ReferralViewController: UIViewController {
    private var shouldShowSkipBtn: Bool!
    private var inviteButton: UIButton!
    private var skipButton: UIButton!
    
    init(shouldShowSkipBtn: Bool) {
        self.shouldShowSkipBtn = shouldShowSkipBtn
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let referralView = ReferralView(frame: self.view.frame)
        self.view = referralView
        referralView.skipButton.isHidden = !shouldShowSkipBtn
        self.inviteButton = referralView.inviteButton
        inviteButton.addTarget(self, action: #selector(inviteButtonPressed), for: .touchUpInside)
        self.skipButton = referralView.skipButton
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc private func inviteButtonPressed() {
        Haptics.shared.play(.heavy)
        var vc = InviteFriendViewController(shouldShowCloseBtn: false)
        if shouldShowSkipBtn {
            vc = InviteFriendViewController(shouldShowCloseBtn: true)
        }
        self.navigationController?.pushViewController(vc.self, animated: true)
    }
    
    @objc private func skipButtonPressed() {
        let tabBarVC = presentingViewController as? UITabBarController
        tabBarVC?.selectedIndex = 1
        dismiss(animated: true)
    }
}
