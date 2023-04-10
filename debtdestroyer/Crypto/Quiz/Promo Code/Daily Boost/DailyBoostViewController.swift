//
//  DailyBoostViewController.swift
//  debtdestroyer
//
//  Created by DK on 3/30/23.
//


import UIKit

class DailyBoostViewController: UIViewController {
    private var isPresenting = false
    private let noteViewHeight = UIScreen.main.bounds.height * 0.5
    private var backdropView: UIView!
    private var boostView: UIView!
    private var declineButton: UIButton!
    var shareButton: SpinningButton!
    private var valuePropStackView: UIStackView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    var saveModalDismissed: ((String) -> Void)?
    var saveSharePressed: ((String) -> Void)?
    private var titleLabelText: String
    private var valuePropsText: [String]
    private var userSocials: [String]
    private var selectedSocial = "Instagram"
    private var socialsStackView: UIStackView!
    private var instagramSelection: UIButton!
    private var twitterSelection: UIButton!
    
    init(userSocials: [String], titleLabelText: String, valuePropsText: [String]) {
        self.userSocials = userSocials
        self.titleLabelText = titleLabelText
        self.valuePropsText = valuePropsText
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackDropView()
        setupDeclineButton()
        setupBoostView()
        setupShareButton()
        setupValuePropStackView()
        setUpLabels()
        setUpSocialSelectionButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func setupBackDropView() {
        backdropView = UIView(frame: self.view.bounds)
        backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.addSubview(backdropView)
    }
    
    private func setupDeclineButton() {
        declineButton = UIButton()
        declineButton.setTitle("Maybe, next time", for: .normal)
        declineButton.setTitleColor(.white, for: .normal)
        declineButton.backgroundColor = UIColor(white: 1, alpha: 0)
        declineButton.layer.cornerRadius = 13
        declineButton.titleLabel?.font = .systemFont(ofSize: 23, weight: .bold)
        view.addSubview(declineButton)
        declineButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.15)
        }
        declineButton.addTarget(self, action: #selector(declineButtonPressed), for: .touchUpInside)
    }
    
    
    private func setupBoostView() {
        boostView = UIView()
        boostView.backgroundColor = .black
        boostView.layer.cornerRadius = 20
        boostView.layer.borderColor = UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1).cgColor
        boostView.layer.borderWidth = 1
        view.addSubview(boostView)
        boostView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(declineButton.snp.top)
        }
    }
    
    private func setupShareButton() {
        shareButton = SpinningButton()
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1)
        shareButton.layer.cornerRadius = 30
        shareButton.layer.borderColor = UIColor.white.cgColor
        shareButton.layer.borderWidth = 2
        shareButton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        boostView.addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
    }
    
    private func setupValuePropStackView() {
        valuePropStackView = UIStackView()
        valuePropStackView.axis = .vertical
        valuePropStackView.distribution = .equalSpacing
        valuePropStackView.spacing = 20
        valuePropStackView.alignment = .leading
        valuePropStackView.setContentCompressionResistancePriority(.required, for: .vertical)
        boostView.addSubview(valuePropStackView)
        valuePropStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(shareButton)
            make.bottom.equalTo(shareButton.snp.top).offset(-20)
        }
        setupStackContent(valuePropsText: valuePropsText)
    }
    
    private func setupStackContent(valuePropsText: [String]) {
        for (index, value) in valuePropsText.enumerated() {
            let valuePropView = createValueProp(number: "\(index + 1)", value: value)
            valuePropStackView.addArrangedSubview(valuePropView)
        }
    }

    
    private func createValueProp(number: String, value: String) -> UIView {
        let valuePropView = UIView()
        valuePropView.backgroundColor = .black
        
        let valueLabel = UILabel()
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .white
        valueLabel.font = .systemFont(ofSize: 15, weight: .regular)
        valueLabel.textAlignment = .left
        valuePropView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.leading.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        valueLabel.text = value
        return valuePropView
    }

    private func setUpLabels() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "Bigger prizes for your friend group!"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 216/255)
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.textAlignment = .center
        boostView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(shareButton)
            make.bottom.equalTo(valuePropStackView.snp.top).offset(-20)
        }
    
        titleLabel = UILabel()
        titleLabel.text = titleLabelText
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .center
        boostView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview().offset(10)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-10)
        }
        
        if let rocketImage = UIImage(named: "rocket_icon")?.withRenderingMode(.alwaysTemplate) {
            let rocketImageView = UIImageView(image: rocketImage)
            rocketImageView.tintColor = .white
            rocketImageView.contentMode = .scaleAspectFit
            boostView.addSubview(rocketImageView)
            rocketImageView.snp.makeConstraints { (make) in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalTo(titleLabel.snp.leading)
                make.width.equalTo(45)
            }
        }
    }
    
    private func setUpSocialSelectionButtons() {
        //set up two buttons so that the user can toggle
        socialsStackView = UIStackView()
        socialsStackView.spacing = 15
        socialsStackView.axis = .horizontal
        socialsStackView.distribution = .fillEqually
        socialsStackView.alignment = .center
        view.addSubview(socialsStackView)
        socialsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(boostView.snp.top).offset(-15)
        }
        instagramSelection = createButton(imageName: "instagram_white")
        twitterSelection = createButton(imageName: "twitter_icon")
        instagramSelection.addTarget(self, action: #selector(instagramSelected), for: .touchUpInside)
        twitterSelection.addTarget(self, action: #selector(twitterSelected), for: .touchUpInside)
        
        //we only show the stackview when both the IG + Twitter apps exist. Otherwise, we don't need to show the stackview
        if userSocials.contains("Instagram") && userSocials.contains("Twitter") {
            socialsStackView.addArrangedSubview(instagramSelection)
            socialsStackView.addArrangedSubview(twitterSelection)
            toggleSocialButton(platform: "instagram")
        } else if userSocials.contains("Instagram") && !userSocials.contains("Twitter") {
            toggleSocialButton(platform: "instagram")
        } else if !userSocials.contains("Instagram") && userSocials.contains("Twitter") {
            toggleSocialButton(platform: "twitter")
        }
    }
    
    @objc private func instagramSelected() {
        toggleSocialButton(platform: "instagram")
    }
    
    @objc private func twitterSelected() {
        toggleSocialButton(platform: "twitter")
    }
    
    private func toggleSocialButton(platform: String) {
        selectedSocial = platform == "instagram" ? "Instagram" : "Twitter"
        
        //update background color of selected button
        instagramSelection.backgroundColor = platform == "instagram" ? UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1) : UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1)
        instagramSelection.layer.borderColor = platform == "instagram" ? UIColor.white.cgColor : .none
        instagramSelection.layer.borderWidth = platform == "instagram" ? 3 : 0
        
        //update background color of unselected button
        twitterSelection.backgroundColor = platform == "instagram" ? UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1) : UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1)
        twitterSelection.layer.borderColor = platform == "instagram" ? .none : UIColor.white.cgColor
        twitterSelection.layer.borderWidth = platform == "instagram" ? 0 : 3
        
        //update tht title of the share button
        shareButton.setTitle("Share on \(selectedSocial)", for: .normal)
    }
    
    private func createButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1)
        button.layer.cornerRadius = 20
        let horizontalInset: CGFloat = 5
        let verticalInset: CGFloat = 10
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = .white
        }
        
        return button
    }
    
    @objc func declineButtonPressed() {
        dismiss(animated: true, completion: nil)
        saveModalDismissed?(selectedSocial)
    }
    
    @objc func shareButtonPressed() {
        dismiss(animated: true, completion: nil)
        saveSharePressed?(selectedSocial)
    }
}

extension DailyBoostViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            boostView.frame.origin.y += noteViewHeight
            backdropView.alpha = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.boostView.frame.origin.y -= self.noteViewHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.boostView.frame.origin.y += self.noteViewHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
