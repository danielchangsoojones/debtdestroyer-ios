//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [1,0,1,3,0,3,2,2,0,0,3,0,3,1,0]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/intro_engage_20de4ljvymwduiqboc9d2kuwrwlxc4z.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/horror_teens_2wdd7ouunpcj4806hh5eu69vf21oy8j.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/e_body_2phfkcmdevmjo2mgrxwtmtsdgq3vg16.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/italian_dish_24ux32zv34dk9xqh7zhj6waxnvbq078.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/red_flag_2i3xgx6gwsywb98jjsx2p54b96ccn2s.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/sneaker_brand_2u1vhyl5xw2lwnnpax4svjpcupfntbm.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/furniture_2vlhptjgls66sn9h2tehgdva9bhca67.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/brand_rival_2m9bpvi8o6pjhmlx3s8os1n6fzgr9bz.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/before_death_2y7eextzci5ezx4g969eyds4z0krowx.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/money_sport_2h07o1dbpsvfai0r7d7944jythqfdww.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/kid_nightmare_2fvy2jcx8alb8u26ry1rr7m26lfdkoi.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/regret_2x3b867iif7pfmub7gqx9blm376ht30.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/regret_why_2k1tw8ofgknlxvdibencaddhoz4qbe6.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/hero_28s973bqidpnx828rf2rlu3he5vu7ig.mp4","https://ik.imagekit.io/3fe3wzdkk/ay8JYl89gu/end_carnival_food_2b3rqp9kio6p7sc241wirmcf9mrs33l.mp4"]
    
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
