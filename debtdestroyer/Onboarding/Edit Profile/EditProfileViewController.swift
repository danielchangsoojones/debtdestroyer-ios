//
//  EditProfileViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileViewController: UIViewController {
//    private var tableView: UITableView!
    private var messageHelper: MessageHelper?
    var editBtn = UIButton()
    var firstNameTxt = SkyFloatingLabelTextField()
    var lastNameTxt = SkyFloatingLabelTextField()
    var phNumberTxt = SkyFloatingLabelTextField()
    
    override func loadView() {
        super.loadView()
        let editProfileView = EditProfileView(frame: self.view.bounds)
        self.view = editProfileView
        self.firstNameTxt = editProfileView.firstNameTxt
        self.lastNameTxt = editProfileView.lastNameTxt
        self.phNumberTxt = editProfileView.phNumberTxt
        firstNameTxt.delegate = self
        lastNameTxt.delegate = self
        phNumberTxt.delegate = self
        self.editBtn = editProfileView.editBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Edit Account"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
//    private func setTableView() {
//        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
//        tableView.register(cellType: ProfileImageTableViewCell.self)
//        tableView.register(cellType: ProfileInfoEditTableViewCell.self)
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints{ make in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//    }

}

//extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProfileImageTableViewCell.self)
//
//        return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProfileInfoEditTableViewCell.self)
////            cell.firstNameTxt.delegate = self
////            cell.lastNameTxt.delegate = self
////            cell.firstNameTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//            return cell
//        }
//    }
//
//    @objc func textFieldDidChange(_ textfield: UITextField) {
//        if let text = textfield.text {
//
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}

extension EditProfileViewController : UITextFieldDelegate {
    
}
