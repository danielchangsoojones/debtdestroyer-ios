//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "4BsfAd0eiX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/intro_sleepover_act_2gho0fs25p2j5kiy5k9p0zp6uekm66d.mp4?ik-t=1681430946&ik-s=796da0bde1049c83ef8a8531b8acaf9a075aceba", correct_answer_index: 2),
        "ZRExzBEtCf": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/brand_cereal_2e10gzpsn05ixxidfolvyyo7ddufa25.mp4?ik-t=1681430947&ik-s=7abe5328915f63615cde9cc685c073d94e90013a", correct_answer_index: 2),
        "totWoJxKeI": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/drink_2l4dvwqhwm85858586avynrptnbp5hp.mp4?ik-t=1681430947&ik-s=b4740033ba23042b75fc73de3c4f6c29b18ffd73", correct_answer_index: 2),
        "lw8lcIRC28": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/rhyme_election_24hxxgrnxfrpn6lfqrctngxvdu3vfct.mp4?ik-t=1681430947&ik-s=8051bd42c7c9ce6cac813e8715076a27e0a10e94", correct_answer_index: 0),
        "XXCfIbGKSy": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/exp_meal_2e26ei9qcinx9bfd2zs2fj0u2izsp2s.mp4?ik-t=1681430947&ik-s=1f65ff415daa4ec5afabc6d82af78061d7d04ea7", correct_answer_index: 0),
        "PIktwSrbHE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/exp_meal_why_2atftnhnsbptf602xf9fyo224gs0bvl.mp4?ik-t=1681430948&ik-s=43c5aa2713511c92d8becfc2b6eef57d4090f2de", correct_answer_index: 2),
        "AtWjV1R170": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/flag_red_2e8nqbr767m43cysq1m9dpbvr8z506o.mp4?ik-t=1681430948&ik-s=1c3528796f6df307bd274f09483ba1383552a13e", correct_answer_index: 0),
        "FSlBZLSeRG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/flag_red_why_2tjwpijg31718gs300fj5du18k2op5g.mp4?ik-t=1681430948&ik-s=7bea1156dbb74a1e0a5f3a770ed45351f52d39e3", correct_answer_index: 3),
        "lli46PTDwN": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/french_spoken_2mlva2btlieqk0vjdpfm2ie3nnjl7yk.mp4?ik-t=1681430948&ik-s=a75b72f9b918fe325ecbeec1cfd83db9533af9af", correct_answer_index: 0),
        "CCQVbiVBBk": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/hated_holiday_2zqwo6ogwj7hm84xg3vqvtpi2nj6l9m.mp4?ik-t=1681430949&ik-s=580e10644620fc99505585934302bbbfd181a70a", correct_answer_index: 1),
        "LGQilJqrmp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/car_brand_2eev9srfi5dfpd2n40dvyyrfw8bknmu.mp4?ik-t=1681430949&ik-s=938008ff5d3035a158161310dbe9b8b38fbd3b4d", correct_answer_index: 3),
        "4dUOqZbQ3p": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/l_city_2ocaxk7222rvsda1n02logf7c62kgfh.mp4?ik-t=1681430949&ik-s=307ee0ce1d914cbb3175bfff78953fd7444c959f", correct_answer_index: 3),
        "MR9S3PlbJv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/meat_2k4615ucc2bbu1p5q85yoa4z49u9667.mp4?ik-t=1681430949&ik-s=bae4095af4afd1a632913591615d03b531b45949", correct_answer_index: 0),
        "J5i1ndOSD6": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/monkey_species_21dp4x0qi4qmo69s6m8id4cf9wvzy73.mp4?ik-t=1681430949&ik-s=ecec9122fcf1c8b28e244f10483ccac5d08daee9", correct_answer_index: 1),
        "i4R6plwYih": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/lCTJWODHBy/end_love_no_2v1cse6r709my8wmykf3a45xovbqlz3.mp4?ik-t=1681430950&ik-s=00fbc91dce52797c390be9e53077fd26bd30af9c", correct_answer_index: 0),
        "cNimRPDh14": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681430954&ik-s=390032ce010b25634b85156f6c1b3dbaf5b4eac1", correct_answer_index: 0),
        "HcmNjcnoVl": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681430954&ik-s=1624da64ce5d98d37e560a25495824c72add09a9", correct_answer_index: 0),
        "8QDFT3qFMk": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681430954&ik-s=2b36426b98b2decf89d9042feb76c5968f7fb466", correct_answer_index: 1),
        "GH5sKpYfvt": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681430954&ik-s=d85210088495669688bc735bbb757b20b9c6d6c2", correct_answer_index: 1),
        "CIyxHDRxUh": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681430955&ik-s=6f79cb0c89b2e6f3163f4a11f0794054c5c5b0a5", correct_answer_index: 0),
        "oGhnZOmNNQ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681430955&ik-s=417617752c4cd4bc05127a805d54f2d371c24e45", correct_answer_index: 1),
        "9F4wXtIkGf": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681430955&ik-s=210b7aeaa528b6de7890a52cabc625f40b6db68c", correct_answer_index: 1),
        "0zh55dMZNq": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681430955&ik-s=2594e4ec1eb7689bb811ba7ebdc624f860df0771", correct_answer_index: 1),
        "O2G826wHxA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681430956&ik-s=9c188b6a38bff5d795a72dc95ce87d024e3c9cff", correct_answer_index: 0),
        "i6tpjVfgl3": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681430956&ik-s=e832e680e3b49b723e64c9eabc67e06b439e953e", correct_answer_index: 1),
        "eopVs5iqP1": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681430956&ik-s=37b44c416f0074199faf9299a5286b530c5b71ca", correct_answer_index: 1)
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
