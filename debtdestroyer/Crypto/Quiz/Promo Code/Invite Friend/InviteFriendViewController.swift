//
//  PromoCodeViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 23/02/23.
//

import UIKit
import Contacts
import MessageUI

class InviteFriendViewController: UIViewController {
    private let dataStore = PromoDataStore()
//    private var promoAttributedText: NSAttributedString!
    private var promoInfoLabelText: String!
    private var promoUsers: [PromoUser] = []
    private var tableView: UITableView!
    private var contactStore = CNContactStore()
    private var contacts = [CNContact]()
    private var inviteMsg = ""
    private var messageHelper: MessageHelper?
    private var retrievedContacts: [RetrievedContact] = []
    private var filteredRetrievedContacts: [RetrievedContact] = []
    private var refreshControl = UIRefreshControl()
    private var hasAccessPermission: Bool = false
    private var selectedContact: FriendContactParse? = nil
    private var theSpinnerContainer: UIView!
    private var shareButton: UIButton!
    private var infoSections = [InfoSection]()
    private var shouldShowCloseBtn: Bool!
    
    class PromoUser {
        let user: User
        
        init(user: User) {
            self.user = user
        }
    }
    
    class InfoSection {
        let title: String
        let options: [String]
        var isOpened: Bool = true
        
        init(title: String,
             options: [String],
             isOpened: Bool = true) {
            self.title = title
            self.options = options
            self.isOpened = isOpened
        }
    }
    
    init(shouldShowCloseBtn: Bool) {
        self.shouldShowCloseBtn = shouldShowCloseBtn
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let promoCodeView = InviteFriendView(frame: self.view.frame)
        self.view = promoCodeView
        self.theSpinnerContainer = promoCodeView.theSpinnerContainer
        self.tableView = promoCodeView.tableView
        self.tableView.addSubview(refreshControl)
        self.shareButton = promoCodeView.shareButton
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: InviteInfoCell.self)
        tableView.register(cellType: InviteHeaderCell.self)
        tableView.register(cellType: InviteContactCell.self)
        tableView.register(cellType: InviteJoinedCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Code: \(User.current()?.personalPromo ?? "")"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = ""
        messageHelper = MessageHelper(currentVC: self)
        messageHelper?.messageDelegate = self
        getContactAccess()
        hideKeyboardWhenTappedAround()
        setCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        Haptics.shared.play(.heavy)
        sender.endRefreshing()
    }
    
    @objc private func shareButtonPressed() {
        Haptics.shared.play(.medium)
        let currentUserName = (User.current()?.firstName ?? "").replacingOccurrences(of: " ", with: "")
        let activityViewController = UIActivityViewController(
            activityItems: ["Yo, get this app & use my promo code '\(User.current()?.personalPromo ?? "")'! There’s a 15 question trivia every day at 6PM Pacific Time and if you get all questions correct, you win $15,000!\n\nhttps://debt-destroyer-production.herokuapp.com/referral?name=\(currentUserName)&code=\(User.current()?.personalPromo ?? "")"],
            applicationActivities: nil
        )
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.shareButton
            popoverController.sourceRect = self.shareButton.bounds
            popoverController.permittedArrowDirections = .any
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func setCloseButton() {
        if shouldShowCloseBtn {
            let closeBtn = UIBarButtonItem.init(title: "Close", style: .done, target: self, action: #selector(closeBtnPressed))
            navigationItem.rightBarButtonItem = closeBtn
            self.navigationController?.navigationBar.isHidden = false
            self.navigationItem.hidesBackButton = true
        }
    }
    
    @objc func closeBtnPressed(_ sender: UIRefreshControl) {
        Haptics.shared.play(.light)
        let tabBarVC = presentingViewController as? UITabBarController
        tabBarVC?.selectedIndex = 1
        dismiss(animated: true)
    }
    
    private func loadContacts() {
        if (!hasAccessPermission && self.retrievedContacts.count == 0) {
            let alert = UIAlertController(title: "Contact Access Needed", message: "To invite friends, please update the contact access permissions in the Settings!", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }))

            self.present(alert, animated: true, completion: nil)
        }
        
        dataStore.loadFriendContacts(contacts: self.contacts) { promoUsers, personalPromo, promo_info_str, retrievedContacts in
            self.theSpinnerContainer.isHidden = true
//            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
//            let underlineAttributedString = NSAttributedString(string: personalPromo, attributes: underlineAttribute)
//            self.promoAttributedText = underlineAttributedString
            self.promoInfoLabelText = promo_info_str
            let currentUserName = (User.current()?.firstName ?? "").replacingOccurrences(of: " ", with: "")
            self.inviteMsg = "Yo, get this app & use my promo code '\(personalPromo)'! There’s a 15 question trivia every day at 6PM Pacific Time and if you get all questions correct, you win $15,000!\n\nhttps://debt-destroyer-production.herokuapp.com/referral?name=\(currentUserName)&code=\(personalPromo)"
            self.promoUsers = promoUsers
            if self.hasAccessPermission {
                self.retrievedContacts = retrievedContacts
                self.filteredRetrievedContacts = retrievedContacts
            }
            
            self.infoSections = [
                InfoSection(title: "", options: []),
                InfoSection(title: "Referred (\(promoUsers.count))", options: self.promoUsers.compactMap({ return "Cell \($0)" })),
                InfoSection(title: "Invite Friends (\(retrievedContacts.count))", options: self.retrievedContacts.compactMap({ return "Cell \($0)" }))
            ]
            
            self.tableView.reloadData()
        }
    }
    
    private func getContactAccess() {
        contactStore.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                self.hasAccessPermission = granted
                DispatchQueue.global(qos: .background).async {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    do {
                        try self.contactStore.enumerateContacts(with: request) { (contact, stop) in
                            self.contacts.append(contact)
                        }
                        DispatchQueue.main.async {
                            self.loadContacts()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            BannerAlert.show(title: "Error syncing contacts. Please text the Debt Destroyer team at 317-690-5323!", subtitle: error.localizedDescription, type: .error)
                        }
                    }
                }
            } else {
                self.hasAccessPermission = false
                DispatchQueue.main.async {
                    self.loadContacts()
                }
            }
        }
    }
}

extension InviteFriendViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            let infoSection = infoSections[section]
            if infoSection.isOpened {
                return infoSection.options.count + 1
            } else {
                return 1
            }
        } else {
            let infoSection = infoSections[section]
            if infoSection.isOpened {
                return filteredRetrievedContacts.count + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //Showing promo info (how it works) + search bar
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InviteInfoCell.self)
            cell.set(subtitle: promoInfoLabelText)
            cell.searchBar.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            if indexPath.row == 0 {
                //Showing section header
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InviteHeaderCell.self)
                cell.set(label: infoSections[indexPath.section].title, isOpened: infoSections[indexPath.section].isOpened)
                cell.selectionStyle = .none
                return cell
            } else {
                if indexPath.section == 1 {
                    //Showing joined friends
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InviteJoinedCell.self)
                    let promoUser = promoUsers[indexPath.row - 1]
                    cell.set(name: promoUser.user.firstName + " " + promoUser.user.lastName, friendCount: 0)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    //Showing friends to invite
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InviteContactCell.self)
                    let rectrievedContact = filteredRetrievedContacts[indexPath.row - 1]
                    let contact = rectrievedContact.contact
                    let overlapCount = rectrievedContact.count
                    cell.startTextAction = {
                        let contact = rectrievedContact.contact
                        self.selectedContact = contact
                        self.messageHelper?.text(contact.phoneNumber, body: self.inviteMsg)
                    }
                    cell.set(name: contact.firstName + " " + contact.lastName, friendCount: overlapCount)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            infoSections[indexPath.section].isOpened = !infoSections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        let scrollFrameHeight = scrollView.frame.size.height
        if (scrollOffset + scrollFrameHeight) >= contentHeight {
            refreshControl.beginRefreshing()
            refreshData(refreshControl)
        }
    }
}

extension InviteFriendViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        infoSections[1].isOpened = searchText.isEmpty
        filteredRetrievedContacts = searchText.isEmpty ? retrievedContacts : retrievedContacts.filter({ (retrievedContact: RetrievedContact) -> Bool in
            let contactName = retrievedContact.contact.firstName + retrievedContact.contact.lastName
            return contactName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadSections([1, 2], with: .none)
    }
}

extension InviteFriendViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent:
            controller.dismiss(animated: false, completion: nil)
            BannerAlert.show(title: "Invite Sent", subtitle: "", type: .success)
            if let contact = selectedContact {
                self.dataStore.setTextedFriend(textedContactObjectId: contact.objectId ?? "") {
                    print("successfully set friend as texted")
                }
            }
        case .cancelled:
            controller.dismiss(animated: true, completion: nil)
        case .failed:
            controller.dismiss(animated: true, completion: nil)
            BannerAlert.show(title: "Message Error", subtitle: "Error sending invite text", type: .error)
        @unknown default:
            BannerAlert.show(title: "Error", subtitle: "Please text the team at 317-690-5323, 'Error with message helper'", type: .error)
        }
        
        //we need to reset the VC so that the phone #/body values are reset
        messageHelper = MessageHelper(currentVC: self)
    }
}