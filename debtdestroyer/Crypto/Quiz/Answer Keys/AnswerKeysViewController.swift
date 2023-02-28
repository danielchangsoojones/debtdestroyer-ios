//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,0,1,3,1,2,2,3,0,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/do_you_expect_gift_2.mp4?ik-t=1678136400&ik-s=f99c777e969cb97d1acec32088c77efbc4c3d088","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/bowl_term_2.mp4?ik-t=1678136400&ik-s=c96c9a66173684723cf44edae9f627e08cbe0087","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/where_you_work_2.mp4?ik-t=1678136400&ik-s=06889d16b13d2bd15a3973cffa88e07c0170d190","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/last_hospital_visit_2.mp4?ik-t=1678136400&ik-s=f53e90c7634e15dc7b245731f7e64289f0eff822","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/biggest_role_model_2.mp4?ik-t=1678136400&ik-s=349feb92a24a3ee861eafda3cb2209833e87824d","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/carnival_ride_2.mp4?ik-t=1678136400&ik-s=082b0066979ac6971d3b86cfe877ba9136ae4112","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/cellar_2.mp4?ik-t=1678136400&ik-s=f35b5008354a536b89bab02a6e09775f34cb57d7","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/where_to_live_2.mp4?ik-t=1678136400&ik-s=1bdfdc7f7b9f94e20f580dfa496fe4d49f337c4e","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/squirrel_fight_2.mp4?ik-t=1678136400&ik-s=0e4c8a89eb1f65dd1464610c86486d1863d763bd","https://ik.imagekit.io/3fe3wzdkk/AC6bskWIXo/where_you_from_2.mp4?ik-t=1678136400&ik-s=04c8e45e48a053f98ea5fb7163a66cef820256bd"]
    
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
