//
//  WeekPrizeCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/08/22.
//

import UIKit
import Reusable

class WeekPrizeCell: UITableViewCell, Reusable {
        
    var weekPrizeView = UIView()
    var weekPrizeBackgroundImgView = UIImageView()
    let weekPrizeLbl = UILabel()
    let weekPrizeInfoBtn = UIButton()
    let winLbl = UILabel()
    let announcementLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setWeekPrizeView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setWeekPrizeView() {
        weekPrizeView.backgroundColor = .clear
        self.contentView.addSubview(weekPrizeView)
        weekPrizeView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        setWeekPrizeBackgroundImgView()
        setWeekPrizeLbl()
        setInfoBtn()
        setWinAmountLbl()
        setAnnouncementLbl()
    }

    private func setWeekPrizeBackgroundImgView() {
        weekPrizeBackgroundImgView.image = UIImage.init(named: "backgroundGrad")
        weekPrizeBackgroundImgView.layer.cornerRadius = 8
        weekPrizeView.addSubview(weekPrizeBackgroundImgView)
        weekPrizeBackgroundImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(260).priority(.high)
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
    
    func setWinAmountLbl() {
        winLbl.text = "WIN $2,500 towards your student loans!"
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
    
    func setAnnouncementLbl() {
        announcementLbl.text = "The winner will be announced soon..!"
        announcementLbl.numberOfLines = 2
        announcementLbl.textColor = .white
        announcementLbl.textAlignment = .left
        announcementLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        weekPrizeView.addSubview(announcementLbl)
        announcementLbl.snp.makeConstraints{ make in
            make.top.equalTo(winLbl.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}

