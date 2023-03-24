//
//  TieBreakerViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 3/17/23.
//

import UIKit

class TieBreakerViewController: UIViewController {
    private var descriptionLbl: UILabel!
    private let dataStore = TieBreakerDataStore()
    private var quizDatas: [QuizDataParse] = []
    private let competing_tie_user_ids: [String]
    private var timer: Timer?
    private var count = 0
    
    init(competing_tie_user_ids: [String]) {
        self.competing_tie_user_ids = competing_tie_user_ids
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let tiebreakerView = TieBreakerView(frame: self.view.frame)
        self.view = tiebreakerView
        self.descriptionLbl = tiebreakerView.descriptionLbl
//        self.tableView = promoCodeView.tableView
//        promoCodeView.tableView.delegate = self
//        promoCodeView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLbl.text = "You tied for 5th place with \(self.competing_tie_user_ids.count) other people to win $10! Time to enter the tiebreaker round to decide the 5th place winner! Don't leave this screen - the tiebreaker round will automatically start in 8 seconds. Get ready!"
        if User.isAdminUser {
            loadData()
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicStyle")
    }
    
    @objc private func fireTimer() {
        if count == 3 && !User.isAdminUser {
            loadData()
        } else if count == 7 {
            self.timer?.invalidate()
            self.segueIntoQuestionVC()
        }
        count = count + 1
    }
    
    private func loadData() {
        dataStore.getTieQuizDatas { quizDatas in
            self.quizDatas = quizDatas
            let timerCount = 8 - self.count
            self.descriptionLbl.text = "You tied for 5th place with \(self.competing_tie_user_ids.count) other people to win $10! Time to enter the tiebreaker round to decide the 5th place winner! Don't leave this screen - the tiebreaker round will automatically start in \(timerCount) seconds. Get ready!"
        }
    }
    
    private func segueIntoQuestionVC() {
        let questionVC = QuestionWithAnswerRevealGoTinyViewController(quizDatas: quizDatas,
                                                                      currentIndex: 0,
                                                                      competing_tie_user_ids: competing_tie_user_ids,
                                                                      inTieMode: true)
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
}

//TODO: i'm sure this vc will have a tableview to show all tied users later
//extension PromoCodeUsedViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return promoUsers.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let promoUser = promoUsers[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
//        cell.textLabel?.text = promoUser.user.fullName
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//
//        let label = UILabel()
//        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//        label.text = "Your Invited Friends"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
//        headerView.addSubview(label)
//
//        return headerView
//    }
//}

