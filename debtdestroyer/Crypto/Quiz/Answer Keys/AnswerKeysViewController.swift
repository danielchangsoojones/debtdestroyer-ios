//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "x3jQVDlzji": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/intro_m_state_2t1sltabg3qkwyrrgij8qedyvutlxio.mp4?ik-t=1681513569&ik-s=2b353eb58405178e4abe111054e1779955aaa364", correct_answer_index: 0),
        "yJub3nyUHL": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/disney_2gcd5ujnhuk1huopy3ais0cnisutzr8.mp4?ik-t=1681513569&ik-s=69a47dff2fb64f4a1804cee101600047b717449d", correct_answer_index: 0),
        "vGDUGAsg9m": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/book_23qt12dru9bitf6af6ao7d1vljr8g2b.mp4?ik-t=1681513569&ik-s=941aed4e3705d880c1d4c6f79c12bcd7de180373", correct_answer_index: 1),
        "foI6wy7VGL": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/election_rhyme_2tkx22g3xinojndwu5l5smprlq0lvhl.mp4?ik-t=1681513569&ik-s=b2b463e63202cb0760d29e6c1428efffc3263469", correct_answer_index: 3),
        "pmyugu3zH9": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/furniture_build_2aihyyjbkplyrqs053o7djwkwu3nbrc.mp4?ik-t=1681513570&ik-s=a52be65f5b4086313c00153454766b29e47b28e9", correct_answer_index: 1),
        "h3ZDw1t4AC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/kid_nightmare_2hr1yuuawertylc39akr71h8m9w085y.mp4?ik-t=1681513570&ik-s=92f439759ee7dfed6702e0acdf9139b23fee2e94", correct_answer_index: 0),
        "Myr6kbfOea": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/marvel_avenger_2aeaacywqu1i9ghuus4dbbl1dz1roxp.mp4?ik-t=1681513570&ik-s=98c031a6eb9f18d0614ec3b565dc5c13e47b20a2", correct_answer_index: 0),
        "ZYBAZ4AGKU": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/meal_exp_24syz2jr0jkhutw4e2xpsskdlt0rwti.mp4?ik-t=1681513570&ik-s=6d078c6c7c5d2525ef81459bf19b58019817ffc1", correct_answer_index: 1),
        "FyzkSknABq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/meal_exp_why_2kb77570nfox1qvlaxt1rz8hn77rd3i.mp4?ik-t=1681513571&ik-s=b52e6f2905a1ccd0ee045f3df94a65c9c05a3645", correct_answer_index: 1),
        "7mCPC4COiP": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/no_love_29kcieb3tq9g71nkj3z75z60ru79xm3.mp4?ik-t=1681513571&ik-s=3ec47bf7dba4506cef8b6826f9f8e6f3b5964710", correct_answer_index: 3),
        "Cuk6I1u2p4": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/regret_2ulrf4j9zv7w1veycj6awf75w6fk6cv.mp4?ik-t=1681513571&ik-s=2b1d2ca24cbf921de0e519d2f6d03b8cae389bf2", correct_answer_index: 0),
        "q43N9EZwZW": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/object_warranty_2f8axv7vdhtgvyb90qll79evcwc0qs6.mp4?ik-t=1681513571&ik-s=5f2f7373de2b88fdcd3367d05a3c7b711d46ea91", correct_answer_index: 2),
        "9QIYGtcn3P": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/extinct_2vojlcf575g328blimvd8uonxvjda20.mp4?ik-t=1681513571&ik-s=39f66c7c4a4ae68b8e4c81e1729b077a67aae36a", correct_answer_index: 2),
        "loIa4DAdDm": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/snowman_2o265uqedsjehledhydyp2220cknx11.mp4?ik-t=1681513572&ik-s=3566e45686a40df72d0c4f3ef790ca8bd2674631", correct_answer_index: 0),
        "HQGcTmdYyI": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/warranty_2d117vujpd0vlfb84jux20j7cppw71m.mp4?ik-t=1681513572&ik-s=cb1b7464a0874b21506c40e687a79885317090c0", correct_answer_index: 1),
        "lHaD8aO0Xo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681513576&ik-s=6f950e27aacdd3891a43379874b0b25bbb9c426b", correct_answer_index: 1),
        "20y9J83SWf": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681513576&ik-s=850b417da9ee98a9c787667e36866da5adf75eec", correct_answer_index: 0),
        "OiFVoBdYqn": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681513576&ik-s=a560b021649291ae6e430c4f07916d3bc55e9701", correct_answer_index: 1),
        "Jy2pbI0Ho5": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681513576&ik-s=318edad30bf28bd1fe0f9c5c0b3f24e34730c155", correct_answer_index: 0),
        "FWr9oSgM9g": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681513577&ik-s=803514073a329e874fc27f0ba3c7831f6bfc9907", correct_answer_index: 1),
        "f6UDGxxJff": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681513577&ik-s=fe7542ea46e2c6d51ab1009eea94a2dea5f35256", correct_answer_index: 1),
        "RmQu4Fubxp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681513577&ik-s=0e94163e1e757e8e9988d8d54d67ad4cb5980962", correct_answer_index: 0),
        "h7ITGkE16O": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681513577&ik-s=a3d3858a229c8a958a3b991fad0338b555f67fd5", correct_answer_index: 0),
        "zvJEMn6uff": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681513578&ik-s=8f2346d92c31011ca36681ee62040f7328220803", correct_answer_index: 1),
        "9smN11uObS": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681513578&ik-s=ca48d305c4a6e816c8cc378f2685b7a066dd8c9d", correct_answer_index: 0),
        "WTKKXx2Nbq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681513578&ik-s=11190deeb0cf3713201d25c09f99e48d518b8f6b", correct_answer_index: 0)
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
