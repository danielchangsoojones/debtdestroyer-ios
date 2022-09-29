//
//  ChampionsListView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class ChampionsListView: UIView {
    let lineView = UIView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLineView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLineView() {
        lineView.backgroundColor = .black
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(2)
            make.centerX.equalToSuperview()
        }
    }
    
}
