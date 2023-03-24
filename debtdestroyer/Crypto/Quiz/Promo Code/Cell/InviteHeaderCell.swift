//
//  InviteHeaderCell.swift
//  debtdestroyer
//
//  Created by DK on 3/24/23.
//

import UIKit
import Reusable

class InviteHeaderCell: UITableViewCell, Reusable {
    var headerLabel: UILabel!
    private var clickArrowImg: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeaderLabel()
        setupClickArrow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(label: String, isOpened: Bool) {
        headerLabel.text = label
        if isOpened {
            clickArrowImg.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        } else {
            clickArrowImg.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    private func setupHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.textAlignment = .left
        contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setupClickArrow() {
        if let image = UIImage(named: "chevron_down")?.withRenderingMode(.alwaysTemplate) {
            clickArrowImg = UIButton()
            clickArrowImg.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
            clickArrowImg.tintColor = .black
            clickArrowImg.setImage(image, for: .normal)
            clickArrowImg.imageView?.contentMode = .scaleAspectFit
            contentView.addSubview(clickArrowImg)
            clickArrowImg.snp.makeConstraints { make in
                make.centerY.top.bottom.equalTo(headerLabel)
                make.trailing.equalToSuperview().inset(5)
            }
        }
    }
}
