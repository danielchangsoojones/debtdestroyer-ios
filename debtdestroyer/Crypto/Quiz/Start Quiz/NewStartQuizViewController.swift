//
//  NewStartQuizViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/11/22.
//

import UIKit

class NewStartQuizViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        let newStartQuizView = NewStartQuizView(frame: self.view.frame)
        self.view = newStartQuizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
