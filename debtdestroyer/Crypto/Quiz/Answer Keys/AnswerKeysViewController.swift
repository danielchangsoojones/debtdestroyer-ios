//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "ePXH3QP9EE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/intro_exp_meal_2p52vda41w1ulip467wz32rd6m73hf8.mp4?ik-t=1681287299&ik-s=a95af83b656d365d27d271faa885fa617b1ab8dc", correct_answer_index: 1),
        "IwTTvAi3xg": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/exp_meal_why_2537ftca9odcq87ucly43ya3w6icufk.mp4?ik-t=1681287299&ik-s=30350c80384e2c7ccf04b1e10a9b9be37560332b", correct_answer_index: 1),
        "hB0WqItU3B": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/red_flag_29ju0jfq90b3o0e4wzp3pwdpg41kxcz.mp4?ik-t=1681287299&ik-s=f1f70c991cc566fbaf4f8e9e8beaf20e8e457067", correct_answer_index: 3),
        "wiOpAKUzK0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/red_flag_why_2t3no1xwu32rok9v0sbi03kbncjaiin.mp4?ik-t=1681287300&ik-s=6d185b357e9d34921b12ebce2bd165f6904c90cb", correct_answer_index: 3),
        "eNphwv59gD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/boss_2aqwuxvqn76ver2cqj9ru20z7tq799k.mp4?ik-t=1681287300&ik-s=2581d6ec78a34d06c0914bdc935bc89b79d8fd10", correct_answer_index: 0),
        "IHLQwTjbzo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/city_cali_2f1p870meepse7cseoegxkw1av6jsdz.mp4?ik-t=1681287300&ik-s=5eb8999abb5e9a74f033366eeacc8bc42cdcd387", correct_answer_index: 2),
        "pSjZ5kaZFv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/crush_santa_2xpf2kcr09j2ws70fyrxujgnpb1y5qj.mp4?ik-t=1681287300&ik-s=2ccf58d4ee64121c61d6e64602eb1864f38d0d4f", correct_answer_index: 0),
        "aAY7KFEGtG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/exp_ice_2ftf95s5jnja5n9nm414skcb0yq4xiv.mp4?ik-t=1681287301&ik-s=13ebbaf62a404059aeed15c8c1ad6676d69c9a08", correct_answer_index: 2),
        "PoCCjijNwD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/fear_268rsizh7sjz4b4pg8duzhc7vkx593z.mp4?ik-t=1681287301&ik-s=e5dbb5cbe25cf6f8d653e3007575383041555f94", correct_answer_index: 3),
        "a2cp543XJH": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/lottery_exp_22j6woqqwvbbpjldmmxwewaepiscoz2.mp4?ik-t=1681287301&ik-s=e0203c7647393fe033813496bdc41d346b953718", correct_answer_index: 0),
        "ckc9ndPs5i": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/movie_remade_27h3urmxoxn4hvdt3ybxjpqndo44ear.mp4?ik-t=1681287301&ik-s=c646d57c5d44bd4f50f621ce396606e5456a4bdb", correct_answer_index: 2),
        "6bGofQzh2a": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/other_red_flag_2966a4rlfuv65bz8a24td946ail3d1z.mp4?ik-t=1681287301&ik-s=ed7303622382c1f08853a78bfac91299444dcfa0", correct_answer_index: 3),
        "SPrgRSjqOC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/s_city_2cryzir67xo7vz7cnjkwcv3tod4rszl.mp4?ik-t=1681287302&ik-s=13d861eb6b44416c3351c17c519e3024fc29fc30", correct_answer_index: 2),
        "XUKZFxq6ko": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/sleepover_2l4zumxm6kdqzptpx9tcyfe1bl0gv16.mp4?ik-t=1681287302&ik-s=a8f30e151b5933ccdd5ec346ed96b56381b64910", correct_answer_index: 3),
        "p7U5dGzy90": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/5pdbk8HRbd/vampires_27mefnrffonfc09ra067ibuc08gq1ky.mp4?ik-t=1681287302&ik-s=f6450ff3b853d6cd77b106eb28819d64b8cf89e1", correct_answer_index: 0),
        "yARXfrbE9N": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681287306&ik-s=f276f3187bf44385683b4ba6d90b93459e69260f", correct_answer_index: 1),
        "DRgSKMZvTq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681287306&ik-s=3dfddfe3dccff1149e84db6f7467e7e52c713223", correct_answer_index: 0),
        "B8actO1Bmy": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681287306&ik-s=e9a194df9610845751a88d485215746d3e3484ec", correct_answer_index: 1),
        "xTztYvefYF": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681287307&ik-s=b60ff7ab61111b2df767b06d22a353d92c85fa3e", correct_answer_index: 0),
        "VS7Y418GEM": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681287307&ik-s=0454e70a8afe481818abcc64ad8b602070602ba5", correct_answer_index: 1),
        "tSnIpGyvqn": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681287307&ik-s=fc4341e54f745b29216f2575ad151cf5b04fbba5", correct_answer_index: 1),
        "bcTfF0AXLx": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681287307&ik-s=c03d616a73e090c3717df2976bd552d9abc59a41", correct_answer_index: 0),
        "x4yW0zMXVQ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681287307&ik-s=51dca4b62b37a574d25e5b0ccbcffde638393015", correct_answer_index: 1),
        "8uSlZBVoJd": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681287308&ik-s=5bddedcf16bcd4b9c6e2ef8e963e62d842733710", correct_answer_index: 0),
        "oqUoGrunfh": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681287308&ik-s=a27e2a91032595a95c3b6019b742ee102e56d78c", correct_answer_index: 0),
        "XLNF622EZt": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681287308&ik-s=eb5ea9a91f8fe7e823cc64000390b376db3a5045", correct_answer_index: 0)
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
