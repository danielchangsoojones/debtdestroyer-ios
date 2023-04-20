//
//  InputChatView.swift
//  debtdestroyer
//
//  Created by DK on 4/19/23.
//

import UIKit
import GrowingTextView
import SnapKit

class InputChatView: UIView {
    let topOffset: CGFloat = 8
    let originalBottomConstraint: CGFloat = 8
    var bottomConstraint: Constraint?
    
    let textView: GrowingTextView = {
        let textView = GrowingTextView()
        textView.maxHeight = 150
        textView.minHeight = 40
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.placeholder = "Send a message..."
        return textView
    }()
    
    let sendButton: UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "send_message")?.withRenderingMode(.alwaysTemplate) {
            btn.setImage(image, for: .normal)
            btn.tintColor = .white
            btn.imageView?.contentMode = .scaleAspectFit
        }
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(sendButton)
        addSubview(textView)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalTo(textView)
            make.width.height.equalTo(50)
        }
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.top.equalToSuperview().inset(topOffset)
            self.bottomConstraint = make.bottom.equalToSuperview().inset(originalBottomConstraint).constraint
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
