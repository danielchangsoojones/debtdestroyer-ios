//
//  QuestionNewUIViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit
import BEMCheckBox

class QuestionNewUIViewController: UIViewController {
    var circularView = CircularProgressCountdownTimerView()
    var duration: TimeInterval!
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
        let questionView = QuestionNewUIView(frame: self.view.frame)
        self.view = questionView
        
        questionView.questionLabel.text = "The UIViewController class defines the shared behavior that is common to all view controllers. You rarely create instances of the UIViewController class directly. Instead, you subclass UIViewController and add the methods and properties needed to manage the view controller's view hierarchy.The UIViewController class defines the shared behavior that is common to all view controllers. You rarely create instances of the UIViewController class directly. Instead, you subclass UIViewController and add the methods and properties needed to manage the view controller's view hierarchy."//currentData.question
        addAnswers(to: questionView.answerStackView)
        self.circularView = questionView.circularView

//        questionView.submitBtn.addTarget(self,
//                                         action: #selector(submitPressed),
//                                         for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        duration = 15
        circularView.progressAnimation(duration: duration)
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
        
        let nextIndex = currentIndex + 1
        let isLastQuestion = !quizDatas.indices.contains(nextIndex)
        if let quizTopic = quizDatas.first?.quizTopic, isLastQuestion {
            if !User.shouldShowEarnings {
                let feedbackVC = ProvideFeedbackViewController(quizTopicDatas: quizTopic)
                self.navigationController?.pushViewController(feedbackVC, animated: true)
            } else {
                let addressVC = AddressViewController(quizTopicDatas: quizTopic)
                self.navigationController?.pushViewController(addressVC, animated: true)
            }
        } else {
            let correctVC = FinishAnimationViewController(quizDatas: quizDatas,
                                                          currentIndex: currentIndex)
            self.navigationController?.pushViewController(correctVC, animated: true)
        }
    }
}
extension QuestionNewUIViewController: BEMCheckBoxDelegate {
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
