//
//  HowDoesRoundUpWorksViewController.swift
//  nbawidget
//
//  Created by Rashmi Aher on 03/08/22.
//

import UIKit

class HowDoesRoundUpWorksViewController: UIViewController {

    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTableView()
    }
    
    private func setTableView() {
        tableView = UITableView(frame: self.view.frame)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.register(cellType: RoundUpWorksView.self)
        tableView.backgroundColor = .systemGray5
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    @objc private func closePressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension HowDoesRoundUpWorksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RoundUpWorksView.self)
        
        cell.closeBtn.addTarget(self,
                                 action: #selector(closePressed),
                                 for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
}
