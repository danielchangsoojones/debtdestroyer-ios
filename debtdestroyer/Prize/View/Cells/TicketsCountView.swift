//
//  TicketsCountView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 10/25/22.
//

import UIKit

class TicketsCountView: UIView {
    private let label = UILabel()
    
    init(ticketsCount: Int) {
        super.init(frame: .zero)
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        setLabel(ticketsCount: ticketsCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabel(ticketsCount: Int) {
        label.text = "\(ticketsCount) Tickets"
        label.textColor = .black
        label.font = UIFont.MontserratSemiBold(size: 20)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
