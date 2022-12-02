//
//  QuizManagerViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/11/22.
//

import UIKit
import SCLAlertView

class QuizManagerViewController: UIViewController {

    var questionLabel = UILabel()
    var questionPromptBtn = UIButton()
    var revealAnswerBtn = UIButton()
    private let dataStore = QuizManagerDataStore()

    override func loadView() {
        super.loadView()
        let quizManagerView = QuizManagerView(frame: self.view.frame)
        self.view = quizManagerView
        self.questionLabel = quizManagerView.questionLabel
        self.revealAnswerBtn = quizManagerView.revealAnswerBtn
        self.questionPromptBtn = quizManagerView.questionPromptBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarBtns()
        revealAnswerBtn.addTarget(self,action: #selector(revealAnswerPressed),for: .touchUpInside)
        questionPromptBtn.addTarget(self,action: #selector(questionPromptPressed),for: .touchUpInside)

    }
    
    private func setNavBarBtns() {
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func revealAnswerPressed() {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            contentViewColor: .red
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Reveal Answer"){
            self.dataStore.markQuizStatus(shouldStartQuestionPrompt: false, shouldRevealAnswer: true) { result in
                
            }
            
        }
        
        alertView.addButton("Skip") {
            
        }
        alertView.showNotice("", subTitle: "Are you sure you want to reveal the answer?")
    }
    
    @objc private func questionPromptPressed() {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            contentViewColor: .purple
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Show Question") {
            self.dataStore.markQuizStatus(shouldStartQuestionPrompt: true, shouldRevealAnswer: false) { result in
                print(result)
            }

        }
        
        alertView.addButton("Skip") {
            
        }
        alertView.showNotice("", subTitle: "Are you sure you want to show the question prompt?")
    }
    

}
