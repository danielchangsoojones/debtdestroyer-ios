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
    "2QtmcNwbIF": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/intro_dangerous_city_2cn3ozp1lwf5864mxy5czvuh2fsua2l.mp4?ik-t=1682105645&ik-s=89b3ed41c0fef4d00fbc08bcf63c544a9c16bbb0", correct_answer_index: 2),
    "bDFNOEoafO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/money_sport_why_20vzpc29w0ewbolaburaicait3rpveq.mp4?ik-t=1682105645&ik-s=05edd169cd71d54a86e338dd71f01e6a9330e2dd", correct_answer_index: 3),
    "VIH9abp6fq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/money_sport_why_20vzpc29w0ewbolaburaicait3rpveq.mp4?ik-t=1682105645&ik-s=05edd169cd71d54a86e338dd71f01e6a9330e2dd", correct_answer_index: 3),
    "AOEwRIVcJz": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/rhyme_car_2ke0mk71ctiu8s3k4yuz6snypv5wwqm.mp4?ik-t=1682105646&ik-s=efcf9b4f15fb699bea7ad4be01c40a1b99542d17", correct_answer_index: 0),
    "DISP8AYi7W": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/school_meal_29ig8zbedpkwradjyxj60cw1uiy7giz.mp4?ik-t=1682105646&ik-s=1790e5dc70df580a2f930a96744bf9994a2c0da8", correct_answer_index: 1),
    "IftlRg4Nlq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/sleepover_act_2un1jsedlfzcesz7tgwfhjq6mk0whvg.mp4?ik-t=1682105646&ik-s=f61f844097d6afc72005b6ff4024bcf4cdbcc200", correct_answer_index: 1),
    "0qx8yq8V9v": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/souvenir_2667qj5nst5c1degziyk8iqzll4owb7.mp4?ik-t=1682105646&ik-s=66dae32fb7d5969ff7591cbedbeac29575890967", correct_answer_index: 3),
    "KNxN0Za3zK": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/state_m_2hn1qcxix7wziz520bh8fd2ji9v5y3r.mp4?ik-t=1682105647&ik-s=870ff0bc1e573cec5f1520849e8070a07be0c472", correct_answer_index: 0),
    "Ya1eUwQoIG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/underwear_2lhu9uhocl0vtag74u5j8cch1uj20w9.mp4?ik-t=1682105647&ik-s=8a29bc0138b77e2b78b67f338da17dfef34eb9ab", correct_answer_index: 0),
    "BG6uAc9nw6": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/worst_friend_2h3ht1cdj8qdlodlybhpblumc2xl4ll.mp4?ik-t=1682105647&ik-s=24ec637ea2c4565d26931ad6e87c313acdae19ef", correct_answer_index: 1),
    "NRHTByTGdR": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/breakfast_buffet_2zawcn5w17ea39kgcvkvcw067b5h9yf.mp4?ik-t=1682105647&ik-s=3b45f151c2bb8fa67e12588ae83be0fa0beca468", correct_answer_index: 3),
    "N21BfaSZML": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/french_country_2wzaylq6ukw09qpbirm810jz8o1e6bs.mp4?ik-t=1682105648&ik-s=52a07d1265e6a282578911a0af351ce55633e77a", correct_answer_index: 0),
    "4zhSVx9Oqz": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/kids_2h7gqgutgk0rzwfjg3nkem4v74i351g.mp4?ik-t=1682105648&ik-s=215820d43c2b021d6102f66eb2dcc4293f2e4700", correct_answer_index: 1),
    "1jBHHtOiPs": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/kids_why_2jk9tue7x1l8rjtcunaoydwd8ydyv6w.mp4?ik-t=1682105648&ik-s=5c8e501deeaacde4a601a4ce1199cf432e7a80ba", correct_answer_index: 1),
    "abKOEMOpGd": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Mw50xIv28L/mj_song_2w7ldhsugmahj2wixsqxtjzzvtb9djg.mp4?ik-t=1682105648&ik-s=2fd6aecb6579122f42bf0dccf48589b0a56e40cf", correct_answer_index: 3),
    "dJBy4GdzVr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/a_sex_sport_2ma457drdwr468exr6uoxpzswyd6i75.mp4?ik-t=1682105653&ik-s=1abe2747cf40fc45f578b9218743b7b3313bb5fd", correct_answer_index: 0),
    "eZFyM2DUwU": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/a_stars_24am625tlpamvkb2j80xkxxwxfivy63.mp4?ik-t=1682105653&ik-s=12c1e02bd854c3e29ba72bb4f76c89dec351ff48", correct_answer_index: 0),
    "ZfthoIefTA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_attractive_alive_2f3vpt1lijnewiccorc39g5mocije6b.mp4?ik-t=1682105654&ik-s=fc60f7d609a9c94ad668eb710d449e9387ca9f92", correct_answer_index: 0),
    "HfRbg9ULSs": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_bank_2yf73a7lde7h5kwo47s49bixtulv385.mp4?ik-t=1682105654&ik-s=bf686c6940067117b13775d5f50663cd328abfe1", correct_answer_index: 0),
    "Lqs0hiE5kv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_fashion_2yzngr5owhlzrr780zus6ykhoahu3im.mp4?ik-t=1682105654&ik-s=860c5bd7622371d879c61c19b52e03201abe0b40", correct_answer_index: 0),
    "CMX0CNuYs3": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_fav_food_22yfc0rpc36j1vc59ox3l3lm94pqyoa.mp4?ik-t=1682105654&ik-s=fecfa04818fcf97fec50a0c5178ff7fcff679432", correct_answer_index: 0),
    "rAvOB1PLjx": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_lang_21xphvjh8rkoh2133h8q9v54ihjwnz6.mp4?ik-t=1682105655&ik-s=cd521d26bafd93a01c5f4e05c65274d6b8f0626f", correct_answer_index: 0),
    "4gKeHg6Afr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_plane_crash_279yja1znmqmng00eq4dh0zw8xomovj.mp4?ik-t=1682105655&ik-s=5309f1a2ab301be7bffb6b59ae25746289ca4ef1", correct_answer_index: 1),
    "2yhEoXMJyT": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_rate_self_27ujahuw3mxcpjqwwas17yuqp3bd1nx.mp4?ik-t=1682105655&ik-s=dc5d2a8b46ea42284a72ce74f123ba2bec3d3719", correct_answer_index: 0),
    "UBMoQ4Z3HE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_sex_sport_2avu7ka0ycsmxe10y2seakskpnv2qcr.mp4.mp4?ik-t=1682105656&ik-s=d8df320ae1c91031db669b8871cbd6e87a423c06", correct_answer_index: 1),
    "3viEAJtORt": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/b_snap_score_2ozl6z3ziguticb3xltvbm5ieow5xey.mp4?ik-t=1682105656&ik-s=19fd6c5769031ca23b6d5d473afffe8f465bf21d", correct_answer_index: 0)
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
