import UIKit
import SnapKit
import Kingfisher

class NotificationPermViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        emailTextField.isHidden = true
        emailLabel.isHidden = true
        passwordTextField.isHidden = true
        passwordLabel.isHidden = true
        if let data = getPageData() {
            // Set title
            titleLabel.text = data.title
            titleLabel.isHidden = false
            if let subtitle = data.subtitle {
                subtitleLabel.text = subtitle
                subtitleLabel.isHidden = false
            }
            if let url = data.imageUri {
                imageView.kf.setImage(with: url)
                imageView.isHidden = false
            }
        }

    }

    override func nextBtnPressed() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else {
                self.next()
                return
            }
            print("Succesfully enabled push")
            self.next()
        }
    }

}
