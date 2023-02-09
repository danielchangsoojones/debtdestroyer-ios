import UIKit
import SnapKit

class SignUpCoordinator: NSObject, OnboardingDataStoreDelegate {
    static let shared = SignUpCoordinator()
    var currentIndex = -1
    private var dataStore: OnboardingDataStore!
    let flowMap: [String: UIViewController] = [
        "emailPassword": RegisterViewController(),
        "phoneNumber": CreateProfileViewController(),
        "name": NameViewController(),
        "signUpCode": AddressViewController(),
    ]
    
    func reset() {
        dataStore = OnboardingDataStore(delegate: self)
        currentIndex = -1
    }
    
    func next(_ vc: FrigadePage) {
        let nextIndex = currentIndex + 1
        let pages = FrigadeHelper.shared.signUpFlow?.getData() ?? []
        if nextIndex == pages.count {
            completeSignUp(vc)
            return
        }
        if (pages.indices.contains(nextIndex)) {
            let nextPage = pages[nextIndex]
            // Check if type is found in flowMap
            if let pageType = nextPage.type {
                if let nextVc = flowMap[pageType] {
                    currentIndex = nextIndex
                    vc.navigationController?.pushViewController(nextVc, animated: true)
                }
            }
        }
    }
    
    func back(_ vc: FrigadePage) {
        currentIndex = currentIndex - 1
        vc.navigationController?.popViewController(animated: true)
    }
    
    func completeSignUp(_ vc: FrigadePage) {
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
        let firstName = UserDefaults.standard.string(forKey: OnboardingKeys.firstName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: OnboardingKeys.lastName) ?? ""
        let promoCode = UserDefaults.standard.string(forKey: OnboardingKeys.promoCode) ?? ""
        dataStore.register(email: email, password: password) {
            let ct = CryptoTabBarViewController()
            ct.modalPresentationStyle = .fullScreen
            vc.present(ct, animated: true, completion: nil)
            self.dataStore.save(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName, promoCode: promoCode) {
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "password")
                UserDefaults.standard.removeObject(forKey: "phoneNumber")
                UserDefaults.standard.removeObject(forKey: OnboardingKeys.firstName)
                UserDefaults.standard.removeObject(forKey: OnboardingKeys.lastName)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func segueIntoApp() {
        
    }
    
    func showError(title: String, subtitle: String) {
        
    }
}
