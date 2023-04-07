//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "tEzFEyiLk1": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/intro_m_state_2t1sltabg3qkwyrrgij8qedyvutlxio.mp4?ik-t=1681505965&ik-s=29aa1efbef177e543b5b1354cc72f9e9c9c536aa", correct_answer_index: 0),
        "ChsAK92vpr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/disney_2gcd5ujnhuk1huopy3ais0cnisutzr8.mp4?ik-t=1681505965&ik-s=35aaef172c9ac18bca63132e2dffcab731b485bb", correct_answer_index: 0),
        "6sJD6O0npN": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/book_23qt12dru9bitf6af6ao7d1vljr8g2b.mp4?ik-t=1681505965&ik-s=d8573167d9a636fe71233c56266c8c3335c718b8", correct_answer_index: 0),
        "mkEircfDn6": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/election_rhyme_2tkx22g3xinojndwu5l5smprlq0lvhl.mp4?ik-t=1681505965&ik-s=7b62b5b87443ab8c70f6af5c7bc3c697bd024d09", correct_answer_index: 0),
        "KW0xWyZc8s": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/furniture_build_2aihyyjbkplyrqs053o7djwkwu3nbrc.mp4?ik-t=1681505966&ik-s=e6be7737b605f1fd494744e2db9bbc41df0e0de7", correct_answer_index: 0),
        "hZqjScP5OW": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/kid_nightmare_2hr1yuuawertylc39akr71h8m9w085y.mp4?ik-t=1681505966&ik-s=73e33722e9ffa8cf52194b2b30c64aba90509000", correct_answer_index: 0),
        "CKyBueIpPe": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/marvel_avenger_2aeaacywqu1i9ghuus4dbbl1dz1roxp.mp4?ik-t=1681505966&ik-s=23021d11a54ea41ac8abad7514fa0f7b39debf4e", correct_answer_index: 0),
        "HtD8EfWhYM": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/meal_exp_24syz2jr0jkhutw4e2xpsskdlt0rwti.mp4?ik-t=1681505966&ik-s=9acf3fe46cc4fe1ee5e6f2a7015e3d83a63c1dab", correct_answer_index: 0),
        "3vr97QLD4y": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/meal_exp_why_2kb77570nfox1qvlaxt1rz8hn77rd3i.mp4?ik-t=1681505967&ik-s=eefdf1cecf617aa1fd120e041c1af28eeddad953", correct_answer_index: 0),
        "sJ6Gz8UeX4": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/no_love_29kcieb3tq9g71nkj3z75z60ru79xm3.mp4?ik-t=1681505967&ik-s=a8f2d8c27fc90137aaed556369e2310c381ad13b", correct_answer_index: 0),
        "EIy91VWHdm": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/regret_2ulrf4j9zv7w1veycj6awf75w6fk6cv.mp4?ik-t=1681505967&ik-s=d58595ef9ca293cbff3050c2f73e03f11a0ffc26", correct_answer_index: 0),
        "Kx0iYZKDiy": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/object_warranty_2f8axv7vdhtgvyb90qll79evcwc0qs6.mp4?ik-t=1681505967&ik-s=bff8c0030f8bf08a0974689e22d871bfcba0fe07", correct_answer_index: 0),
        "GM9HM2DH0Z": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/extinct_2vojlcf575g328blimvd8uonxvjda20.mp4?ik-t=1681505967&ik-s=6f9e6d3ef34643464825b8426c989fabbf2f3e0f", correct_answer_index: 0),
        "OaG4WOcK0N": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/snowman_2o265uqedsjehledhydyp2220cknx11.mp4?ik-t=1681505968&ik-s=079006744370d57610b43dfdd8c50b1edc2d7d11", correct_answer_index: 0),
        "qopkhE5Wp7": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/vBYkigSoTI/warranty_2d117vujpd0vlfb84jux20j7cppw71m.mp4?ik-t=1681505968&ik-s=20b3599c9f1ffc1c1335935066b6cdc491354109", correct_answer_index: 0),
        "Af4vNAPwQw": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681505972&ik-s=855c9839e55a674f820360dac96ea0eadef65997", correct_answer_index: 1),
        "6GBK6DQ0I9": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681505972&ik-s=43ea6ff79a16e8c7ea63a6032c4d993296850eeb", correct_answer_index: 1),
        "5QOrliB9BO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681505972&ik-s=beeb19036a7d1622cf6f03397fe37103e9db7f4c", correct_answer_index: 1),
        "YvGPtYXcDg": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681505972&ik-s=df9ccac329fbd0eaae26a661766c0917fa98a165", correct_answer_index: 1),
        "Khl43Kxn3D": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681505973&ik-s=d880af319d57fcb4a46d24a9a823a9ed536676eb", correct_answer_index: 0),
        "BVWHIZzD0m": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681505973&ik-s=9f81e3cd506396f78040dbf7c84714ca256a70ef", correct_answer_index: 0),
        "uWypmFZedV": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681505973&ik-s=d49578852e803e606b1a56ba6d66b5b1bfaa74c9", correct_answer_index: 1),
        "vxj7ttwsaC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681505973&ik-s=c8cbb3ab8cac45723a559183047e54c371c42e81", correct_answer_index: 0),
        "EgBClePh9K": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681505973&ik-s=86dec94e4a13bbb8d73ca4a579b3a3a3818f08de", correct_answer_index: 0),
        "GbMJTei6VO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681505974&ik-s=d2683bf6da13e35664ff2be388c6695e0737cc3f", correct_answer_index: 0),
        "f0ChTc5fdO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681505974&ik-s=609162e234bece4ccee127f252a7fa3a13ee2618", correct_answer_index: 0)
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
