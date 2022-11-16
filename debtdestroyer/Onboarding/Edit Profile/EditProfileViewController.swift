//
//  EditProfileViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileViewController: UIViewController {
    private var messageHelper: MessageHelper?
    let profileImg = UIImageView()
    var editBtn = UIButton()
    var firstNameTxt = SkyFloatingLabelTextField()
    var lastNameTxt = SkyFloatingLabelTextField()
    var phNumberTxt = SkyFloatingLabelTextField()
    var emailTxt = SkyFloatingLabelTextField()
    var passwordTxt = SkyFloatingLabelTextField()
    var imagePickedBase64       = ""
    var currentSelectedImage: UIImage?
    var imageAsData : Any!
    var popOver : UIPopoverPresentationController?

    override func loadView() {
        super.loadView()
        let editProfileView = EditProfileView(frame: self.view.bounds)
        self.view = editProfileView
        self.firstNameTxt = editProfileView.firstNameTxt
        self.lastNameTxt = editProfileView.lastNameTxt
        self.phNumberTxt = editProfileView.phNumberTxt
        self.emailTxt = editProfileView.emailTxt
        self.passwordTxt = editProfileView.passwordTxt
        firstNameTxt.delegate = self
        lastNameTxt.delegate = self
        phNumberTxt.delegate = self
        emailTxt.delegate = self
        passwordTxt.delegate = self
        self.editBtn = editProfileView.editBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        self.hideKeyboardWhenTappedAround()
        self.editBtn.addTarget(self, action: #selector(editImageBtnClicked), for: .touchUpInside)
        self.loadData()
        
        self.navigationItem.title = "Edit Account"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func loadData() {
        self.passwordTxt.isSecureTextEntry = true
        self.firstNameTxt.text = User.current()?.firstName
        self.lastNameTxt.text = User.current()?.lastName
        self.phNumberTxt.text = User.current()?.phoneNumber
        self.emailTxt.text = User.current()?.email
        self.passwordTxt.text = User.current()?.password
    }
    
    @objc private func editImageBtnClicked() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        {
            self.popOver = UIPopoverPresentationController(presentedViewController: self, presenting: alert)
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension EditProfileViewController : UITextFieldDelegate {
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Image Picked.")
        
        if picker.sourceType == UIImagePickerController.SourceType.photoLibrary {
            
            currentSelectedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            imageAsData = currentSelectedImage!.pngData() as NSData?? as Any
            
            
            let imageUrl      = info[UIImagePickerController.InfoKey.imageURL.rawValue] as? NSURL
            let imageName     = imageUrl?.lastPathComponent
            print("ImageName : \(String(describing: imageName))")
        }
        else {
            
            let tempImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            
            if tempImage != nil {
                
                currentSelectedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
                imageAsData = currentSelectedImage!.pngData() as NSData?? as Any
                
                let timestamp: String = "\(Int(NSDate().timeIntervalSince1970))"
                let statementImageName = "STMT_IMG_\(timestamp).JPG"
                print("Image Name : \(statementImageName)")
                currentSelectedImage = tempImage
            }
        }
        
        if let imageBase64 = currentSelectedImage!.jpegData(compressionQuality: 0.5)?.base64EncodedString() {
            
            imagePickedBase64 = imageBase64
        }
        
        profileImg.image = currentSelectedImage
        
        //        let imageCroper = TOCropViewController(image: profileImageView.image!)
        //        imageCroper.delegate = self
        dismiss(animated: true, completion: nil)
        
        
        //    present(imageCroper, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}
