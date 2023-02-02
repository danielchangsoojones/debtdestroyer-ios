//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,0,2,0,2,0,1,0,1,0,0,0,2,0,2,0,1,0,1,0,0,0,2,0,2,0,1,0,1,0]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/younger_advice_2.mp4?ik-t=1675896588&ik-s=1bf7546d2946fe1264a2a6d5e6180dedd1057c9f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_tv_2.mp4?ik-t=1675896588&ik-s=ab52f671ae6cbfaf1519b61947ea82593680dffa","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_haircut_2.mp4?ik-t=1675896588&ik-s=dcf1f08cc2d976650ad8b3fb2f3acb112a5086bd","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/qualities_2.mp4?ik-t=1675896588&ik-s=ccd5c01e9a38ba61c0ede33aa4f820adf2d167b1","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/new_years_2.mp4?ik-t=1675896588&ik-s=680b32a39772b1307d54016ab20e4daf67213fff","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/lookalike_2.mp4?ik-t=1675896588&ik-s=22729ab0c5394e0127a4dc6a89c7637af6cf336a","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/favorite_christmas_2.mp4?ik-t=1675896588&ik-s=85653fff8ad17fe5febbabb42f6e51593ca5030f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/least_favorite_film_2.mp4?ik-t=1675896588&ik-s=550be0975022e3a94efedf1f826328b9ba664dd0","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/dream_car_2.mp4?ik-t=1675896588&ik-s=1e9219d0aa9d8197758e78d06712a06010a64811","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/celebrity_crush_2.mp4?ik-t=1675896588&ik-s=f2940b4ae4beeb67cc715d254702eb74efb38402","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/younger_advice_2.mp4?ik-t=1675896588&ik-s=1bf7546d2946fe1264a2a6d5e6180dedd1057c9f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_tv_2.mp4?ik-t=1675896588&ik-s=ab52f671ae6cbfaf1519b61947ea82593680dffa","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_haircut_2.mp4?ik-t=1675896588&ik-s=dcf1f08cc2d976650ad8b3fb2f3acb112a5086bd","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/qualities_2.mp4?ik-t=1675896588&ik-s=ccd5c01e9a38ba61c0ede33aa4f820adf2d167b1","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/new_years_2.mp4?ik-t=1675896588&ik-s=680b32a39772b1307d54016ab20e4daf67213fff","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/lookalike_2.mp4?ik-t=1675896588&ik-s=22729ab0c5394e0127a4dc6a89c7637af6cf336a","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/favorite_christmas_2.mp4?ik-t=1675896588&ik-s=85653fff8ad17fe5febbabb42f6e51593ca5030f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/least_favorite_film_2.mp4?ik-t=1675896588&ik-s=550be0975022e3a94efedf1f826328b9ba664dd0","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/dream_car_2.mp4?ik-t=1675896588&ik-s=1e9219d0aa9d8197758e78d06712a06010a64811","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/celebrity_crush_2.mp4?ik-t=1675896588&ik-s=f2940b4ae4beeb67cc715d254702eb74efb38402","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/younger_advice_2.mp4?ik-t=1675896588&ik-s=1bf7546d2946fe1264a2a6d5e6180dedd1057c9f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_tv_2.mp4?ik-t=1675896588&ik-s=ab52f671ae6cbfaf1519b61947ea82593680dffa","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/worst_haircut_2.mp4?ik-t=1675896588&ik-s=dcf1f08cc2d976650ad8b3fb2f3acb112a5086bd","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/qualities_2.mp4?ik-t=1675896588&ik-s=ccd5c01e9a38ba61c0ede33aa4f820adf2d167b1","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/new_years_2.mp4?ik-t=1675896588&ik-s=680b32a39772b1307d54016ab20e4daf67213fff","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/lookalike_2.mp4?ik-t=1675896588&ik-s=22729ab0c5394e0127a4dc6a89c7637af6cf336a","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/favorite_christmas_2.mp4?ik-t=1675896588&ik-s=85653fff8ad17fe5febbabb42f6e51593ca5030f","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/least_favorite_film_2.mp4?ik-t=1675896588&ik-s=550be0975022e3a94efedf1f826328b9ba664dd0","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/dream_car_2.mp4?ik-t=1675896588&ik-s=1e9219d0aa9d8197758e78d06712a06010a64811","https://ik.imagekit.io/3fe3wzdkk/IO9B12Zhug/celebrity_crush_2.mp4?ik-t=1675896588&ik-s=f2940b4ae4beeb67cc715d254702eb74efb38402"]
    
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
