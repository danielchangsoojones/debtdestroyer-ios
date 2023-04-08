//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
    "skjUZJ0ZpZ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/regret_2ulrf4j9zv7w1veycj6awf75w6fk6cv.mp4?ik-t=1681588285&ik-s=a6b3766ad2b87dc782dd242cac0400070724b015", correct_answer_index: 2),
    "FlFQTvFuI5": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/object_warranty_2f8axv7vdhtgvyb90qll79evcwc0qs6.mp4?ik-t=1681588285&ik-s=6c07e51ffebb2fc622ab716947d85b33e9b002f7", correct_answer_index: 3),
    "nX7QE6lSwG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/extinct_2vojlcf575g328blimvd8uonxvjda20.mp4?ik-t=1681588285&ik-s=15c12e7be3a06b8c87bd299301f2a7a55c665692", correct_answer_index: 1),
    "HbGIk0ghfY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/snowman_2o265uqedsjehledhydyp2220cknx11.mp4?ik-t=1681588286&ik-s=29ffe68e7f17343d09b5fd52456ac490d105a61d", correct_answer_index: 0),
    "5ZjsrfCb8C": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/warranty_2d117vujpd0vlfb84jux20j7cppw71m.mp4?ik-t=1681588286&ik-s=facf0c5fa13c968862b9077a72fe9c9166f4a42a", correct_answer_index: 2),
    "KPQ00maCeh": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/ghost_2pvf2ndszctvv4ajiypaoqs8sywz9ox.mp4?ik-t=1681588286&ik-s=6c2942ae4979744d8c6f99fdbe6804ab45b92cca", correct_answer_index: 0),
    "inxG9hF6hz": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/scam_2dzumfb565vugamudzbfluclyy94ghd.mp4?ik-t=1681588286&ik-s=74a88fbdcb0018266317959684a9d84872171a72", correct_answer_index: 0),
    "6Q8TwaAu4l": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/VtIqhc4y3K/turn_on_2mooe28rpklf7e70ymjg0spr62fcol5.mp4?ik-t=1681588287&ik-s=b02d59f08e594f4f89d3a4eebdd8146609599196", correct_answer_index: 2),
    "cC2bnaN53S": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/tv_show_24sl3gmm0xcr2g4odwnjv7hahfo2byh.mp4?ik-t=1681588291&ik-s=4558ddf0bf29bd1f72dd5d62eaa50e84665c84b6", correct_answer_index: 0),
    "30NJFs9Blt": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/trends_2poy0bkj048ql6mhul9tnvbolvj4lr2.mp4?ik-t=1681588291&ik-s=4c14da26cd1fc32dfa3288dd23727305eb9ee19a", correct_answer_index: 1),
    "fweJQR5hko": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/switch_career_2aohs0o1lmras2k76vkuw2x2xbmke92.mp4?ik-t=1681588291&ik-s=ce77333945c9b33cd3f0e14bfada3ad16ead5a30", correct_answer_index: 0),
    "LsjPE8ifna": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/pop_culture_2skq21hhwts27yfq2glrmuf6nhvkces.mp4?ik-t=1681588292&ik-s=3f9b6ddd84e512e3bff2a76371c7bea2b3c536c4", correct_answer_index: 0),
    "FuNAboqXUO": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/other_switch_career_2ax7apeakk0sauk9hh82ydulzw7luwo.mp4?ik-t=1681588292&ik-s=546558b45916109ac598d4c25317945cfa47325c", correct_answer_index: 1),
    "4Fyrxrwwt4": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/mental_health_245dbq5yy3sxhql5hwfg0m6t2ut01gp.mp4?ik-t=1681588292&ik-s=d395cb5026cbdb5e652942ed61ce5bdff570f27d", correct_answer_index: 0),
    "fzpHJ84lTp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/fucked_over_2qbwuqi893y9c7k82afu91a6asjdmlo.mp4?ik-t=1681588292&ik-s=6af98d2ab7617435d3856f491cb270a64caa2669", correct_answer_index: 0),
    "geJTFhH0WY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/finance_matter_2u9mte8ufpv8zdob7bug3gwpciw433b.mp4?ik-t=1681588293&ik-s=418c6765f0c503ae267dbbc239412cd765dea914", correct_answer_index: 1),
    "oCC03gNWO0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/dumb_money_2o1aryqx1hy0v76uqarb147wqjlcf8g.mp4?ik-t=1681588293&ik-s=b4a546ddde68f7fa7d058a0bc47773cdabaca212", correct_answer_index: 1),
    "pirXJNCZFw": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/brand_2gnzl6mkzymxvwepjzi3fb5hf2vbqyv.mp4?ik-t=1681588293&ik-s=6528aee3389830aaed4b57e41b002174d02094a5", correct_answer_index: 0),
    "imbeIJc1Dn": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/bath_2tdj99tqryhjcu9z6mvh3803zp48hfs.mp4?ik-t=1681588293&ik-s=4d3cba35126fb25021bfffc427fd487252f2fe01", correct_answer_index: 1)
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
