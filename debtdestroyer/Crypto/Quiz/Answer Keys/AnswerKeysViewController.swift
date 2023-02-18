//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,1,2,1,2,1,3,2,3,2,3,1,2,1,2]
    static let answer_video_urls =  ["https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/career_2.mp4?ik-t=1677364622&ik-s=cb0fd718283129c8174aa6b710452536953e29ab","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/expensive_2.mp4?ik-t=1677364622&ik-s=b477bde415c26aa89a52fdc7c40bb8eb27b2246d","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/campus_2.mp4?ik-t=1677364622&ik-s=3d0e846d1602e5a4a7ac2a1a0835d6dfd1af0213","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/goat_2.mp4?ik-t=1677364622&ik-s=34f2245415fb5c8e7012242dc9db5ced37d5cd11","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/million_2.mp4?ik-t=1677364622&ik-s=abfd20e724ca6d282c308ecfaef48a428147d24f","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/red_flag_2.mp4?ik-t=1677364622&ik-s=4822a3fb2d26ac83b88f646d8e07f10bf6542a15","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/after_college_2.mp4?ik-t=1677364622&ik-s=32cc72c1f1a619e5872e61305d1b33a31609030c","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/like_2.mp4?ik-t=1677364622&ik-s=ca35acb41ef75d09f4c456cf8f08373ade4653fd","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/smart_2.mp4?ik-t=1677364622&ik-s=ec6c8b24d2ba4b6bd706ab33814e2c5f1730ce7d","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/difference_2.mp4?ik-t=1677364622&ik-s=e7b148d06e7a44f1ac66e36945fb0b4991ca4174","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/fattest_ass_2.mp4?ik-t=1677364622&ik-s=85b865e682da9ed56563a0b4a3dfb7ed2c91ebc4","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/biggest_regret_2.mp4?ik-t=1677364622&ik-s=7e79fd76d8393d399fbb2416ce48c9f9b5ff2d58","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/ideal_2.mp4?ik-t=1677364622&ik-s=239571e042d5086338480ec7e621acc2bfd2eb47","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/body_count_2.mp4?ik-t=1677364622&ik-s=97be048975649325d1fc527e38314f1c5483c0a4","https://ik.imagekit.io/3fe3wzdkk/cBRIv2GIg6/pet_peeve_2.mp4?ik-t=1677364622&ik-s=6e0b62b5808460294048391afb698a773e44eb64"]
    
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
