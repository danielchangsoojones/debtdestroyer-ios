//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,1,3,0,0,3,0,0,2,1,2,3,3,3,2]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/sleepover_2hd6ebhnbpwm1wxljzp015n04emvb5w.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/hate_holiday_29ai5vqsvsnlvjzyyp1tdfp5zvh2vp0.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/food_carnival_2sqc2alnam6ujrwgb0yq3hg2hv49ml0.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/brunch_meal_2075jog1fs81m5agdfst4sqip5iufxf.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/meal_how_much_2ijibpmhekz2319022jng9qd58l907k.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/turn_off_267of0f0unwtx6o6xrg7ffqyxsxrgav.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/resume_250fkwfue3cqjwzhyn7208oq21lnyqr.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/m_state_2d7ybdghwnv0i4vv99mzgw1zspbcc6i.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/country_french_297ls27maxjm7i5blhfmbesq53wi7ts.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/movie_remake_28bk00175uw3tl98iodn5n431d46jk9.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/decorate_2dyf6pjsbpda56x9c4norbkvq1sf01v.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/vampire_22qqowmhb2z8z28nzirhq0i9aajg3p7.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/disney_2i25g9ck5x7yrkkxvgyfmeujgcpu3sc.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/job_interview_2ye4p5kdh37yffhgqnkzlr3olgi54pz.mp4","https://ik.imagekit.io/3fe3wzdkk/BUL9rGQcGi/marvel_avenger_21vdsvkejg6tjsy5skump0y6xzfex6p.mp4"]
    
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
