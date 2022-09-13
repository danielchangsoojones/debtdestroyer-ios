//
//  QuizViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class QuizViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let quizView = QuizView(frame: self.view.frame)
        self.view = quizView
        
        quizView.nextButton.addTarget(self,
                                      action: #selector(nextBtnPressed),
                                      for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nextBtnPressed() {
        //TODO: segue to next screen.
    }
}
