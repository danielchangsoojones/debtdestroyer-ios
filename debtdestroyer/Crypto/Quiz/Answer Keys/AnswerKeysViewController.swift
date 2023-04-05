//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [3,1,0,0,1,0,1,0,0,0,3,1,1,2,0]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/avenger_2ufzy860vioxmftxmsdtnmry1zvo27i.mp4?ik-t=1681342598&ik-s=a0d823efac0ed6357a8a68be06c2d3d07d908831","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/big_goal_2shaiaqnx1g6glguq45qzaybtlkee9i.mp4?ik-t=1681342599&ik-s=39d46eab4ae8457db7d8a793e8b3d4f381b5c098","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/child_nightmare_28s180mkrbnmkpi3x4j2j6x40t787jo.mp4?ik-t=1681342600&ik-s=54b902f0a43125efd93e1629843c574ac59a7b37","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/exotic_2ow6pernpziwyhdlw0qawhckuos996w.mp4?ik-t=1681342600&ik-s=45d1607ee110a04d77dbef2a66a988a2209ec53a","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/e_body_2tujgll5ehzwqdauyb9gsvyrppgf9g8.mp4?ik-t=1681342600&ik-s=5cb062ab30a804990c9bc8be7c3a4bca70d7c22c","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/line_time_23ast7aubft23rujmb2eblat9bsokht.mp4?ik-t=1681342600&ik-s=1bf323b5c4eda19fdc318b4ff765c7a513a07718","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/line_time_why_2pqfe396f4005hw0dly04gzc2ofmww0.mp4?ik-t=1681342601&ik-s=11331d4c8a436caa1120cef3daac564637e2360a","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/carribean_island_2ut4phto2jwexv4ue5ra4pfz38ss8ia.mp4?ik-t=1681342601&ik-s=8f3da5a48cf8b3ecc4bde1af10240a224065c20c","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/one_place_21d1ji67qsghe17odezyblc57gj7f28.mp4?ik-t=1681342601&ik-s=25a2d88612a91488bb6fe6cd110c8fe934afb20d","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/one_place_why_25hiytaef0vhvpsmwyvy6l18w58p53h.mp4?ik-t=1681342601&ik-s=e5f3dd3a7f9b07fa403808936ff0818b3717ae79","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/regret_2m1t9tj4em0hf6di9gzl8wnobx6lcgx.mp4?ik-t=1681342601&ik-s=fa31120b1df46d99b5e0e41b54960563276c3129","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/holiday_hate_2xa98gdi8mmwosibgk5tgkv3z23f6c4.mp4?ik-t=1681342602&ik-s=43560d5ecdc5fa8efd3f277580c5c2705964cfea","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/movie_franchise_2sgjpoi1j21oz3ahpzzbnvzv0qv8dg6.mp4?ik-t=1681342602&ik-s=636c4913f6c8b217c29cb41bea21c82e5f445131","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/school_meal_2kf6seubi63sy1gbjagzuclrzjauzv6.mp4?ik-t=1681342602&ik-s=01994739bd4054eb37bf41921ce237be2a32249b","https://ik.imagekit.io/3fe3wzdkk/cHcLfZOOr8/end_santa_crush_2pqbkoko3jctxce5032dyit9mrkaifv.mp4?ik-t=1681342602&ik-s=9d90a4e0d10d13c4364ff44e6ffc203d1c947561"]
    
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
