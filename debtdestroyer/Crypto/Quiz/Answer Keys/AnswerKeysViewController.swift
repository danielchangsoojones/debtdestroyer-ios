//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [3,1,2,0,2,3,2,0,1,3,2,2,3,1,3]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/longest_book_v59aseolrx9sv28242.mp4?updatedAt=1679444370045&ik-s=47b91c341f04e546fdc47ceca07adcdd81486a4d","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/book_about_xu821imn19o68449zb.mp4?updatedAt=1679444416810&ik-s=076f653f4b6e91923f6eb929a58c29b6abab37bd","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/dream_zktkd52oc6w9vyxakk.mp4?updatedAt=1679444311758&ik-s=648996a1368c3c87ae3c29e11769f4254945a77f","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/cali_city_g8zas8f2470o5eq179.mp4?updatedAt=1679444400452&ik-s=156afd57f5fbe47a979aef5f4bd95ae707a1dc4c","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/carnival_food_0374cdb30hsdapok46.mp4?updatedAt=1679444384071&ik-s=2fa61c1bb7c03972cbea429ac3a2e493add479a5","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/rear_end_ushog4b6b2l9c9bjyk.mp4?updatedAt=1679444333720&ik-s=97dc8a5ede326d330d7dafcc631002814cebbe33","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/fatty_qb1cu0kti5crpm7835.mp4?updatedAt=1679444295534&ik-s=0289a7d42ce8752b2b0c5f56b2cefe6e2397702e","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/movie_remade_yw6hgo65r7n612gdm5.mp4?updatedAt=1679444352601&ik-s=2354f2c86ce691d08655c8e666c074cebe9e9bac","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/kids_first_wy12z68s77vaegdfog.mp4?updatedAt=1679444275164&ik-s=7ba4e3884c7918458fdedcf23b4aa18423b0f749","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/keep_in_car_1v3ee670jnr7jopdvy.mp4?updatedAt=1679444254614&ik-s=4f3c87203a9d7ae635ddb429640a6ee4d95b0b7f","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/ray_thought_gxvk7wz3a57ffomtp5.mp4?updatedAt=1679444228212&ik-s=be297d255bb4a47a891e0238b0183c9fd1517eb6","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/big_fear_q1ij633vwzblhn5apa.mp4?updatedAt=1679444208712&ik-s=e3b3fcc4a980055a26dc0777819a3995ea93f7be","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/name_avengers_cj3ic4971n91rc2wd3.mp4?updatedAt=1679445343795&ik-s=9ab3bc4a0476bffd7bc7c4a650fbd5f4fa9be731","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/brand_sneaker_yoctpc138q4574u0b7.mp4?updatedAt=1679444166739&ik-s=84e3765493bd8d1a2f3129d1da6e16d7439488df","https://ik.imagekit.io/3fe3wzdkk/IUHVOASpDU/money_meal_ejckg96o213yrblncb.mp4?updatedAt=1679444121819&ik-s=3671438b35362abcfe45c3040d7e6f26250c8b84"]
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

}

extension AnswerKeysViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnswerKeysViewController.correct_indices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let correctAnswerIndexStr = String(AnswerKeysViewController.correct_indices[indexPath.row])
        cell.textLabel?.text = correctAnswerIndexStr + " & " + AnswerKeysViewController.answer_video_urls[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  
}
