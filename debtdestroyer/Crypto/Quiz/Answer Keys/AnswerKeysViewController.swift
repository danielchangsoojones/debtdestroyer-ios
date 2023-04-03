//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let correct_indices = [3,0,0,2,3,0,1,2,3,1,3,0,3,1,0]
    static let answer_video_urls = ["https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/intro_marvel_23dg8n2wpnmeex15sa2u1o4tx9p4leh.mp4?ik-t=1681170530&ik-s=aa288443c93412327857172031bd13ca31096fca","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/wife_baker_2ca1v4b892pt6tpatwec58kcotrh3zj.mp4?ik-t=1681170531&ik-s=bd928e16aafe837117f5811af7874630f0718af1","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/resume_2bpgst8ctwvnw65ce9otdfq2dlofp82.mp4?ik-t=1681170531&ik-s=eae225f976346992fa4e537fb3875ec6e94b8811","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/brunch_date_2qtcbjymm61glsw3rq3gyh4b60916ed.mp4?ik-t=1681170531&ik-s=aac79d49bffd9a3d88a76c7b3ef58faad29af0a4","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/exp_meal_24ugkiz35iqrb828eunurfonf19fi87.mp4?ik-t=1681170532&ik-s=abb96afe72bb5854d7c02e3b56be35165805130f","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/exp_meal_why_25ui7vogmamgbqjqqag3nofb2rdluku.mp4?ik-t=1681170532&ik-s=6328ea74412db18d36bcaebeaf9bc369600523c8","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/gift_day_2ob7bkjb4gd6w00cubgjar3fq6cgz0k.mp4?ik-t=1681170532&ik-s=c9fb78ecb5ee1a570280d80eff4a586db36d57f2","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/italian_city_2xo6fkfi6p6akhgznyhg79gqqvboilm.mp4?ik-t=1681170532&ik-s=1fe0d45881896ae7591031f25e1d424f1d5884a3","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/live_without_2qkppgy976sakhmn3ru2s94sma1dxui.mp4?ik-t=1681170533&ik-s=6fb44932cad9af0e692281ce84e20d018335b225","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/lottery_spend_2l3db4se9bvpah88ikmhq4pv538cgvo.mp4?ik-t=1681170533&ik-s=c478861c98c2e983aeafce607263059d47c367e2","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/place_one_2caoh7nb3yj4y1auc6xvgoq2a6rgnn9.mp4?ik-t=1681170533&ik-s=c295a8c90a96b2cda0870e28c898d85d90ace7b4","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/place_one_why_2yfrf9vseeqdoyaels0yrpjnvh4dnmm.mp4?ik-t=1681170533&ik-s=71bc1c9bb51a7f2331c6e664847d3eef6eff285e","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/remade_movie_2thbqxwwm4nr3crgrv0f6h0ubl7q6aq.mp4?ik-t=1681170534&ik-s=7ef3dbc5b86f0dc9c3f94f840de97a0a56dd5adf","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/trait_2v1jpq31qn587hmtjt3j01s39mg6is4.mp4?ik-t=1681170534&ik-s=ebb7a85d36bffc27d26deb2010886dfbfd415916","https://ik.imagekit.io/3fe3wzdkk/BQPMOTcVYm/e_body_285zso01x2d23d54y3wh79khkrifinr.mp4?ik-t=1681170534&ik-s=f278ef4e68718be9686704a26faf581fac6ba1ff"]
    
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
