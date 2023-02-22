//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,1,0,3,1,0,3,2,0,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/do_you_have_a_valentine_2.mp4?ik-t=1677709917&ik-s=bb6be67fb34808034a0ac412ca175cb4cfcd0b3c","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/ask_valentine_2.mp4?ik-t=1677709917&ik-s=0add12c0047f0c63819e9c07a23df8ec087617ca","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/biggest_fear_2.mp4?ik-t=1677709917&ik-s=530b15cc8e5ad9d8e0a21916a31c9bb493830377","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/exp_valentine_2.mp4?ik-t=1677709917&ik-s=a7585b233209a201b29d4bf81fbd8b243ba07c62","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/must_he_ask_2.mp4?ik-t=1677709917&ik-s=1e4716c0fc6be47dec3f07c78a1e77b2682a1e27","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/nyc_hood_2.mp4?ik-t=1677709917&ik-s=365d3cc27e97c29ead01cc695b12be64339fab50","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/see_oustide_2.mp4?ik-t=1677709917&ik-s=f0ab4fb48fd0910a791971bc3919b8a0a6bc122b","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/woman_trait_2.mp4?ik-t=1677709917&ik-s=022d9f3ca3c9ab039c5da6ca838ba53cad6aefc2","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/young_hooper_2.mp4?ik-t=1677709917&ik-s=5eaa8aa3e5c4e93e0a37b58591ec073200f5dc4d","https://ik.imagekit.io/3fe3wzdkk/wKsUO0CGal/woman_sub_2.mp4?ik-t=1677709917&ik-s=f94aee0b746af1045cdad6b3613f4c9985fad41c"]
    
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
