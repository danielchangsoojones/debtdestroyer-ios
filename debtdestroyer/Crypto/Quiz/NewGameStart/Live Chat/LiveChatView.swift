//
//  LiveChatView.swift
//  debtdestroyer
//
//  Created by DK on 4/18/23.
//

import UIKit

class LiveChatView: UIView {
    var videoContainer = UIView()
    private var titleLabel: UILabel!
    var timerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setContainerForVideo()
        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerForVideo() {
        addSubview(videoContainer)
        videoContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setLabels() {
        titleLabel = UILabel()
        titleLabel.text = "$15,000 GAME STARTS IN"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        videoContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin).inset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        timerLabel = UILabel()
        timerLabel.text = ""
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.font = .systemFont(ofSize: 30, weight: .bold)
        videoContainer.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
