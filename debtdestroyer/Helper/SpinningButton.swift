//
//  SpinningButton.swift
//  lookbook
//
//  Created by Daniel Jones on 2/23/22.
//

import UIKit

class SpinningButton: UIButton {
    private let spinner = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSpinner()
        setTitle("", for: .disabled)
        backgroundColor = .white
        setTitleColor(.babyPurple, for: .normal)
        layer.cornerRadius = 20
        
//        setOriginalInsets()
    }
    
    private func setOriginalInsets() {
        let edgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        set(edgeInsets: edgeInsets)
    }
    
    private func set(edgeInsets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            if self.configuration == nil {
                var filled = UIButton.Configuration.plain()
                filled.contentInsets = NSDirectionalEdgeInsets(top: edgeInsets.top,
                                                               leading: edgeInsets.left,
                                                               bottom: edgeInsets.bottom,
                                                               trailing: edgeInsets.right)
                configuration = filled
            } else {
                self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: edgeInsets.top,
                                                                            leading: edgeInsets.left,
                                                                            bottom: edgeInsets.bottom,
                                                                            trailing: edgeInsets.right)
            }
        } else {
            contentEdgeInsets = edgeInsets
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinning() {
        set(edgeInsets: UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50))
        spinner.startAnimating()
        isEnabled = false
    }
    
    func stopSpinning() {
        setOriginalInsets()
        spinner.stopAnimating()
        isEnabled = true
    }
    
    private func setSpinner() {
        spinner.color = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
}
