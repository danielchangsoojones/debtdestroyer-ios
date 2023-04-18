//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] = [
    "Ag1X4g6K2I": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/intro_n_state_212fe0mn2ft6abtx85qemuzpc9u9vuz.mp4?ik-t=1682380758&ik-s=a720180582c2604d7bd17da9ee7ba3bd6571dd47", correct_answer_index: 0),
    "pX2vCcPXTM": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/worst_date_26ro7k0n03sguzfrgt5xeu88e343poq.mp4?ik-t=1682380758&ik-s=d62744e1ae79f73edce599726adf22ba100b26da", correct_answer_index: 1),
    "Ifs0BooqS1": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/carnival_food_2w7ng62ktz1qn3xngjz7wjugx3al84j.mp4?ik-t=1682380758&ik-s=b517b1f52b53992d033706dd4b70aca44fd5ba46", correct_answer_index: 2),
    "5cbqtQiAGp": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/exp_meal_23gsmcly1qxf3gu3k0uo6hvzkwivlbn.mp4?ik-t=1682380759&ik-s=fdfc9cd00e2e457c0b22a3f0ea340e5812e78d1d", correct_answer_index: 2),
    "4yOKGsEJgv": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/fav_object_2fr70qdkrnjdkfgki7sonhkpy9sbgh2.mp4?ik-t=1682380759&ik-s=8bba17aef7d499877325422ecc478a81b2ab5f8c", correct_answer_index: 0),
    "ujSGdPawyg": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/h_body_2qxajjqptk6a32cad6pc8ck2f44ltih.mp4?ik-t=1682380759&ik-s=535d076b4e2e455a27a4910f0ccd232b445dd8fd", correct_answer_index: 0),
    "vcB9jaIqrV": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/mfuckkill_2ss6nlma6b61zny43035j2osigxi7ij.mp4?ik-t=1682380759&ik-s=a48454b11a25f34b4f14e09db775ab6e1508d039", correct_answer_index: 3),
    "r9giPCLDeC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/time_line_2unef2loj2f4wfdjuj68ow0twfch41r.mp4?ik-t=1682380759&ik-s=d6477ff2ee75a2ef1c8abc297a981f147a1f3e3e", correct_answer_index: 2),
    "Sg39nH7Pss": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/hair_dye_2nvn9v72r21z87eh7rgx06zrtn1dsvx.mp4?ik-t=1682380760&ik-s=3281fc3980391df3cbe150c0bc984e97cc14dc79", correct_answer_index: 3),
    "F0KAWkRk9C": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/danger_city_2th1mmfbivunueluo8zr09k0zykovxc.mp4?ik-t=1682380760&ik-s=49eb7343f6faeaf9a73def94b1134d4c6b1fce29", correct_answer_index: 0),
    "hIKZHoY7Uj": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/mj_song_2j9o42pz0l4pornthciiqkvnmu2rzf5.mp4?ik-t=1682380760&ik-s=fb96c9534a9c3c018508c3f9d61bfed860e15e2c", correct_answer_index: 2),
    "Z26tAEmGHr": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/souvenir_2tljv5jzh285kz03d9uprwuyv7ojngw.mp4?ik-t=1682380760&ik-s=8e98963c2dee71ecf148511db2be88a25ab82827", correct_answer_index: 3),
    "w0P5YOUYB7": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/rapper_dead_2w8vo505gbks3rbucrv3e3tojb5dqif.mp4?ik-t=1682380760&ik-s=47ecb186217a5a8d3782260266fd6be9aac9378d", correct_answer_index: 2),
    "U3POlKAi6Q": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/sport_money_2vsk43995lfcq8h3r33m2l2jayvz7po.mp4?ik-t=1682380761&ik-s=416a2368c800d473c4b572a80e26c3b6841b6f0f", correct_answer_index: 3),
    "SMyAS0JEYu": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/special_closet_2crxzc6axjq6525p5ar3fd4ff1lyt4q.mp4?ik-t=1682380761&ik-s=206efa185d887e04ca93fb67d14a165f182d31ef", correct_answer_index: 1),
    "KOoCqvwI6I": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_wallpaper_2tcrge9q8y74y2qswg5xizb66ersnq5.mp4?ik-t=1682380765&ik-s=a002dbe92961b5d498ca6172761bc74d051498af", correct_answer_index: 0),
    "QBtLPGW48e": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_rf_24cvocszd8j2nwl7ilh5je1zbjfnqwq.mp4?ik-t=1682380765&ik-s=9d44586ad3863621d06a618dd3d6e1e1a3f51b60", correct_answer_index: 1),
    "qP7apKcFze": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_wall_other_21qzqso6we6ph9grrx9c5cfhfqxe87c.mp4?ik-t=1682380765&ik-s=27ec7fbc70cfd22012c0cf64f8565bca6b97d2fc", correct_answer_index: 0),
    "8HQybt3w1P": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_money_2497tnm7o40axizjm2i9i7p0udijj9z.mp4?ik-t=1682380765&ik-s=cd232397c44fa5197656ee090397435ec61b8162", correct_answer_index: 1),
    "b6QbPsgF5E": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_body_count_2jetnuelgn4z2sxiaoezxbhegbcbc99.mp4?ik-t=1682380766&ik-s=4675ecce15a57816fbcd2560ce834dadf876c886", correct_answer_index: 1),
    "mYAEfAHF3W": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_for_a_living_2ru47cktxh857b9q022e6pc54dagjk5.mp4?ik-t=1682380766&ik-s=ccdaad085ad4a5b2dea1d6ef648c347efafa4045", correct_answer_index: 0),
    "VTTTgnNeQY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_language_22x4dfsox065wchxvgg0uvcj6m0qkhe.mp4?ik-t=1682380766&ik-s=283e64df68b8ad1483a209a4ea49e6b7800943a6", correct_answer_index: 1),
    "TZE4ElQdQd": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_mean_guys_22sjstcy9su4uipqr254mxp3pnh6tbd.mp4?ik-t=1682380766&ik-s=8bfdfacafd7c649e280451935d91b156a688d433", correct_answer_index: 1),
    "B1zrjj5var": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_red_flag_2en0qh248p740b1uhbft4qcw4i2j7rc.mp4?ik-t=1682380766&ik-s=ba8aa7f42c45c2546d612b05648648eec1ee4e42", correct_answer_index: 0),
    "G5Y4bX77ji": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_too_short_2hvcxsdkecy8nhswfsz7ztzdrv4q1hs.mp4?ik-t=1682380767&ik-s=782521f0083461e9553234b5e881b42ca6ea1edb", correct_answer_index: 0),
    "xAzyPEDwA7": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_two_items_2fjlkdgjklidlg.mp4?ik-t=1682380767&ik-s=0cada9cb076d0b546ec4959268b454439742d5b3", correct_answer_index: 1)
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
