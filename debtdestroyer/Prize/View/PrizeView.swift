//
//  PrizeView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 05/08/22.
//

import UIKit
import Reusable

class PrizeView: UITableViewCell, Reusable {
    
    var weekPrizeView = UIView()
    var weekPrizeBackgroundImgView = UIImageView()
    let weekPrizeLbl = UILabel()
    let weekPrizeInfoBtn = UIButton()
    let winLbl = UILabel()
    let announcementLbl = UILabel()
    let pastWinnersLbl = UILabel()
    var collectionView : UICollectionView!
    let earningTicketsBtn = UIButton()
    
    //collection view data
    let giflinkStr = "https://media.giphy.com/media/26u4cqiYI30juCOGY/giphy.gif"
    let giflinkStr2 = "https://media.giphy.com/media/26u4cqiYI30juCOGY/giphy.gif"
    let giflinkStr3 = "https://media.giphy.com/media/26u4cqiYI30juCOGY/giphy.gif"
    var dataArr = [String]()
    
    var earnedTicketView = UIView()
    var earnedTicketBackgroundImgView = UIImageView()
    var lblAmntPaidTo = UILabel()
    var lblAmntPaid = UILabel()
    var lblNoOfTickets = UILabel()
    var ticketProgressBar = UIProgressView()
    var lblAutomatically = UILabel()
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    var howToEarnTicketView = UIView()
    var lblHeader = UILabel()
    var lblRoundUps = UILabel()
    var lblOneTimePayment = UILabel()
    private let line = UIView()
    var earnTicketTable = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .white
        self.contentView.isUserInteractionEnabled = true
        
        dataArr = [giflinkStr, giflinkStr3, giflinkStr, giflinkStr2, giflinkStr3, giflinkStr, giflinkStr3, giflinkStr3, giflinkStr2]

        setEarnedTicketView()
        setWeekPrizeView()
        setHowToEarnTicketView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setEarnedTicketView() {
        self.contentView.addSubview(earnedTicketView)
        earnedTicketView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
        }
        setEarnedTicketBackgroundImgView()
        setAmountPaidToLbl()
        setAmountPaidLbl()
        setLblNoOfTickets()
        setProgressBar()
        setAutomaticallyEnteredLbl()
    }
    
    private func setProgressBar() {
        var arrPointsRange = [0, 10, 20, 30, 40, 50]
        var currenPoint = 18
        let totalPoints = 50
        ticketProgressBar.progressImage = UIImage.init(named: "backgroundGrad")
        let dimension: CGFloat = 30
        ticketProgressBar.layer.cornerRadius = dimension / 2
        ticketProgressBar.clipsToBounds = true
        ticketProgressBar.progress = 0.18
        ticketProgressBar.trackTintColor = .progrssBarBackgroundColor
        earnedTicketView.addSubview(ticketProgressBar)
        ticketProgressBar.snp.makeConstraints{ make in
            make.top.equalTo(lblNoOfTickets.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
        }
    }
    
    private func setStackForProgress() {
        
    }

    private func setWeekPrizeView() {
        self.contentView.addSubview(weekPrizeView)
        weekPrizeView.snp.makeConstraints{ make in
            make.top.equalTo(earnedTicketView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            //            make.height.equalTo(self.frame.width * 2)
//            make.bottom.equalToSuperview().offset(-20)
        }
        setWeekPrizeBackgroundImgView()
        setWeekPrizeLbl()
        setInfoBtn()
        setWinAmountLbl(amount: "2,500")
        setAnnouncementLbl(day: "Tuesday", time: "9am")
        setPastWinnersLbl()
        setupCollectionView()
        setEarningTicketsBtn()
    }

    private func setHowToEarnTicketView() {
        howToEarnTicketView.layer.borderColor = UIColor.systemGray3.cgColor
        howToEarnTicketView.layer.borderWidth = 2
        howToEarnTicketView.layer.cornerRadius = 8
        self.contentView.addSubview(howToEarnTicketView)
        howToEarnTicketView.snp.makeConstraints{ make in
            make.top.equalTo(weekPrizeView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(180)
            make.bottom.equalToSuperview().offset(-20)
        }
        setEarnTicketTableView()
    }

    private func setWeekPrizeBackgroundImgView() {
        weekPrizeBackgroundImgView.image = UIImage.init(named: "backgroundGrad")
        weekPrizeBackgroundImgView.layer.cornerRadius = 8
        weekPrizeView.addSubview(weekPrizeBackgroundImgView)
        weekPrizeBackgroundImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setWeekPrizeLbl() {
        weekPrizeLbl.text = "This Week's Prize"
        weekPrizeLbl.numberOfLines = 1
        weekPrizeLbl.textColor = .white
        weekPrizeLbl.textAlignment = .left
        weekPrizeLbl.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        weekPrizeView.addSubview(weekPrizeLbl)
        weekPrizeLbl.snp.makeConstraints{ make in
            make.top.equalTo(weekPrizeBackgroundImgView.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setInfoBtn() {
        weekPrizeInfoBtn.setBackgroundImage(UIImage.init(named: "Info"), for: .normal)
        weekPrizeInfoBtn.addTarget(self,
                                   action: #selector(weekPrizeInfoBtnClicked),
                                   for: .touchUpInside)
        weekPrizeView.addSubview(weekPrizeInfoBtn)
        weekPrizeInfoBtn.snp.makeConstraints{ make in
            make.top.equalTo(weekPrizeBackgroundImgView.snp.top).offset(20)
            make.leading.equalTo(weekPrizeLbl.snp.trailing).offset(5)
            make.height.width.equalTo(25)
        }
    }
    
    @objc private func weekPrizeInfoBtnClicked() {
        print("weekPrizeInfoBtnClicked")
    }
    
    func setWinAmountLbl(amount : String) {
        winLbl.text = "WIN $\(amount) towards your student loans!"
        winLbl.numberOfLines = 3
        winLbl.textColor = UIColor.sunGlow
        winLbl.textAlignment = .left
        winLbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        weekPrizeView.addSubview(winLbl)
        winLbl.snp.makeConstraints{ make in
            make.top.equalTo(weekPrizeLbl.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(230)
        }
    }
    
    func setAnnouncementLbl(day: String, time: String) {
        announcementLbl.text = "The winner will be announced \(day) at \(time) PT"
        announcementLbl.numberOfLines = 2
        announcementLbl.textColor = .white
        announcementLbl.textAlignment = .left
        announcementLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        weekPrizeView.addSubview(announcementLbl)
        announcementLbl.snp.makeConstraints{ make in
            make.top.equalTo(winLbl.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setPastWinnersLbl() {
        pastWinnersLbl.text = "The Weekly Winners"
        pastWinnersLbl.numberOfLines = 0
        pastWinnersLbl.textColor = .white
        pastWinnersLbl.textAlignment = .left
        pastWinnersLbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        weekPrizeView.addSubview(pastWinnersLbl)
        pastWinnersLbl.snp.makeConstraints{ make in
            make.top.equalTo(announcementLbl.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: GalleryCollectionViewCell.self)
        weekPrizeView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(pastWinnersLbl.snp.bottom).offset(10)
            make.height.equalTo((contentView.frame.width) * 0.4)
        }
    }
    
    private func setEarningTicketsBtn() {
        earningTicketsBtn.setTitle("Start Earning Tickets", for: .normal)
        earningTicketsBtn.setTitleColor(.fuchsiaPink, for: .normal)
        earningTicketsBtn.addTarget(self,
                                    action: #selector(earningTicketsBtnClicked),
                                    for: .touchUpInside)
        let dimension: CGFloat = 50
        earningTicketsBtn.layer.cornerRadius = dimension / 2
        earningTicketsBtn.backgroundColor = .white
        weekPrizeView.addSubview(earningTicketsBtn)
        earningTicketsBtn.snp.makeConstraints{ make in
            make.height.equalTo(dimension)
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    @objc private func earningTicketsBtnClicked() {
        
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
        lblAmntPaidTo.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        earnedTicketView.addSubview(lblAmntPaidTo)
        lblAmntPaidTo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setAmountPaidLbl() {
        lblAmntPaid.text = "$" + "20.22"
        lblAmntPaid.textColor = .white
        lblAmntPaid.numberOfLines = 0
        lblAmntPaid.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        let dimension: CGFloat = 30
        earnedTicketView.addSubview(lblAmntPaid)
        lblAmntPaid.snp.makeConstraints{ make in
            make.top.equalTo(lblAmntPaidTo.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
        }
    }
    
    private func setLblNoOfTickets() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "tickets-alt")
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: " " + "3" + " Tickets ")
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
        lblNoOfTickets.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        lblAutomatically.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        earnedTicketView.addSubview(lblAutomatically)
        lblAutomatically.snp.makeConstraints{ make in
            make.top.equalTo(ticketProgressBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-20)
            
        }
    }
    
    private func setEarnTicketTableView() {
        earnTicketTable = UITableView()
        earnTicketTable.delegate = self
        earnTicketTable.dataSource = self
        earnTicketTable.backgroundColor = .white
        earnTicketTable.separatorStyle = .none
        earnTicketTable.allowsSelection = true
        earnTicketTable.register(cellType: EarnTicketCell.self)
        howToEarnTicketView.addSubview(earnTicketTable)
        earnTicketTable.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

}

extension PrizeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EarnTicketCell.self)
        if indexPath.row == 0{
            cell.setBackground(check: true)
            cell.setTitleLabel()
            cell.titleLabel.text = "How to earn tickets?"
            cell.titleLabel.textColor = .white
            cell.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            cell.setInfoBtn()
        } else if indexPath.row == 1 {
            cell.setLine()
            cell.setSetUpBtn()
            cell.setTitleLabel()
            cell.titleLabel.text = "Round Ups (2x Tickets)"
        } else if indexPath.row == 2 {
            cell.setSetUpBtn()
            cell.setTitleLabel()
            cell.titleLabel.text = "One Time Payment"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{

        }else{
            print("didSelectRowAt ",indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension PrizeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType:GalleryCollectionViewCell.self)
        
        //        if indexPath.row == 2{
        //            cell.imgView.image = UIImage.init(named: "viewAll")
        //        } else {
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicator.center = CGPoint(x: cell.imgView.bounds.size.width/2, y: cell.imgView.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        cell.imgView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async { [weak self] in
            
            if let gifURL : String = self?.dataArr[indexPath.row] {
                if let imagefromURL = UIImage.gifImageWithURL(gifURL) {
                    DispatchQueue.main.async {
                        
                        cell.imgView.image = imagefromURL
                        activityIndicator.stopAnimating()
                    }
                }
            }
        }
        //  }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2{
            //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewAll"), object: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (contentView.frame.width - 10) * 0.25, height: (contentView.frame.width - 10) * 0.4)
    }
}
