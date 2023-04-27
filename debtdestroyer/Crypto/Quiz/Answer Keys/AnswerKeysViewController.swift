//
//  AnswerKeysViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 24/01/23.
//

import UIKit

class AnswerKeysViewController: UIViewController {
    static let answer_dict: [String: (answer_url: String, correct_answer_index: Int)] =
[
    "Y7HejuuAFA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/intro_n_state_212fe0mn2ft6abtx85qemuzpc9u9vuz.mp4?ik-t=1682374117&ik-s=f138609257d6ea212b7aec945ed69490136a3bad", correct_answer_index: 0),
    "LML94TKR6c": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/worst_date_26ro7k0n03sguzfrgt5xeu88e343poq.mp4?ik-t=1682374117&ik-s=aec37581b4a8e4501c2fefe9ae9484f65cd9290c", correct_answer_index: 0),
    "vPzxodBvpa": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/carnival_food_2w7ng62ktz1qn3xngjz7wjugx3al84j.mp4?ik-t=1682374117&ik-s=54b1855ba9d0c4863f76d026cd680501983e219f", correct_answer_index: 1),
    "E4HXCEiEdG": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/exp_meal_23gsmcly1qxf3gu3k0uo6hvzkwivlbn.mp4?ik-t=1682374117&ik-s=5b4ee41880ba3d1dea47208f59faf50af1a43139", correct_answer_index: 2),
    "q8Xbkef6gM": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/fav_object_2fr70qdkrnjdkfgki7sonhkpy9sbgh2.mp4?ik-t=1682374118&ik-s=9bb6fa1d733675247e9e0e2ab7093f8279dc611d", correct_answer_index: 3),
    "aHvxlUDSRA": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/h_body_2qxajjqptk6a32cad6pc8ck2f44ltih.mp4?ik-t=1682374118&ik-s=0e576e1e605f5d53aac77c81ddb802a70be4c094", correct_answer_index: 1),
    "ADUQfgUKyw": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/mfuckkill_2ss6nlma6b61zny43035j2osigxi7ij.mp4?ik-t=1682374118&ik-s=d60a87f5750cf4a3bd64a563c641798afe2fd503", correct_answer_index: 0),
    "PiaSNyND60": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/time_line_2unef2loj2f4wfdjuj68ow0twfch41r.mp4?ik-t=1682374118&ik-s=db796ad6a57debe7183f89c5e7d6be1c40c89d62", correct_answer_index: 3),
    "Hlo5xtlXGe": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/hair_dye_2nvn9v72r21z87eh7rgx06zrtn1dsvx.mp4?ik-t=1682374118&ik-s=eae3de46ecc376b85814ad59d307d1ea17fffdf3", correct_answer_index: 3),
    "GWirnEVn2E": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/danger_city_2th1mmfbivunueluo8zr09k0zykovxc.mp4?ik-t=1682374119&ik-s=9fd180c7a4ebe4b8681c23feab5a7c136c43d12e", correct_answer_index: 1),
    "lHygQw4hon": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/mj_song_2j9o42pz0l4pornthciiqkvnmu2rzf5.mp4?ik-t=1682374119&ik-s=d93efa0da0270546bd427e0dd022a4cd5af0a1ae", correct_answer_index: 2),
    "xYQ95XQ6kb": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/souvenir_2tljv5jzh285kz03d9uprwuyv7ojngw.mp4?ik-t=1682374119&ik-s=d17d7349d1dcdeeef0e32e7fc85d94d0929573a3", correct_answer_index: 0),
    "TmGkKBPtdC": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/rapper_dead_2w8vo505gbks3rbucrv3e3tojb5dqif.mp4?ik-t=1682374119&ik-s=e60299dde349cbc067b046286f35fc9a968eb58f", correct_answer_index: 0),
    "yBxgZAOXfu": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/sport_money_2vsk43995lfcq8h3r33m2l2jayvz7po.mp4?ik-t=1682374119&ik-s=c0b2ce1fb5c55a4640afec660751bd2b7337f203", correct_answer_index: 3),
    "SCrb8bem6o": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/Q4kNIr6rTB/special_closet_2crxzc6axjq6525p5ar3fd4ff1lyt4q.mp4?ik-t=1682374120&ik-s=06e26c7ee6ecb7c5caeea0c3406b073985e16f49", correct_answer_index: 2),
    "ly4CDtadY0": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_wallpaper_2tcrge9q8y74y2qswg5xizb66ersnq5.mp4?ik-t=1682374124&ik-s=ea4234fd27d5e6ed7047672548797e62a5136ec3", correct_answer_index: 1),
    "aagKCtQgGW": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_rf_24cvocszd8j2nwl7ilh5je1zbjfnqwq.mp4?ik-t=1682374124&ik-s=32306f5faca45ed552808d40289755bb18728bff", correct_answer_index: 1),
    "8B7QKlos34": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/d_wall_other_21qzqso6we6ph9grrx9c5cfhfqxe87c.mp4?ik-t=1682374124&ik-s=100130e3756a1b4a86de192882d005665fd4c07a", correct_answer_index: 1),
    "MNPzd2gHlf": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_money_2497tnm7o40axizjm2i9i7p0udijj9z.mp4?ik-t=1682374124&ik-s=adebf466dc1f9e1aad1d3112f34028137b303b33", correct_answer_index: 1),
    "B6yr6th4uY": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_body_count_2jetnuelgn4z2sxiaoezxbhegbcbc99.mp4?ik-t=1682374124&ik-s=4d6e476c885c3149605f4b4c11d59c85fe67c3c1", correct_answer_index: 0),
    "VqoAzCH8PR": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_for_a_living_2ru47cktxh857b9q022e6pc54dagjk5.mp4?ik-t=1682374125&ik-s=af0e07fc5277bddd85556f885902af0905a3beb2", correct_answer_index: 1),
    "pJiDcwjCKe": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_language_22x4dfsox065wchxvgg0uvcj6m0qkhe.mp4?ik-t=1682374125&ik-s=dd4ea7e29940fecfa6aa6610c7e89c012297a8f3", correct_answer_index: 0),
    "wS41JK1Slb": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_mean_guys_22sjstcy9su4uipqr254mxp3pnh6tbd.mp4?ik-t=1682374125&ik-s=3d079f0a344bf186130e0a52f5d1d3cb09b3d496", correct_answer_index: 0),
    "d9GYOZi83L": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_red_flag_2en0qh248p740b1uhbft4qcw4i2j7rc.mp4?ik-t=1682374125&ik-s=374e4896f03bd62f25def603d95976e427c32d46", correct_answer_index: 1),
    "4TtEQX8t63": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_too_short_2hvcxsdkecy8nhswfsz7ztzdrv4q1hs.mp4?ik-t=1682374125&ik-s=2900420f99fd0f9586c290790c92135c8d236c4d", correct_answer_index: 0),
    "dSZ7mDZzIh": (answer_url: "https://ik.imagekit.io/3fe3wzdkk/difficulty/e_two_items_2fjlkdgjklidlg.mp4?ik-t=1682374126&ik-s=68f370fe84dff643cf39a369999b9b6b2347717d", correct_answer_index: 1)
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
