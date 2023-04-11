//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "F1pNrk6lh2": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/worst_do_2emijth2s8ffs19idm2bhbxdoh9ykkf.mp4?ik-t=1681846086&ik-s=4e4ea8d47a720f93be0755cffe378e5a1f8f6fcd", correct_answer_index: 2),
        "jDjMlNBMVX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/white_house_2dckfgxev634jkighebhp1kayxwrake.mp4?ik-t=1681846086&ik-s=033eca7e44190563f80e60be5493f9debbf9e30d", correct_answer_index: 3),
        "BCWmVtNGCD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/three_words_2gnc4mdujt9c1w0q2obsd54bibeahi0.mp4?ik-t=1681846087&ik-s=42d9301d608140401308070a3c2ba6c1ee99f548", correct_answer_index: 1),
        "GOg1VNmCVg": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/red_flag_271yaif8po0vgpzxrbowljay88p5it0.mp4?ik-t=1681846087&ik-s=790c89caed8f600e725123aa53f6f48b9b1f8b39", correct_answer_index: 1),
        "1SYvAJvvWB": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/never_parent_2tsv5cvpywnzj3ov7snp3dzt7k3po1d.mp4?ik-t=1681846087&ik-s=2170fdeefbf980b194e578b092a8a7e9f6a1d8c3", correct_answer_index: 0),
        "rypIKc6eN3": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/never_ex_2ig7wwz8tce46dwade2eldo9nl3hqax.mp4?ik-t=1681846087&ik-s=8fa3d8af3e12b553208702a3fa36d9a7b97f791b", correct_answer_index: 3),
        "N7SgtsiF6Z": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/worst_do_2emijth2s8ffs19idm2bhbxdoh9ykkf.mp4?ik-t=1681846087&ik-s=5a618f5cf753e171a01699465664b989eb9b283a", correct_answer_index: 3),
        "hBoBll2pzC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/white_house_2dckfgxev634jkighebhp1kayxwrake.mp4?ik-t=1681846088&ik-s=2bfd68a16fd019df1f9f32224d857433688c5f59", correct_answer_index: 3),
        "UeTEGvaTyV": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/three_words_2gnc4mdujt9c1w0q2obsd54bibeahi0.mp4?ik-t=1681846088&ik-s=49875711b390a939c34d75eab324b8bf6bb1807d", correct_answer_index: 0),
        "8SCLZtKEny": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/6V8L29qfna/red_flag_271yaif8po0vgpzxrbowljay88p5it0.mp4?ik-t=1681846088&ik-s=37f3f2b06122986c93acbbcbe37c1e5aa00c2c92", correct_answer_index: 1),
        "3OUF5lsQxk": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681846092&ik-s=afb0afe40ffe63bad32bf73c362abb6a6068f1a4", correct_answer_index: 0),
        "iFXz7YwA9Y": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681846092&ik-s=8bbaaae3325a49d452b5340c81f8fd331825f3ce", correct_answer_index: 1),
        "EvdLUeIczG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681846092&ik-s=aac2423f44d817f6bcd655e0b49d9b5b86f64100", correct_answer_index: 0),
        "4zedFrTfLB": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681846093&ik-s=f1f5d97f8cada4e3f92dd093d448f3fe03424ea7", correct_answer_index: 0),
        "eoLniDx1fo": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681846093&ik-s=894bd77f5c925f3d99d32f84249798dfe2c334d4", correct_answer_index: 1),
        "oDuQtQ9p9e": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681846093&ik-s=87227c552888d27df8c2102080bc5adc91d65c2a", correct_answer_index: 0),
        "rPyVBIAeLw": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681846093&ik-s=3109084527ac6fe94c2a84f49a912249068884ef", correct_answer_index: 1),
        "TNcWXfUGUZ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681846094&ik-s=2e4e2003bc41ed30dfcd2d0f870b00d62bb26ad7", correct_answer_index: 0),
        "27SENMEKMO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681846094&ik-s=f616f2f25c0697b47a847ff1c56f8afe4edf6026", correct_answer_index: 1),
        "C8HHxLSkpM": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681846094&ik-s=ae66e633c6dd0036c7358636d942052aa0502fbf", correct_answer_index: 1),
        "I53SDzREsW": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681846094&ik-s=333826254364dfb4f3ad7fa84b8e061be66a282f", correct_answer_index: 0)
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
