//
//  EarnTicketCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 09/08/22.
//

import UIKit
import Reusable
import SCLAlertView

class EarnTicketCell: UITableViewCell, Reusable {

    let titleLabel = UILabel()
    private let line = UIView()
    let infoBtn = UIButton()
    let setUpBtn = UIButton()

    let chevronImageView = UIImageView(image: UIImage(named: "chevronGrey"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setTitleLabel()
        setChevron()
    }
    
    func setTitleLabel() {
        titleLabel.font = UIFont.MontserratSemiBold(size: 16)
        titleLabel.textColor = .jaguarBlack
        let dimension: CGFloat = 40
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(dimension).priority(.high)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setBackground(check: Bool){
        if check {
            let imageview = UIImageView.init(image: UIImage.init(named: "howToB"))
            imageview.contentMode = .scaleToFill
            contentView.addSubview(imageview)
            imageview.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(80).priority(.high)
            }
        }
      
    }
    
    func setInfoBtn() {
        infoBtn.setBackgroundImage(UIImage.init(named: "Info"), for: .normal)
        infoBtn.addTarget(self,
                                   action: #selector(howToEarnInfoBtnClicked),
                                   for: .touchUpInside)
        contentView.addSubview(infoBtn)
        infoBtn.snp.makeConstraints{ make in
//            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.height.width.equalTo(25)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func howToEarnInfoBtnClicked() {
        print("howToEarnInfoBtnClicked")
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
    
    func setSetUpBtn() {
        setUpBtn.setBackgroundImage(UIImage.init(named: "setUpBack"), for: .normal)
        setUpBtn.setTitle("Set up", for: .normal)

        setUpBtn.addTarget(PrizeViewController.self,
                          action: #selector(setUpBtnClicked),
                          for: .touchUpInside)
        contentView.addSubview(setUpBtn)
        setUpBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-10)
            make.height.equalTo(22)
            make.width.equalTo(70)

        }
    }
    
    @objc private func setUpBtnClicked() {
        print("setUpBtnClicked")
    }
    
    func setLine() {
            line.backgroundColor = .systemGray3
            contentView.addSubview(line)
            line.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(10)
                make.height.equalTo(2)
                make.bottom.equalToSuperview()
            }
    }
    
    private func setChevron() {
        chevronImageView.contentMode = .scaleAspectFit
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        let imageview = UIImageView.init(image: UIImage.init(named: "howToB"))
//        imageview.contentMode = .scaleToFill
//        headerView.addSubview(imageview)
//        imageview.frame = headerView.bounds
////        imageview.snp.makeConstraints{ make in
////            make.top.bottom.equalToSuperview()
////            make.leading.trailing.equalToSuperview()
////        }
//
//        let label = UILabel()
//        label.text = "How to earn tickets?"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .white
//        label.backgroundColor = .clear
//
//        headerView.addSubview(label)
//        label.snp.makeConstraints{ make in
//            make.top.bottom.equalToSuperview().offset(20)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(50)
//        }
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
