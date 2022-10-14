//
//  TicketTopView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 22/08/22.
//

import UIKit
import Reusable
import SCLAlertView

class TicketTopView: UITableViewCell, Reusable {
    
    var earnedTicketView = UIView()
    var earnedTicketBackgroundImgView = UIImageView()
    var lblAmntPaidTo = UILabel()
    var lblAmntPaid = UILabel()
    var lblNoOfTickets = UILabel()
    var lblAutomatically = UILabel()
    var ticketCount = String()
    let infoBtn = UIButton()
    
    let stackViewHorizontal : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    let stackViewVertical10 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    let stackViewVertical20 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    let stackViewVertical30 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    let stackViewVertical40 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    
    var ticketProgressBar = UIProgressView()
    var stepImgView10 = UIImageView()
    var stepImgView20 = UIImageView()
    var stepImgView30 = UIImageView()
    var stepImgView40 = UIImageView()
    
    var Label10 = UILabel()
    var Label20 = UILabel()
    var Label30 = UILabel()
    var Label40 = UILabel()
    
    let emptyView1 = UIView()
    let emptyView2 = UIView()
    let emptyView3 = UIView()
    let emptyView4 = UIView()
    let emptyView5 = UIView()
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setEarnedTicketView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setEarnedTicketView() {
        self.contentView.addSubview(earnedTicketView)
        earnedTicketView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        setEarnedTicketBackgroundImgView()
        setAmountPaidToLbl()
        setInfoBtn()
        setAmountPaidLbl()
        setLblNoOfTickets()
        setContainerView()
    }
    
    private func setContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints{ make in
            make.top.equalTo(lblNoOfTickets.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(88)
            make.bottom.equalToSuperview().offset(-20)
            
        }
        setProgressBar()
        setStackViewHorizontal()
    }
    
    private func setProgressBar() {
        ticketProgressBar.progressImage = UIImage.init(named: "backgroundGrad")
        let dimension: CGFloat = 30
        ticketProgressBar.layer.cornerRadius = dimension / 2
        ticketProgressBar.clipsToBounds = true
        ticketProgressBar.progress = 0.36
        ticketProgressBar.trackTintColor = .progrssBarBackgroundColor
        containerView.addSubview(ticketProgressBar)
        ticketProgressBar.snp.makeConstraints{ make in
            make.top.equalTo(containerView).offset(35)
            make.leading.trailing.equalTo(containerView)
            make.height.equalTo(32)
        }
    }
    
    private func setStackViewHorizontal() {
        containerView.addSubview(stackViewHorizontal)
        stackViewHorizontal.snp.makeConstraints{ make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }
        setupEmptyView1()
        setStackViewVertical10()
        setupEmptyView2()
        setStackViewVertical20()
        setupEmptyView3()
        setStackViewVertical30()
        setupEmptyView4()
        setStackViewVertical40()
        setupEmptyView5()
    }
    
    private func setStackViewVertical10() {
        stackViewHorizontal.addArrangedSubview(stackViewVertical10)
        stackViewVertical10.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(32)
        }
        
        stepImgView10.image = UIImage.init(named: "stepW")
        stepImgView10.contentMode = .scaleAspectFit
        stepImgView10.backgroundColor = .clear
        stackViewVertical10.addArrangedSubview(stepImgView10)
        stepImgView10.snp.makeConstraints{ make in
            make.leading.trailing.top.equalTo(stackViewVertical10)
        }
        
        Label10 = createLabel(title: "$10")
        stackViewVertical10.addArrangedSubview(Label10)
        Label10.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(stackViewVertical10)
            make.top.equalTo(stepImgView10.snp.bottom)
            make.height.equalTo(12)
        }
    }
    
    
    private func setStackViewVertical20() {
        stackViewHorizontal.addArrangedSubview(stackViewVertical20)
        stackViewVertical20.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(32)
        }
        
        stepImgView20.image = UIImage.init(named: "stepW")
        stepImgView20.contentMode = .scaleAspectFit
        stepImgView20.backgroundColor = .clear
        stackViewVertical20.addArrangedSubview(stepImgView20)
        stepImgView20.snp.makeConstraints{ make in
            make.leading.trailing.top.equalTo(stackViewVertical20)
        }
        
        Label20 = createLabel(title: "$20")
        stackViewVertical20.addArrangedSubview(Label20)
        Label20.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(stackViewVertical20)
            make.top.equalTo(stepImgView20.snp.bottom)
            make.height.equalTo(12)
        }
    }
    
    private func setStackViewVertical30() {
        stackViewHorizontal.addArrangedSubview(stackViewVertical30)
        stackViewVertical30.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(32)
        }
        
        stepImgView30.image = UIImage.init(named: "stepW")
        stepImgView30.contentMode = .scaleAspectFit
        stepImgView30.backgroundColor = .clear
        stackViewVertical30.addArrangedSubview(stepImgView30)
        stepImgView30.snp.makeConstraints{ make in
            make.leading.trailing.top.equalTo(stackViewVertical30)
        }
        
        Label30 = createLabel(title: "$30")
        stackViewVertical30.addArrangedSubview(Label30)
        Label30.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(stackViewVertical30)
            make.top.equalTo(stepImgView30.snp.bottom)
            make.height.equalTo(12)
        }
    }
    
    private func setStackViewVertical40() {
        stackViewHorizontal.addArrangedSubview(stackViewVertical40)
        stackViewVertical40.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(32)
        }
        
        stepImgView40.image = UIImage.init(named: "stepW")
        stepImgView40.contentMode = .scaleAspectFit
        stepImgView40.backgroundColor = .clear
        stackViewVertical40.addArrangedSubview(stepImgView40)
        stepImgView40.snp.makeConstraints{ make in
            make.leading.trailing.top.equalTo(stackViewVertical40)
        }
        
        Label40 = createLabel(title: "$40")
        stackViewVertical40.addArrangedSubview(Label40)
        Label40.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(stackViewVertical40)
            make.top.equalTo(stepImgView40.snp.bottom)
            make.height.equalTo(12)
        }
    }
    
    private func setupEmptyView1(){
        emptyView1.backgroundColor = .clear
        stackViewHorizontal.addArrangedSubview(emptyView1)
        emptyView1.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func setupEmptyView2(){
        emptyView2.backgroundColor = .clear
        stackViewHorizontal.addArrangedSubview(emptyView2)
        emptyView2.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(emptyView1)
        }
    }
    
    private func setupEmptyView3(){
        emptyView3.backgroundColor = .clear
        stackViewHorizontal.addArrangedSubview(emptyView3)
        emptyView3.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(emptyView1)
        }
    }
    
    private func setupEmptyView4(){
        emptyView4.backgroundColor = .clear
        stackViewHorizontal.addArrangedSubview(emptyView4)
        emptyView4.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(emptyView1)
        }
    }
    
    private func setupEmptyView5(){
        emptyView5.backgroundColor = .clear
        stackViewHorizontal.addArrangedSubview(emptyView5)
        emptyView5.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(emptyView1)
        }
    }
    
    private func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.MontserratRegular(size: 10)
        return label
    }
    
    private func setEarnedTicketBackgroundImgView() {
        earnedTicketBackgroundImgView.image = UIImage.init(named: "ticketB")
        earnedTicketView.addSubview(earnedTicketBackgroundImgView)
        earnedTicketBackgroundImgView.snp.makeConstraints{ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setAmountPaidToLbl() {
        lblAmntPaidTo.text = "Amount Paid To Your Student Loans This Week"
        lblAmntPaidTo.textColor = .white
        lblAmntPaidTo.numberOfLines = 1
        lblAmntPaidTo.font = UIFont.MontserratSemiBold(size: 12)
        earnedTicketView.addSubview(lblAmntPaidTo)
        lblAmntPaidTo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    private func setInfoBtn() {
        infoBtn.setBackgroundImage(UIImage.init(named: "Info"), for: .normal)
        infoBtn.addTarget(self,
                          action: #selector(infoBtnClicked),
                          for: .touchUpInside)
        earnedTicketView.addSubview(infoBtn)
        infoBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(lblAmntPaidTo.snp.centerY)
            make.leading.equalTo(lblAmntPaidTo.snp.trailing).offset(5)
            make.height.width.equalTo(15)
        }
    }
    
    @objc private func infoBtnClicked() {
        print("infoBtnClicked")
        self.showAlert()
    }
    
    private func showAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            print("hello")
        })
        alertView.showInfo("Warning", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
    
    private func setAmountPaidLbl() {
        lblAmntPaid.text = "$" + "20.22"
        lblAmntPaid.textColor = .white
        lblAmntPaid.numberOfLines = 0
        lblAmntPaid.font = UIFont.MontserratMedium(size: 18)
        let dimension: CGFloat = 30
        earnedTicketView.addSubview(lblAmntPaid)
        lblAmntPaid.snp.makeConstraints{ make in
            make.top.equalTo(lblAmntPaidTo.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
        }
    }
    
    func setLblNoOfTickets() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "tickets-alt")
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: " " + ticketCount + " Tickets ")
        lblString.append(attachmentString)
        let space = NSMutableAttributedString(string: " ")
        lblString.append(space)
        lblNoOfTickets.attributedText = lblString
        lblNoOfTickets.textColor = .black
        lblNoOfTickets.backgroundColor = .sunGlow
        let dimension: CGFloat = 30
        lblNoOfTickets.layer.cornerRadius = dimension / 2
        lblNoOfTickets.layer.masksToBounds = true
        lblNoOfTickets.numberOfLines = 0
        lblNoOfTickets.font = UIFont.MontserratMedium(size: 18)
        earnedTicketView.addSubview(lblNoOfTickets)
        lblNoOfTickets.snp.makeConstraints{ make in
            make.top.equalTo(lblAmntPaidTo.snp.bottom).offset(10)
            make.leading.equalTo(lblAmntPaid.snp.trailing).offset(10)
            make.height.equalTo(dimension)
        }
    }
    
    private func setAutomaticallyEnteredLbl() {
        lblAutomatically.text = "your tickets are automatically entered into the weekly prize pool"
        lblAutomatically.textColor = .white
        lblAutomatically.numberOfLines = 0
        lblAutomatically.font = UIFont.MontserratSemiBold(size: 10)
        earnedTicketView.addSubview(lblAutomatically)
        lblAutomatically.snp.makeConstraints{ make in
            make.top.equalTo(ticketProgressBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-20)
            
        }
    }
}
