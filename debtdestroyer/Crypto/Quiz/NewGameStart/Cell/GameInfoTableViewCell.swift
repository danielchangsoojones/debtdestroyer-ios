//
//  MainGameTableViewCell.swift
//  debtdestroyer
//
//  Created by DK on 4/15/23.
//

import UIKit
import Reusable

class GameInfoTableViewCell: UITableViewCell, Reusable {
    private var backgroundContainer: UIView!
    private var infoContainer: UIView!
    private var prizeStackView: UIStackView!
    var rulesButton: UIButton!
    var showGameRules: (() -> Void)? = nil
    private var timeLeftLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setUpBackgroundContainer()
        setUpRulesButton()
        setUpTimeLeftLabel()
        setUpPrizeStackView()
        addPrizes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(timeLeftLabel: String) {
        self.timeLeftLabel.text = timeLeftLabel
    }
    
    private func setUpBackgroundContainer() {
        backgroundContainer = UIView()
        backgroundContainer.backgroundColor = .black
        backgroundContainer.layer.cornerRadius = 15
        backgroundContainer.layer.borderWidth = 1
        backgroundContainer.layer.borderColor = UIColor(red: 114/255, green: 244/255, blue: 171/255, alpha: 1).cgColor
        backgroundContainer.layer.shadowColor = UIColor.white.cgColor
        backgroundContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundContainer.layer.shadowOpacity = 0.4
        backgroundContainer.layer.shadowRadius = 10
        contentView.addSubview(backgroundContainer)
        backgroundContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setUpRulesButton() {
        let btnColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1)
        if let image = UIImage(named: "InfoBlack")?.withRenderingMode(.alwaysTemplate) {
            rulesButton = UIButton()
            rulesButton.addTarget(self, action: #selector(rulesButtonPressed), for: .touchUpInside)
            rulesButton.setTitle("Rules", for: .normal)
            rulesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            rulesButton.setTitleColor(btnColor, for: .normal)
            backgroundContainer.addSubview(rulesButton)
            rulesButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            rulesButton.setImage(image, for: .normal)
            rulesButton.tintColor = btnColor
            rulesButton.imageView?.contentMode = .scaleAspectFit
            rulesButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
            rulesButton.semanticContentAttribute = .forceRightToLeft
            rulesButton.snp.makeConstraints { make in
                make.leading.bottom.equalToSuperview().inset(15)
            }
        }
    }
    
    @objc private func rulesButtonPressed() {
        showGameRules?()
    }
    
    private func setUpTimeLeftLabel() {
        timeLeftLabel = UILabel()
        timeLeftLabel.text = ""
        timeLeftLabel.textColor = .white
        timeLeftLabel.font = .systemFont(ofSize: 20, weight: .bold)
        backgroundContainer.addSubview(timeLeftLabel)
        timeLeftLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalTo(rulesButton)
        }
        
        let timeInfoLabel = UILabel()
        timeInfoLabel.text = "Starts in"
        timeInfoLabel.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1)
        timeInfoLabel.font = .systemFont(ofSize: 15, weight: .regular)
        backgroundContainer.addSubview(timeInfoLabel)
        timeInfoLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(timeLeftLabel.snp.leading).offset(-5)
            make.top.bottom.equalTo(timeLeftLabel)
        }
        
    }
    
    private func setUpPrizeStackView() {
        prizeStackView = UIStackView()
        prizeStackView.spacing = 9
        prizeStackView.axis = .horizontal
        prizeStackView.distribution = .fillEqually
        prizeStackView.alignment = .fill
        backgroundContainer.addSubview(prizeStackView)
        prizeStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(rulesButton.snp.top).offset(-10)
        }
    }
    
    private func addPrizes() {
        //TODO: we should make the prize population backend driven
        let jackPotPrizeView = createPrizeView(title: "$15,000", subtitle: "Get all 15 questions right")
        let topFivePrizeView = createPrizeView(title: "$10", subtitle: "Hit Top 5 Score")
        prizeStackView.addArrangedSubview(jackPotPrizeView)
        prizeStackView.addArrangedSubview(topFivePrizeView)
    }
    
    private func createPrizeView(title: String, subtitle: String) -> UIView {
        let prizeView = UIView()
        prizeView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        prizeView.layer.borderColor = UIColor.white.cgColor
        prizeView.layer.borderWidth = 1
        prizeView.layer.cornerRadius = 15
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor(red: 114/255, green: 244/255, blue: 171/255, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        prizeView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(25)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        prizeView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.bottom.equalToSuperview().inset(25)
        }
        
        return prizeView
    }
}
