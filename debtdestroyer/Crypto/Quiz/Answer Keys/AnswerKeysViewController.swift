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
        "wsNbBb0kYy": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/worst_do_2emijth2s8ffs19idm2bhbxdoh9ykkf.mp4?ik-t=1681929560&ik-s=1d624f42221057d5dd740b197b149e9118c437df", correct_answer_index: 3),
        "tawuikYOsQ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/white_house_2dckfgxev634jkighebhp1kayxwrake.mp4?ik-t=1681929560&ik-s=2932baad8f1dac5324cc78cba009c430a292407f", correct_answer_index: 1),
        "Q6TR9LJB1c": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/three_words_2gnc4mdujt9c1w0q2obsd54bibeahi0.mp4?ik-t=1681929561&ik-s=49cf67e2241d9ad509246790fd306f72418c821a", correct_answer_index: 2),
        "MIac4CoGuE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/red_flag_271yaif8po0vgpzxrbowljay88p5it0.mp4?ik-t=1681929561&ik-s=856e19f10a919721394074ad1199eda496e61f19", correct_answer_index: 2),
        "vfcBqx2BRY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/never_parent_2tsv5cvpywnzj3ov7snp3dzt7k3po1d.mp4?ik-t=1681929561&ik-s=68d1d83da0e2d3fd28110dd4fd5e58695eb162cd", correct_answer_index: 2),
        "sP2iYbQDGj": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/never_ex_2ig7wwz8tce46dwade2eldo9nl3hqax.mp4?ik-t=1681929562&ik-s=7072ce7a39b5841e53b5d984e6edc617a5520913", correct_answer_index: 3),
        "e6p3caa4y8": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/worst_do_2emijth2s8ffs19idm2bhbxdoh9ykkf.mp4?ik-t=1681929562&ik-s=6f180b779867c46b978a6d06b5b8ec937c8cdab0", correct_answer_index: 2),
        "u0gfQG55A5": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/white_house_2dckfgxev634jkighebhp1kayxwrake.mp4?ik-t=1681929562&ik-s=8c872d09e1cc564f930cedd330a62a9dfee2b394", correct_answer_index: 2),
        "idUgZ2QDGf": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/three_words_2gnc4mdujt9c1w0q2obsd54bibeahi0.mp4?ik-t=1681929563&ik-s=7f788940c842f4160bacfff7b29963ca01df4a1e", correct_answer_index: 1),
        "i0NqvcCGqR": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/red_flag_271yaif8po0vgpzxrbowljay88p5it0.mp4?ik-t=1681929563&ik-s=8641fc6deff561dd9bc0e9a249c56ef102a9e8c0", correct_answer_index: 3),
        "rXNjDttlzd": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681929568&ik-s=53401280b042facecb40dd792d86c58ba331d9c0", correct_answer_index: 0),
        "D6rQN2WrG3": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681929568&ik-s=f86555c3bed53fbb902e5f1a256dba8cc0a84055", correct_answer_index: 1),
        "85d2zQylCD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681929569&ik-s=00b78c7de7b1196a075b025b9422985cbc3c09e9", correct_answer_index: 0),
        "64bpa9lhuF": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681929569&ik-s=42ea96d5f2d33bec3dadc3b9b346bdb3b85ecf15", correct_answer_index: 0),
        "0vXTU83twD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681929569&ik-s=297f56d327cd3a1afa6e063e9adbfc61fc0a65b2", correct_answer_index: 0),
        "g6iFgtXrIE": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681929570&ik-s=b515bd744d1cbd3febdeb372349ad0e871c9248f", correct_answer_index: 0),
        "zGa1miudb1": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681929570&ik-s=27156efe8ddfb24449a10aa1316156ca584abc50", correct_answer_index: 1),
        "UC8JXqkZIA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681929570&ik-s=b7a3fc89f590fd8516ea0a2989ba3a02f958860d", correct_answer_index: 0),
        "IDskARWTv0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681929571&ik-s=89cbecccfb3faeac2e796ff6560d04cc359fbc98", correct_answer_index: 0),
        "LYTqmjaLCr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681929571&ik-s=e997465e4bb7bd13e9f779407f4eed032be20c7d", correct_answer_index: 0),
        "c8x0QFQRBJ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681929571&ik-s=7b9be94ec002c5a1d15f8bdc4071898917fb400f", correct_answer_index: 1)
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
