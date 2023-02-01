//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,1,1,3,3,0,1,0,1,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/overrated_2.mp4?ik-t=1675812205&ik-s=c89d5cf7a1c6254cac757d1fc2ab0e845d186c2d","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/take_new_york_2.mp4?ik-t=1675812205&ik-s=49ef3ce293691e1ed3196488795878d259e0288d","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/free_pass_2.mp4?ik-t=1675812205&ik-s=a4350e4b2522e6075a15a2ded65a7f43420df2fe","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/onlyfans_2.mp4?ik-t=1675812205&ik-s=0302234bd79c2c7db256f55455d10b04bf45e3aa","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/city_peeve_2.mp4?ik-t=1675812205&ik-s=7f07c66a0c8065439ed1a2be9bd5d9fe3b3b6ec3","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/fav_celeb_2.mp4?ik-t=1675812205&ik-s=5383dcf9f06c18c20541c91c233915407d836caa","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/irrational_fear_2.mp4?ik-t=1675812205&ik-s=49b3906cee4ea436442906d12596d97a60e8374d","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/social_media_scare_2.mp4?ik-t=1675812205&ik-s=2ca23ba52be9cad25cf13d585899558e6a8bd38d","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/you_mad_2.mp4?ik-t=1675812205&ik-s=5029d30e0604b9007c4f82bfdb9ef83f33f08029","https://ik.imagekit.io/3fe3wzdkk/vVS8O0UyEg/worst_nyc_2.mp4?ik-t=1675812205&ik-s=57feaee588e52c69a45ed59b06aea61bedf15c74"]
    
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
