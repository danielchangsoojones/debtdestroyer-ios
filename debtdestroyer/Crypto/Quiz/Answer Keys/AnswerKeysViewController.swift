//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [1,0,3,1,1,2,2,2,1,2,3,2,1,3,3]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/starting_career_2.mp4?ik-t=1679358562&ik-s=5632915e6d4a010c65eab7a720b01aa177dfdf20","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/thoughts_on_ray_2.mp4?ik-t=1679358562&ik-s=69a2fc14eb4d232ae9fc0530e51ec779cf56232e","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/candy_bar_2.mp4?ik-t=1679358562&ik-s=c8e705dab06411fbff17df2f5ec1e39a14814d32","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/favorite_candy_bar_2.mp4?ik-t=1679358562&ik-s=52e6f4146520f4730f64f29cb4beb7cc4e40df42","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/sexiest_woman_2.mp4?ik-t=1679358562&ik-s=2b3dc4ff3b5d95981e4ced86d0452051c55c873b","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/worst_thing_2.mp4?ik-t=1679358562&ik-s=44a78fd6890a0d8860b019a6ba38104647c1c651","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/j_occupation_2.mp4?ik-t=1679358562&ik-s=84cbfc88d35146abe5e7e53a41ce45a0b5508abe","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/under_100k_2.mp4?ik-t=1679358562&ik-s=a3aa3e846b7ec21926709194d457e179784cf005","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/buy_engagement_2.mp4?ik-t=1679358562&ik-s=eb04a3d4989c37c88e5441c601360d124d4aed44","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/nightmares_2.mp4?ik-t=1679358562&ik-s=eb354121b560e01bb895f286c1fd943249c1b6bd","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/bad_neighbor_2.mp4?ik-t=1679358562&ik-s=31453dde80202c4ff8485d36429429dc21b16423","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/cant_live_2.mp4?ik-t=1679358562&ik-s=9b58d02de163e79691eb35b5df2a1e03fad870c4","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/last_movie_2.mp4?ik-t=1679358562&ik-s=1a5e837858a340a46ff0970c554468af3476899d","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/windy_2.mp4?ik-t=1679358562&ik-s=83f9c4c7ef764496951f62198dddad3166db3346","https://ik.imagekit.io/3fe3wzdkk/c7Ms3paZYq/ducks_do_2.mp4?ik-t=1679358562&ik-s=ff353ac22357aae734c1483b9d4e5a6563710671"]
    
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
