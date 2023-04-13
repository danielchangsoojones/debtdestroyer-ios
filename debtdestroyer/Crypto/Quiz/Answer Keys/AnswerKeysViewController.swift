//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] =
    [
        "QT3WlnCvau": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/money_sport_why_20vzpc29w0ewbolaburaicait3rpveq.mp4?ik-t=1682018738&ik-s=a6ac14722078fb9116ed7c5eadc25a3919404447", correct_answer_index: 2),
        "dDI4se4LyS": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/money_sport_why_20vzpc29w0ewbolaburaicait3rpveq.mp4?ik-t=1682018739&ik-s=fae1ffe25efa4b2ad51a5248120ac44ee97a2bb8", correct_answer_index: 3),
        "WBSTKpmfcn": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/rhyme_car_2ke0mk71ctiu8s3k4yuz6snypv5wwqm.mp4?ik-t=1682018739&ik-s=a0e65120e8936902853cbc0e8b0234fef3edac02", correct_answer_index: 2),
        "Pl0DLYXAGP": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/school_meal_29ig8zbedpkwradjyxj60cw1uiy7giz.mp4?ik-t=1682018739&ik-s=22c858e79a617659e56e3bb937f3513410a23f25", correct_answer_index: 0),
        "1F5g6TKIM6": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/sleepover_act_2un1jsedlfzcesz7tgwfhjq6mk0whvg.mp4?ik-t=1682018740&ik-s=014486b456c84d6e58429951f02ec2e82a03ec73", correct_answer_index: 3),
        "vA3dEWIHIp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/souvenir_2667qj5nst5c1degziyk8iqzll4owb7.mp4?ik-t=1682018740&ik-s=e3865d51257bbdcc8e45d06c59bd62b30035abe2", correct_answer_index: 2),
        "UTKcbWyNuq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/state_m_2hn1qcxix7wziz520bh8fd2ji9v5y3r.mp4?ik-t=1682018740&ik-s=2d13fdc3ef430cf1ba926cc82d639a6986dc74fd", correct_answer_index: 2),
        "HyhqtUkbIJ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/underwear_2lhu9uhocl0vtag74u5j8cch1uj20w9.mp4?ik-t=1682018740&ik-s=e994aa73162fc86d5ae2b6dcc2999b06d570cf14", correct_answer_index: 3),
        "h1KBSaTdIE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/worst_friend_2h3ht1cdj8qdlodlybhpblumc2xl4ll.mp4?ik-t=1682018741&ik-s=2019b71052742514866c137e40272978697eedeb", correct_answer_index: 3),
        "mJUWXbmWQo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/a_sex_sport_2ma457drdwr468exr6uoxpzswyd6i75.mp4?ik-t=1682018747&ik-s=5c498ab10ea5eab581949ac7c40e5b0ed813b293", correct_answer_index: 1),
        "wSbXjao171": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/a_stars_24am625tlpamvkb2j80xkxxwxfivy63.mp4?ik-t=1682018747&ik-s=86d6529c073ddcb521eef2c25bb54cf3b481266c", correct_answer_index: 1),
        "5pE6GMloES": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_attractive_alive_2f3vpt1lijnewiccorc39g5mocije6b.mp4?ik-t=1682018747&ik-s=366f30fc7857d7cb1758158bc17a4e77132bb810", correct_answer_index: 1),
        "3sjihIh4oQ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_bank_2yf73a7lde7h5kwo47s49bixtulv385.mp4?ik-t=1682018748&ik-s=12d002152c99358869264d3d45e4ed19e44b5249", correct_answer_index: 1),
        "ko3as2mPD0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_fashion_2yzngr5owhlzrr780zus6ykhoahu3im.mp4?ik-t=1682018748&ik-s=dce6933b26a1698970459e37ba39b8fbc3213cb2", correct_answer_index: 1),
        "n0CoxWTGDp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_fav_food_22yfc0rpc36j1vc59ox3l3lm94pqyoa.mp4?ik-t=1682018748&ik-s=f458a807dd616cb8fc811b065b2e9945a8a5bbdb", correct_answer_index: 0),
        "ddrqFzthPA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_lang_21xphvjh8rkoh2133h8q9v54ihjwnz6.mp4?ik-t=1682018748&ik-s=ca3487170ed5a0544ca085798900ea5f6fcbadf1", correct_answer_index: 0),
        "YnIt5kXJuL": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_plane_crash_279yja1znmqmng00eq4dh0zw8xomovj.mp4?ik-t=1682018749&ik-s=73bb3abe846989f7a2097ec21b8f128344c7d3e2", correct_answer_index: 0),
        "WHqhviojeo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_rate_self_27ujahuw3mxcpjqwwas17yuqp3bd1nx.mp4?ik-t=1682018749&ik-s=9809b23e795fa149cca4633c7e0100ea67cbaad9", correct_answer_index: 0),
        "OklZdJfF9F": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_sex_sport_2avu7ka0ycsmxe10y2seakskpnv2qcr.mp4.mp4?ik-t=1682018749&ik-s=7a624f356d37624664fad261b9e28fae9140e478", correct_answer_index: 0),
        "LU4i5zKyiJ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_snap_score_2ozl6z3ziguticb3xltvbm5ieow5xey.mp4?ik-t=1682018750&ik-s=156be82a5ea30623a8c9ebfbe82dc5670a8b6f95", correct_answer_index: 0)
    ]
    
    static func getItem(withId id: String) -> (answer_url: String, correct_answer_index: Int)? {
        if let item = answer_dict[id] {
            return item
        } else {
            return nil
        }
    }
    
    private var tableView: UITableView!
    var dataArr = [String]()
    
    override func loadView() {
        super.loadView()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Answer Keys"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }

    private func setTableView() {
        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

}
//
//extension AnswerKeysViewController: UITableViewDataSource, UITableViewDelegate {
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 1
////    }
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return AnswerKeysViewController.correct_indices.count
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
////        let correctAnswerIndexStr = String(AnswerKeysViewController.correct_indices[indexPath.row])
////        cell.textLabel?.text = correctAnswerIndexStr + " & " + AnswerKeysViewController.answer_video_urls[indexPath.row]
////        return cell
////    }
////
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////    }
//
//}
