//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
    "a8G4obCUgN": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/intro_danger_city_2gma8zqtqvx8zhpfyczu7v05vk5ae2v.mp4?ik-t=1681776543&ik-s=b48b0036d31e0d931db3d89968a13bb36db580fc", correct_answer_index: 2),
    "OKnNt2n5GR": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/boy_2l98hdodutzfj22jmqiqzd6skwk4v5n.mp4?ik-t=1681776543&ik-s=2d0b4dfdf27d568cb42dea14828404a3207c8508", correct_answer_index: 0),
    "OJgNrnJQCS": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/best_sport_20jq0irnsn7wz51i7cflqaqudph31xh.mp4?ik-t=1681776543&ik-s=58d175107b39497d9a896751e636e67e43adf9f9", correct_answer_index: 0),
    "2BZElDRBmu": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/best_sport_why_2en5kc3gn6hkpg5lphyl4yh768pdnpd.mp4?ik-t=1681776543&ik-s=3bed4411792527298b3f9e905521f83ba71d2b2c", correct_answer_index: 0),
    "trt3lgmi7j": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/c_state_2bw7rv591081jay3e91htfelvp4ay7f.mp4?ik-t=1681776544&ik-s=05191ff627b37a08286cc9fa715e057ab344d00e", correct_answer_index: 0),
    "vQAW5tih5o": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/dye_hair_2jjcz6tc56cw25r0pdgjvn52fu2q3a4.mp4?ik-t=1681776544&ik-s=04029e7668d5409d03da9102a86bcabd9ab0b358", correct_answer_index: 0),
    "pnLNxFm79N": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/pet_exotic_2ouuvs7klt7fbqj4m0fz89o7gtixgqu.mp4?ik-t=1681776544&ik-s=ba7f48bb77a58bb943eae9c07b3ca795d447b8b3", correct_answer_index: 0),
    "MrnWgw0tHr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/snowman_2eh2v2vaawuulrakmgr0qs44vr3r853.mp4?ik-t=1681776544&ik-s=c376852e6460ea8751f9bd626826ea9fcce62e4a", correct_answer_index: 0),
    "JM3nkQs8mx": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/furniture_build_2seiyv1fgc7yjsxxp2bsvik5i1u8tiq.mp4?ik-t=1681776544&ik-s=d6dabfd21f8531f2d5758bbbb6c5901397aeb305", correct_answer_index: 0),
    "OFlYJcIx1f": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/holiday_hate_2t8jg9i2k41vrr0pj58fnsy0vmeryvx.mp4?ik-t=1681776545&ik-s=04ab2a278b4ed8208e0472f38e43b24d53bae6c7", correct_answer_index: 0),
    "BUahAX9PSU": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/breakfast_28e77myduhcptwk8dp5vxk2n7u36coj.mp4?ik-t=1681776545&ik-s=30987f5b414a6c3e4b95683aef1ee2a7f0f1e2b0", correct_answer_index: 0),
    "ROab7sEHRo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/kid_nightmare_27sd31mfc1xxtb7ds0zz77w3o0wwbd5.mp4?ik-t=1681776545&ik-s=b0c944f4182e9e9db3c5f82a468bccc38f7947a0", correct_answer_index: 0),
    "RszeEeLrLv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/no_house_2b21vkna0v37iz7t96z46q7n1qop9yu.mp4?ik-t=1681776545&ik-s=5dce874366f20badecac83e5f1ebb16e350c9bd5", correct_answer_index: 0),
    "O10r2eJSoY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/end_kids_2ee0vx1vv36wv73gmao5wyymsusvsqj.mp4?ik-t=1681776546&ik-s=358066d7716d7d280fb7196dde131040e32a57cf", correct_answer_index: 0),
    "E88TOgaDh7": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/i7AkJ0ONzC/end_kids_why_23u0tu8bvf4karvw1hlkxxanxkkkc7e.mp4?ik-t=1681776546&ik-s=0aa138a808351784aa6a451ce297ba3660e0802f", correct_answer_index: 0),
    "TwOnIy8bex": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681776550&ik-s=ea8376bd84ad8d5c25c1d5c55098b84ca221b743", correct_answer_index: 1),
    "KMCfmGco7N": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681776550&ik-s=e1319b4fe2705e10c221c18f686f3509f279e95b", correct_answer_index: 1),
    "yl47Aa1a5n": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681776550&ik-s=d591fa20837f52d062e95a70cca445229f5341a7", correct_answer_index: 1),
    "He30NKpGJv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681776551&ik-s=590c63db546738597e4fd154fa4e99f3926990a8", correct_answer_index: 0),
    "SL9IfkiNVe": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681776551&ik-s=e121b2fb64a8701c77c23e7e77ceade065a3b156", correct_answer_index: 1),
    "wHT9unC5F9": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681776551&ik-s=90154a275399fbd8c0c41cd1058fbb6c3990b2cc", correct_answer_index: 0),
    "pGSXuNS6Mp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681776551&ik-s=47d06676fb3557750ef26570653610688be8fa46", correct_answer_index: 0),
    "GF7OFPu0OX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681776552&ik-s=3c0c237c23e309d0395beb79e6a97d3854bcb242", correct_answer_index: 1),
    "6RViX0n3hm": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681776552&ik-s=5ffff61a64a38b4ab2bc9a028f1759917ef32265", correct_answer_index: 1),
    "j4xUl2sAdS": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681776552&ik-s=2c2e0a0840a2d7b1cca376aee8971b4a0fa65612", correct_answer_index: 0),
    "GOtSnx91HI": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681776552&ik-s=47981fb88f034bb6b5a502973397d719cc759424", correct_answer_index: 0)
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
