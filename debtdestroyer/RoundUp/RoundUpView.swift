//
//  RoundUpView.swift
//  nbawidget
//
//  Created by Rashmi Aher on 01/08/22.
//

import UIKit
import SnapKit

class RoundUpView: UIView {

    let backgroundCanvas1 = UIView()
    let buyLabel = UILabel()
    var buyAmountLabel = UILabel()
    let roundUpLabel = UILabel()
    var roundUpAmountLabel = UILabel()
    let emptyLabel = UILabel()
    let stackViewYouBuy : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    let stackViewRoundup : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    var imageViewYouBuy = UIImageView()
    let imageViewArrow = UIImageView()
    var imageViewRoundUp = UIImageView()
    let howItWorksButton = UIButton()
    let buttonAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 18, weight: .thin),
        .foregroundColor: UIColor.black,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    
    let backgroundCanvas2 = UIView()
    var loanStatusLbl = UILabel()
    let connectAccountBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        setbackgroundCanvas1()
        setbackgroundCanvas2()
        setConnectAccountButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setbackgroundCanvas1() {
        backgroundCanvas1.backgroundColor = .white
        backgroundCanvas1.layer.cornerRadius = 8
        addSubview(backgroundCanvas1)
        backgroundCanvas1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
           // make.height.equalTo(frame.width * 0.8)
        }
        setStackView()
        setHowItWorksButton()
    }
    
    private func setStackView() {
        backgroundCanvas1.addSubview(stackView)
        stackView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
//            make.bottom.equalTo(howItWorksButton.snp.top).inset(10)
            
        }
        setStackViewForYouBuy()
        setImgViewArrow()
        setStackViewForRoundUp()
    }
    
    private func setStackViewForYouBuy() {
        stackView.addArrangedSubview(stackViewYouBuy)
        stackViewYouBuy.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
        }
        setYouBuyLabel()
        setYouBuyAmountLabel()
        setYouBuyImgView()
    }
    
    private func setStackViewForRoundUp() {
        stackView.addArrangedSubview(stackViewRoundup)
        stackViewRoundup.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
        }
        setRoundUpLabel()
        setRoundUpAmountLabel()
        setRoundUpImgView()
    }
    
    private func setYouBuyLabel() {
        buyLabel.text = "You buy"
        buyLabel.textColor = .black
        buyLabel.textAlignment = .center
        buyLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        stackViewYouBuy.addArrangedSubview(buyLabel)

    }
    
    private func setYouBuyAmountLabel() {
        buyAmountLabel.text = "$3.42"
        buyAmountLabel.textColor = .black
        buyAmountLabel.textAlignment = .center
        buyAmountLabel.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        stackViewYouBuy.addArrangedSubview(buyAmountLabel)
        
    }
    
    private func setYouBuyImgView() {
        imageViewYouBuy.contentMode = .scaleAspectFit
        imageViewYouBuy.image = UIImage.init(named: "coffee")
        stackViewYouBuy.addArrangedSubview(imageViewYouBuy)
        imageViewYouBuy.snp.makeConstraints{ make in
            make.height.equalTo(80).priority(.high)
            
        }
    }
    
    private func setRoundUpLabel() {
        roundUpLabel.text = "Round-up"
        roundUpLabel.textColor = .black
        roundUpLabel.textAlignment = .center
        roundUpLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        stackViewRoundup.addArrangedSubview(roundUpLabel)

    }
    
    private func setRoundUpAmountLabel() {
        roundUpAmountLabel.text = "+$0.58"
        roundUpAmountLabel.textColor = .pestalGreen
        roundUpAmountLabel.textAlignment = .center
        roundUpAmountLabel.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        stackViewRoundup.addArrangedSubview(roundUpAmountLabel)
        
    }
    
    private func setRoundUpImgView() {
        imageViewRoundUp.contentMode = .scaleAspectFit
        imageViewRoundUp.image = UIImage.init(named: "smartphone")
        stackViewRoundup.addArrangedSubview(imageViewRoundUp)
        imageViewRoundUp.snp.makeConstraints{ make in
            make.height.equalTo(80).priority(.high)
            
        }
    }
    
    private func setImgViewArrow() {
        imageViewArrow.contentMode = .center
        imageViewArrow.image = UIImage.init(named: "arrow")
        stackView.addArrangedSubview(imageViewArrow)
    }
    
    private func setHowItWorksButton() {
        let attributeString = NSMutableAttributedString(
            string: "How it works?",
            attributes: buttonAttributes
        )
        howItWorksButton.setAttributedTitle(attributeString, for: .normal)
        backgroundCanvas1.addSubview(howItWorksButton)
        howItWorksButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(10)
            
        }
    }
    
    
    private func setbackgroundCanvas2() {
        backgroundCanvas2.backgroundColor = .white
        backgroundCanvas2.layer.cornerRadius = 8
        addSubview(backgroundCanvas2)
        backgroundCanvas2.snp.makeConstraints { make in
            make.top.equalTo(backgroundCanvas1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            //            make.centerY.equalToSuperview()
        }
        setPrivateLoanStatusLabel()
    }
    
    private func setPrivateLoanStatusLabel() {
        loanStatusLbl.text = "🏫 You have no student loans connected"
        loanStatusLbl.numberOfLines = 0
        loanStatusLbl.textColor = .black
        loanStatusLbl.textAlignment = .center
        backgroundCanvas2.addSubview(loanStatusLbl)
        loanStatusLbl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    private func setConnectAccountButton() {
//        connectAccountBtn.titleLabel?.text = "+ Securely connect my account"
        connectAccountBtn.backgroundColor = .black
        connectAccountBtn.setTitle("+ Securely connect my account", for: .normal)
        connectAccountBtn.layer.cornerRadius = 8
       
        addSubview(connectAccountBtn)
        connectAccountBtn.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(backgroundCanvas2.snp.bottom).offset(30)
            
        }
    }
}

