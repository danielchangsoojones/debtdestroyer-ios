//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,3,3,0,2,2,1,1,1,0]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/poop_2.mp4?ik-t=1676317530&ik-s=e6f9acefa9a1b7d3000d1482d22896d0e00f6f83","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/in_man_2.mp4?ik-t=1676317530&ik-s=307e98a4bbc8ba6e6d71786762c60dc78c169f95","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/pet_peeve_2.mp4?ik-t=1676317530&ik-s=76e76f754cf17b4b0f462f1128e99b1c86a2647c","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/single_2.mp4?ik-t=1676317530&ik-s=4931f765e126e6fa0a2bf374b15e767106d1dac3","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/piss_off_2.mp4?ik-t=1676317530&ik-s=59d52e61d308f4772c5dedf06cec5d0b63df467b","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/worst_date_2.mp4?ik-t=1676317530&ik-s=810fa06361d2da1d794d3da3bf0480426301512b","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/worst_year_2.mp4?ik-t=1676317530&ik-s=61042977d6665c3a3d9de0f78f2d650932d760ab","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/life_change_2.mp4?ik-t=1676317530&ik-s=f1d20c94c7bd8f043e6b6bcdd4f2128f3c0c9949","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/famous_2.mp4?ik-t=1676317530&ik-s=07859d9e15e4c979f01ab13be3fdae85c3d3ff6b","https://ik.imagekit.io/3fe3wzdkk/3FXWsYFWCW/search_2.mp4?ik-t=1676317530&ik-s=abf7ec2de8fe90a95f95fa3342cea730d2a1fd7f"]
    
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
