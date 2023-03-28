//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [0,1,2,3,3,3,3,0,1,2,0,0,2,0,3]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/baseball_team_2esbi6mxnfpwgy24hwluyoiuiejn6gv.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/food_carnival_2rg13gg5vra6m0n1e62lfk04ka9b0ba.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/flag_red_227nfcyeua68eojk3rjsjy76kjv1dte.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/best_sport_20v7jwim24fg9okhogb0g1wuoh38ixa.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/holiday_hate_2sw8alrus62naqp1w6k3syhc2vlyrxd.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/n_state_2g7ml6b0tqvxjsbsyns4uz2uumi420n.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/dream_283i0tj1lut01t71uhgfz18eymp6vgm.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/public_school_meal_258zugkcm4b78fuah8wyh0sxqqyibn1.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/one_place_22a0flqnnektba0qfsmo4nept57geig.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/line_time_20002fwb1431w2dyau1e1mydecnedsr.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/c_state_2qtvgi32fix196mw0nrl0ey03a4if6t.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/line_time_why_2rxoeiud7ugchiey1yq6cw4jyk3escx.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/exotic_pet_2v25jw05i0o4tyt3ry8bw1z2e0i5rrd.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/a_state_2ruaw5803xeq78qr2133tg7etbejypk.mp4","https://ik.imagekit.io/3fe3wzdkk/wPBFTGLGRx/end_regret_2pbmyc63ureq2njjk4xslhccsx3pvqf.mp4"]
    
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
