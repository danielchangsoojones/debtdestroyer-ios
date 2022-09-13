//
//  QuestionViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class QuestionViewController: UIViewController {
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private let answerViews: [AnswerChoiceView] = []
    
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int) {
        self.quizDatas = quizDatas
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        let questionView = QuestionView(frame: self.view.frame)
        self.view = questionView
        
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func addAnswers(to stackView: UIStackView) {
        if let answers = answers {
            for answer in currentData.answers {
                let answerView = AnswerChoiceView(answer: answer)
                answerViews.append(answerView)
                stackView.addArrangedSubview(answerView)
            }
        }
    }
}
