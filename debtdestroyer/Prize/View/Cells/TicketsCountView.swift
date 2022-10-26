//
//  TicketsCountView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 10/25/22.
//

import UIKit

class TicketsCountView: UIView {
    private let label = UILabel()
    private let imgView = UIImageView()

    init(ticketsCount: Int) {
        super.init(frame: .zero)
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        setTicketImage()
        setLabel(ticketsCount: ticketsCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabel(ticketsCount: Int) {
        label.text = "\(ticketsCount) Tickets"
        label.textColor = .black
        label.font = UIFont.MontserratSemiBold(size: 16)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(imgView.snp.leading).offset(-5)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setTicketImage() {
        imgView.image = UIImage.init(named: "ticketC")
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
}
