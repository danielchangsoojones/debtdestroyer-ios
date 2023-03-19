//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [3,1,3,1,2,3,1,0,0,0,2,2,2,0,1]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/snake_swallow_2.mp4?ik-t=1679788064&ik-s=04ea5dbc710ad956098686c5905de801c610bb5f","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/book_fan_base_2.mp4?ik-t=1679788064&ik-s=f127d9842c7bec6c278acf096959864bb5c1aed8","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/sexiest_woman_2.mp4?ik-t=1679788064&ik-s=90f063d33dbfc7904254aa7cedf9beb544726566","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/under_sheets_2.mp4?ik-t=1679788064&ik-s=6fa58923ca18952561af53a4b28e2599a303ae06","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/sneaky_link_2.mp4?ik-t=1679788064&ik-s=76e269b8c65af2ac1fd3b4e8373ac0d495e45fc8","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/shred_2.mp4?ik-t=1679788064&ik-s=07c1ffadc413ebe74945f8aa356dfc66abaaf818","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/s_t_d_2.mp4?ik-t=1679788064&ik-s=0e2037092f95bda95467eb5a1fd8ff35d762b7b8","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/something_rattles_2.mp4?ik-t=1679788064&ik-s=a37d8b0c3c1b64deda0f84f478cb9672147b6304","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/on_the_menu_2.mp4?ik-t=1679788064&ik-s=a15ff3a660c13b0c30eac702022ab2dde2812c4e","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/raging_blank_2.mp4?ik-t=1679788064&ik-s=885006c59e0f048c123f4dcce59a5408fb2e72ac","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/mrs_clauss_2.mp4?ik-t=1679788064&ik-s=edcdacbc9590a42004b592bbb199773ac43cd423","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/la_teams_2.mp4?ik-t=1679788064&ik-s=3ae50bfac650ca5c09795605b5120edcfde4e760","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/longest_relationship_2.mp4?ik-t=1679788064&ik-s=8a57518e97cc374322a974985cabf30695f2eb7e","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/house_never_enter_2.mp4?ik-t=1679788064&ik-s=09f576a3b6b8130e57c903920f51194f13de4950","https://ik.imagekit.io/3fe3wzdkk/kfhVKng3gK/besides_books_2.mp4?ik-t=1679788064&ik-s=e225df461665331b4eb77604153f21a9262dc94d"]
    
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
