//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [1,3,1,3,1,0,0,0,0,1,2,1,3,3,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/christmas_2.mp4?ik-t=1676847535&ik-s=199a3b7ffc491d7c8f08c0da6f24b9be6e326d3d","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/creepy_2.mp4?ik-t=1676847535&ik-s=5f3d6fff6f8bd994d39ef5a6ee23964e6df830b2","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/famous_2.mp4?ik-t=1676847535&ik-s=d55a1c6a1ae1c9baf662b36448fe4593240fd495","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/why_would_you_go_to_jail_2.mp4?ik-t=1676847535&ik-s=e04139eed4f637124f0248eb1940c5934380bb4b","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/ice_cream_2.mp4?ik-t=1676847535&ik-s=abf029e33f4520695d11dbf68249c09fa4863bb9","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/famous_contact_2.mp4?ik-t=1676847535&ik-s=259d1f71d5b82a1bdca765bddff8a6ed790ade1f","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/language_2.mp4?ik-t=1676847535&ik-s=5a43051ba4614fac55e1200bfd7e789bd7eebf72","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/last_night_2.mp4?ik-t=1676847535&ik-s=5d349a8443bb35a08379a54eec512cecca553dfe","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/best_rapper_2.mp4?ik-t=1676847535&ik-s=cf64f4d1a56d8fadeb49b36c63d633b653b9f75c","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/least_favorite_2.mp4?ik-t=1676847535&ik-s=f87cef2db8553819bd7a5d75413020414fccf02c","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/love_2.mp4?ik-t=1676847535&ik-s=214174ed71d9a0ffecfb16221fd221dac485d5ac","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/one_thing_you_would_change_about_yourself_2.mp4?ik-t=1676847535&ik-s=47e867a8bd0d47005bbe231fb305800c84912ab5","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/weird_2.mp4?ik-t=1676847535&ik-s=997ac7793a416cfa380ac657085578933f0ed2b6","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/thoughts_on_corporate_america_2.mp4?ik-t=1676847535&ik-s=3a46a7e803fc10f5944e2917f2f8a375f7087013","https://ik.imagekit.io/3fe3wzdkk/yDhlGUlQnP/whats_your_dream_job_2.mp4?ik-t=1676847535&ik-s=1df732affd14bd893978cd1247499bd94dcc8ee2"]
    
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
