//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [2,2,2,0,2,3,2,0,2,3,1,1,2,3,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/no_love_song_2y99tn16s6ihs0clwescbx0hfwtuxxb.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/car_brand_2tq9pqg0ja5bqwjorpaksmz3oxbn7sn.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/decorate_25tbg428wfjzjoimq8zsri6xepb7h89.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/app_off_29txgexznktxff1natpomw8klygah09.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/cali_city_2k7g8msnvq294nvhko00jhdwchvres8.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/carnival_food_27msfx4iezhcky3op69xn8rjmrhbctg.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/fear_big_2ubqw4898ao8v9gcjm4apzsmm9vcw7p.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/fear_big_why_2hv7jrhvp39lce44s1clow5dkhnitc7.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/i_state_23us01the0xowdkzu74st012k5e7wkl.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/sleepover_act_2d7j5s77b0ndtch1dh5s4lfzp5b7rqg.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/day_gift_2kbudihbdgqtjzas5hma26lpdh9hrmb.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/furniture_2pcqapstv5tbrkdms7xijq01g926et6.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/indian_dish_2r9amyazmir4b5aarvs83vyym95ja54.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/mammal_2z9rzywlnvy1u7fl8gonscbwz6xe919.mp4","https://ik.imagekit.io/3fe3wzdkk/FwocYezJrS/end_n_state_2ego93s9ib0n19i73obbynhacy842xu.mp4"]
    
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
