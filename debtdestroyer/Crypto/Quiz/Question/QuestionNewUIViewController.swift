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
    var targetDate: Date = Date()
    var timer = Timer()
    
    lazy var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .brief
        
        return formatter
    }()
    private let quizDatas: [QuizDataParse]
    private let currentIndex: Int
    private var answerViews: [AnswerChoiceNewUIView] = []
    var backBtn = UIButton()

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
        
        questionView.questionLabel.text = currentData.question
        addAnswers(to: questionView.answerStackView)
        self.circularView = questionView.circularView
        self.backBtn = questionView.backBtn
        backBtn.addTarget(self,action: #selector(backPressed),for: .touchUpInside)
//        questionView.submitBtn.addTarget(self,
//                                         action: #selector(submitPressed),
//                                         for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let calendar = Calendar.current
        targetDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        formatDuration(from: Date(), to: targetDate)
        
        duration = 15
        circularView.progressAnimation(duration: duration)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        formatDuration(from: Date(), to: targetDate)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerTicked(_:)), userInfo: nil, repeats: true)

//        self.timer = timer
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        timer.invalidate()
//        timer = nil
    }
    
    @objc func timerTicked(_ timer: Timer) {
        formatDuration(from: Date(), to: targetDate)
    }
    
    func formatDuration(from: Date, to: Date) {
        let text = durationFormatter.string(from: to.timeIntervalSince(from))
//        label.text = text
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        for (index, answerView) in answerViews.enumerated() {
            if index == gesture.view?.tag {
                answerView.select()
                answerView.checkBoxView.on = true
                submitPressed()

            } else {
                answerView.deselect()
            }
        }
    }
    
    private func addAnswers(to stackView: UIStackView) {
        if let answers = currentData.answers {
            for (index, answer) in answers.enumerated() {
                let answerView = AnswerChoiceNewUIView(answer: answer)
                answerView.backgroundColor = .white
                answerView.layer.cornerRadius = 12
                answerView.checkBoxView.tag = index
                answerView.tag = index
                answerView.checkBoxView.delegate = self
                answerView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))

                answerViews.append(answerView)
                answerView.answerLabel.text = answer
                stackView.addArrangedSubview(answerView)
                answerView.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
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
            
            for (index, answerView) in answerViews.enumerated() {
                if index == selectedAnswerIndex {
                    answerView.deselect()
                }
            }
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
