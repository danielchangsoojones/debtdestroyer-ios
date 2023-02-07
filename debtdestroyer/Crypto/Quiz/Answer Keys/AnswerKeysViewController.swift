//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [2,2,0,2,3,0,2,3,2,3]
    static let answer_video_urls =  ["https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/invest_1_2.mp4?ik-t=1676418228&ik-s=9b1980878a2a7b069caf1effebb93b5220dd3b89","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/five_years_2.mp4?ik-t=1676418228&ik-s=ce3ee9fa0963dbf63bdf3009cee227e642740db9","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/fashion_2.mp4?ik-t=1676418228&ik-s=9f2d1c031e4db35d50bdd7a18984ffb1caa54223","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/cool_2.mp4?ik-t=1676418228&ik-s=ff8efdfbd1c269a61247f36b3de50ccbb2259a19","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/celeb_2.mp4?ik-t=1676418228&ik-s=3819cab3856f4699de1c08689ba8739371d8d25b","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/pres_2.mp4?ik-t=1676418228&ik-s=45fddb217c6066081187a0c7be2577d0f4285dba","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/dating_2.mp4?ik-t=1676418228&ik-s=1f709343148c21ebe504726944b3e1971cbcdaec","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/food_2.mp4?ik-t=1676418228&ik-s=1e400cec31f0b9abd4402b196868d96786b9a7bd","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/best_tv_2.mp4?ik-t=1676418228&ik-s=a58f8959f9e76108136c9a7656600b80976d0839","https://ik.imagekit.io/3fe3wzdkk/geKN3ddw7h/bank_2.mp4?ik-t=1676418228&ik-s=a2defa1ff0f3740e2d4f34fdd407ab63f285a184"]
    
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
