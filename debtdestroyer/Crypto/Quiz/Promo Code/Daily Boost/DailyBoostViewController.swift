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
    private var shareButton: UIButton!
    private var valuePropStackView: UIStackView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    var saveModalDismissed: (() -> Void)?
    var saveSharePressed: (() -> Void)?
    private var titleLabelText: String
    private var valuePropsText: [String]
    
    init(titleLabelText: String, valuePropsText: [String]) {
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
        if let image = UIImage(named: "instagram_icon") {
            shareButton = UIButton()
            shareButton.setTitle("Share for Boost", for: .normal)
            shareButton.setTitleColor(UIColor(red: 223/255, green: 0/255, blue: 181/255, alpha: 1), for: .normal)
            shareButton.backgroundColor = .white
            shareButton.layer.cornerRadius = 30
            shareButton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
            shareButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 10)
            boostView.addSubview(shareButton)
            shareButton.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().inset(20)
                make.height.equalTo(60)
            }
            
            shareButton.setImage(image, for: .normal)
            shareButton.imageView?.contentMode = .scaleAspectFit
            shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10)
            shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        }
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
    
//    private func setupStackContent() {
//        let valuePropOneView = createValueProp(number: "1", value: "Share your promo code to 2X your Top 5 Prize to $20 today! 🎉")
//        let valuePropTwoView = createValueProp(number: "2", value: "Your referred friends also get a 2X boost in today’s Top 5 prize! 🤑")
//        valuePropStackView.addArrangedSubview(valuePropOneView)
//        valuePropStackView.addArrangedSubview(valuePropTwoView)
//    }
    
    private func setupStackContent(valuePropsText: [String]) {
        for (index, value) in valuePropsText.enumerated() {
            let valuePropView = createValueProp(number: "\(index + 1)", value: value)
            valuePropStackView.addArrangedSubview(valuePropView)
        }
    }

    
    private func createValueProp(number: String, value: String) -> UIView {
        let valuePropView = UIView()
        valuePropView.backgroundColor = .black
        
        let numberButton = UIButton()
        numberButton.setTitle(number, for: .normal)
        numberButton.backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 39/255)
        numberButton.layer.cornerRadius = 15
        numberButton.layer.borderWidth = 2
        numberButton.layer.borderColor = UIColor.white.cgColor
        valuePropView.addSubview(numberButton)
        numberButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        let valueLabel = UILabel()
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .white
        valueLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        valueLabel.textAlignment = .left
        valuePropView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberButton)
            make.trailing.equalToSuperview()
            make.leading.equalTo(numberButton.snp.trailing).offset(15)
            make.bottom.equalToSuperview()
        }
        valueLabel.text = value
//        let blueColor = UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1)
//        if number == "1" {
//            let attributedString = NSMutableAttributedString(string: value)
//            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: blueColor, range: NSRange(location: 24, length: 34))
//            valueLabel.attributedText = attributedString
//        } else if number == "2" {
//            let attributedString = NSMutableAttributedString(string: value)
//            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: blueColor, range: NSRange(location: 33, length: 32))
//            valueLabel.attributedText = attributedString
//        } else {
//            valueLabel.text = value
//        }
        
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
//        let attributedString = NSMutableAttributedString(string: "2X ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 58/255, green: 130/255, blue: 247/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .semibold)])
//        attributedString.append(NSAttributedString(string: "Top 5 Prize", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .semibold)]))
//        titleLabel.attributedText = attributedString
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
    
    @objc func declineButtonPressed() {
        dismiss(animated: true, completion: nil)
        saveModalDismissed?()
    }
    
    @objc func shareButtonPressed() {
        dismiss(animated: true, completion: nil)
        saveSharePressed?()
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
