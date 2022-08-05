//
//  RoundUpWorksView.swift
//  nbawidget
//
//  Created by Rashmi Aher on 03/08/22.
//

import UIKit
import Reusable

class RoundUpWorksView: UITableViewCell, Reusable {
    
    let closeBtn = UIButton()
    let backgroundCanvas = UIView()
    let backgroundCanvas1 = UIView()
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let textView = UITextView()
    
    let buyLabel = UILabel()
    let buyAmountLabel1 = UILabel()
    let buyAmountLabel2 = UILabel()
    let buyAmountLabel3 = UILabel()
    let roundUpLabel = UILabel()
    let roundUpAmountLabel1 = UILabel()
    let roundUpAmountLabel2 = UILabel()
    let roundUpAmountLabel3 = UILabel()
    let totalLabel = UILabel()
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
    let stackViewArrow : UIStackView = {
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
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    let imageViewArrow1 = UIImageView()
    let imageViewArrow2 = UIImageView()
    let imageViewArrow3 = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        setCloseButton()
        setbackgroundCanvas()
        setbackgroundCanvas1()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setbackgroundCanvas1() {
        backgroundCanvas1.backgroundColor = .white
        backgroundCanvas1.layer.cornerRadius = 8
        addSubview(backgroundCanvas1)
        backgroundCanvas1.snp.makeConstraints { make in
            make.top.equalTo(backgroundCanvas.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        setStackView()
        setTotalAmountLabel()
    }
    
    private func setTotalAmountLabel() {
        
        totalLabel.text = "Total +$2.15 added to your loans"
        totalLabel.halfTextColorChange(fullText: totalLabel.text!, changeText: "+$2.15")
        totalLabel.numberOfLines = 0
        totalLabel.textColor = .black
        totalLabel.textAlignment = .center
        totalLabel.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        backgroundCanvas1.addSubview(totalLabel)
        totalLabel.snp.makeConstraints{ make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
    }
    
    private func setStackView() {
        backgroundCanvas1.addSubview(stackView)
        stackView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        setStackViewForYouBuy()
        setStackViewArrow()
        setStackViewForRoundUp()
    }
    
    private func setStackViewForYouBuy() {
        stackView.addArrangedSubview(stackViewYouBuy)
        stackViewYouBuy.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        setYouBuyLabel()
        setYouBuyAmountLabel(emoji: "🍔", lbl: buyAmountLabel1, txt: "9.10")
        setYouBuyAmountLabel(emoji: "🥤", lbl: buyAmountLabel2, txt: "3.50")
        setYouBuyAmountLabel(emoji: "⛽️", lbl: buyAmountLabel3, txt: "34.25")
    }
    
    private func setStackViewArrow() {
        stackView.addArrangedSubview(stackViewArrow)
        stackViewArrow.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(50).priority(.high)
        }
        setEmptyView()
        setImgViewArrow(imgView: imageViewArrow1)
        setImgViewArrow(imgView: imageViewArrow2)
        setImgViewArrow(imgView: imageViewArrow3)
    }
    
    private func setStackViewForRoundUp() {
        stackView.addArrangedSubview(stackViewRoundup)
        stackViewRoundup.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        setRoundUpLabel()
        setRoundUpAmountLabel(lbl: roundUpAmountLabel1, txt: "0.90")
        setRoundUpAmountLabel(lbl: roundUpAmountLabel2, txt: "0.50")
        setRoundUpAmountLabel(lbl: roundUpAmountLabel3, txt: "0.75")
    }
    
    private func setYouBuyLabel() {
        buyLabel.text = "You buy"
        buyLabel.textColor = .black
        buyLabel.textAlignment = .center
        buyLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        stackViewYouBuy.addArrangedSubview(buyLabel)
    }
    
    private func setYouBuyAmountLabel(emoji : String, lbl : UILabel, txt : String) {
        lbl.text = emoji + "$" + txt
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        stackViewYouBuy.addArrangedSubview(lbl)
    }
    
    private func setRoundUpLabel() {
        roundUpLabel.text = "Round-up"
        roundUpLabel.textColor = .black
        roundUpLabel.textAlignment = .left
        roundUpLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        stackViewRoundup.addArrangedSubview(roundUpLabel)
    }
    
    private func setRoundUpAmountLabel(lbl : UILabel, txt : String) {
        lbl.text = "+$" + txt
        lbl.textColor = .pestalGreen
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        stackViewRoundup.addArrangedSubview(lbl)
    }
    
    private func setImgViewArrow(imgView : UIImageView) {
        imgView.contentMode = .center
        imgView.image = UIImage.init(named: "arrow")
        stackViewArrow.addArrangedSubview(imgView)
    }
    
    private func setEmptyView() {
        let view = UIView()
        view.backgroundColor = .clear
        stackViewArrow.addArrangedSubview(view)
    }
    
    private func setbackgroundCanvas() {
        backgroundCanvas.backgroundColor = .white
        backgroundCanvas.layer.cornerRadius = 8
        addSubview(backgroundCanvas)
        backgroundCanvas.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        setTitelLabel()
        setSubtitelLabel()
        //        setTextView()
    }
    
    private func setTitelLabel() {
        titleLabel.text = "How does Round-up works?"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        backgroundCanvas.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    private func setSubtitelLabel() {
        subTitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = .black
        subTitleLabel.textAlignment = .left
        backgroundCanvas.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setTextView() {
        textView.textColor = .black
        textView.textAlignment = .left
        textView.isEditable = false
        textView.showsHorizontalScrollIndicator = false
        textView.isScrollEnabled = true
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. /n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        backgroundCanvas.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(contentView.frame.width * 0.5)
        }
        
    }
    private func setCloseButton(){
        closeBtn.setImage(UIImage.init(named: "cancel"), for: .normal)
        closeBtn.backgroundColor = .clear
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()//.offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.width.equalTo(35).priority(.high)
        }
    }
}

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.attributedText = attribute
    }
}
