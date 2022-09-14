//
//  QuestionViewController.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit
import BEMCheckBox

class QuestionViewController: UIViewController {
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceView] = []
    
    private var currentData: QuizDataParse {
        return quizDatas[currentIndex]
    }
    
    init(quizDatas: [QuizDataParse], currentIndex: Int) {
        self.quizDatas = quizDatas
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let questionView = QuestionView(frame: self.view.frame)
        self.view = questionView
        
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
        questionView.submitBtn.addTarget(self,
                                         action: #selector(submitPressed),
                                         for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func addAnswers(to stackView: UIStackView) {
        if let answers = currentData.answers {
            for (index, answer) in answers.enumerated() {
                let answerView = AnswerChoiceView(answer: answer)
                answerView.checkBoxView.tag = index
                answerView.checkBoxView.delegate = self
                answerViews.append(answerView)
                answerView.answerLabel.text = answer
                stackView.addArrangedSubview(answerView)
            }
        }
    }
    
    @objc private func submitPressed() {
        let hasCheckedBox = answerViews.contains { answerView in
            return answerView.checkBoxView.on
        }
        if !hasCheckedBox {
            BannerAlert.show(title: "Error", subtitle: "Please choose an answer", type: .error)
            return
        }
        
        let selectedAnswerIndex = answerViews.firstIndex { answerView in
            return answerView.checkBoxView.on
        }
        let isIncorrectAnswer = selectedAnswerIndex != currentData.correct_answer_index
        if isIncorrectAnswer {
            BannerAlert.show(title: "Incorrect Answer", subtitle: "This answer is incorrect. Please select a different one.", type: .error)
            return
        }
    }
}

extension QuestionViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        for (index, answerView) in answerViews.enumerated() {
            if index == checkBox.tag {
                answerView.select()
            } else {
                answerView.deselect()
            }
        }
    }
}
