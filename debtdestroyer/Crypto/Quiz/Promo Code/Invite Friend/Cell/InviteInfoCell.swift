//
//  InviteInfoCell.swift
//  debtdestroyer
//
//  Created by DK on 3/24/23.
//

import UIKit
import Reusable

class InviteInfoCell: UITableViewCell, Reusable {
    private var titleLabel: UILabel!
    private var promoInfoLabel: UILabel!
    var shareButton: UIButton!
    var searchBar: UISearchBar!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //TODO: we can delete this <-- check for datastore function
    func set(subtitle: String) {}
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .white
        searchBar.barTintColor = .black
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(string: "Search friends", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
            if let searchIcon = textField.leftView as? UIImageView {
                searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
                searchIcon.tintColor = .white
            }
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = .white
            }
        }
        
        contentView.addSubview(searchBar)
        searchBar.placeholder = "Search friends"
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(15)
        }
    }
}
