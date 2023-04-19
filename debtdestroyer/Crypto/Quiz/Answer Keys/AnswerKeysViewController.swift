//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
        "A0DGdkFnPv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/h_body_2qxajjqptk6a32cad6pc8ck2f44ltih.mp4?ik-t=1682463117&ik-s=aca15a649da6ff0c4f7f8f055ed09c955358d2b9", correct_answer_index: 3),
        "YdBIdsi5m1": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/mfuckkill_2ss6nlma6b61zny43035j2osigxi7ij.mp4?ik-t=1682463117&ik-s=1052d703eb2fb412a1948aca4da165baf6e96917", correct_answer_index: 0),
        "KkvoVPam70": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/time_line_2unef2loj2f4wfdjuj68ow0twfch41r.mp4?ik-t=1682463117&ik-s=9b5e5891c634da3ed4042f82faf3c9091f1a311c", correct_answer_index: 0),
        "yuyEvFrAHX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/hair_dye_2nvn9v72r21z87eh7rgx06zrtn1dsvx.mp4?ik-t=1682463118&ik-s=b78ba15199416dd92625436e5b2633b3a042d60a", correct_answer_index: 1),
        "lMWYATR2AD": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/danger_city_2th1mmfbivunueluo8zr09k0zykovxc.mp4?ik-t=1682463118&ik-s=b742ebe6d4b9f669463a99c99ed5fc05fd8f7658", correct_answer_index: 1),
        "GnSg4w7LBY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/mj_song_2j9o42pz0l4pornthciiqkvnmu2rzf5.mp4?ik-t=1682463118&ik-s=26c8b91e863bcf3b5b833323ddba7c13b61e97db", correct_answer_index: 0),
        "b5rGxEUW23": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/souvenir_2tljv5jzh285kz03d9uprwuyv7ojngw.mp4?ik-t=1682463118&ik-s=f0fa4259cc67c85fe9228320b363ad24f800ab7c", correct_answer_index: 0),
        "Tw7SM7AY0C": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/rapper_dead_2w8vo505gbks3rbucrv3e3tojb5dqif.mp4?ik-t=1682463118&ik-s=d795fec0d0f6bf034792966eb8c4751963060d9a", correct_answer_index: 2),
        "e22RDFPvK0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/sport_money_2vsk43995lfcq8h3r33m2l2jayvz7po.mp4?ik-t=1682463119&ik-s=0169b5dc27796e54c2e8e3529e39c9c041aedb4f", correct_answer_index: 3),
        "CoQLQzMjIX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/special_closet_2crxzc6axjq6525p5ar3fd4ff1lyt4q.mp4?ik-t=1682463119&ik-s=b650f521470f2d25399ac3f8323eeacb3d182a6d", correct_answer_index: 1),
        "m7za5ZgDoS": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/fav_nick_2n3u3gyjibmcmtczxvffwt7as8oxw0t.mp4?ik-t=1682463119&ik-s=c7acf7a93093a47e558bfaf273d868c6891eb20c", correct_answer_index: 2),
        "CK1Ui70EHF": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/fav_object_2i52w46glhe75c3hlz426ognakepjwh.mp4?ik-t=1682463119&ik-s=cafa117bc747a85937cba48a31720ec06b392ac4", correct_answer_index: 0),
        "63nKvFoTcs": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/sleepover_act_23310k0v02ocqnm3p2877o46prhtmak.mp4?ik-t=1682463119&ik-s=640d6455d42bba19281dcd5567341b2ca9235887", correct_answer_index: 0),
        "0fvOBdVc5o": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/girl_273kmxcn8dr647z5n1qyq8untjdoye5.mp4?ik-t=1682463120&ik-s=a2a4526470c28080e054fe2c38caff4fceaf7d1e", correct_answer_index: 2),
        "qQUIJqSEvb": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/qj9KJEVImE/french_2ayaxpf5lk31nbefm7xc70ejdebdos2.mp4?ik-t=1682463120&ik-s=5e04cd371e050b776f8b7e6ad9474f188772a3a5", correct_answer_index: 2),
        "DVksEQhGsX": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_two_items_2fjlkdgjklidlg.mp4?ik-t=1682463124&ik-s=4dfdd06af5fd6a1f9d4eeb16d593554f57f6c49f", correct_answer_index: 1),
        "BW7gagrjni": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_bank_account_2rngon3ir747tvcpl96jpa3uj4n4wh8.mp4?ik-t=1682463124&ik-s=db487b9d0b138cc20783d8b0e1ecd330688cf25c", correct_answer_index: 0),
        "iwducnnI7i": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_wallpaper_2sdq4amggvbmls8g02vcdqbk0eztrs4.mp4?ik-t=1682463124&ik-s=6530f426cb46e8183bccdaa250d8c8f3bf85a24f", correct_answer_index: 0),
        "tH0SCGPJET": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_attractive_langauge_2athigjmq6zzwfm5997zria8vgrumr4.mp4?ik-t=1682463124&ik-s=34f3c17b81007be3eda328878b47cc0ee5636fdd", correct_answer_index: 1),
        "XuYGoBDGrZ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_bank_account_2l10w3csab779zfeppw3pfob7qnocja.mp4?ik-t=1682463125&ik-s=0aae807131988ace25735fd49b393317ecc63964", correct_answer_index: 0),
        "Uv7eu7ti7t": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_dream_job_2q8ec9ciodi7hpe288p9cmkntsoyxu6.mp4?ik-t=1682463125&ik-s=529ac1db18a28922dae288f90ccc7d1907ce5e5d", correct_answer_index: 0),
        "Jz8EnL5v22": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_make_day_2ewunfascd3b3jgktfpqr0qz6ddogzi.mp4?ik-t=1682463125&ik-s=595fefe02c88bd06228238c24c3555fd9b71e449", correct_answer_index: 0),
        "cCArM5CLAQ": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_never_told_2z06rwtcq1lz40apc1axd6vpsvp49zw.mp4?ik-t=1682463125&ik-s=17f787198ff60439eeeca694605a43acc1b9b1cc", correct_answer_index: 0),
        "BLmwSKXkrH": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_notice_2us19yicjuexvtuvoaf8poc1vmy123k.mp4?ik-t=1682463125&ik-s=8b529128ab2bc87e0cb5463c00d4534f36abbed7", correct_answer_index: 0),
        "COK6m6awa8": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_orbit_2ugbjtdf5x5io2kd6nwvrlt8gt7rqih.mp4?ik-t=1682463126&ik-s=2f1f323c52982e1e5cda5b35c505ba409739430e", correct_answer_index: 0),
        "Ho55Wc8EJP": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/f_smash_pass_243cjfsmlpn7lnew4icvsyd1gb0u3ag.mp4?ik-t=1682463126&ik-s=113d8820636749b00a3025491dd85679bbf6b143", correct_answer_index: 1)
    ]
    
    static func getItem(withId id: String) -> (answer_url: String, correct_answer_index: Int)? {
        if let item = answer_dict[id] {
            return item
        } else {
            return nil
        }
    }
    
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
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

}
//
//extension AnswerKeysViewController: UITableViewDataSource, UITableViewDelegate {
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 1
////    }
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return AnswerKeysViewController.correct_indices.count
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
////        let correctAnswerIndexStr = String(AnswerKeysViewController.correct_indices[indexPath.row])
////        cell.textLabel?.text = correctAnswerIndexStr + " & " + AnswerKeysViewController.answer_video_urls[indexPath.row]
////        return cell
////    }
////
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////    }
//
//}
