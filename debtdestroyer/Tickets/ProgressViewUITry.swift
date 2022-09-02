//
//  ProgressViewUITry.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 22/08/22.
//

import UIKit

class ProgressViewUITry: UIView {
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    var ticketProgressBar = UIProgressView()
    var stepImgView10 = UIImageView()
    var stepImgView20 = UIImageView()
    var stepImgView30 = UIImageView()
    var stepImgView40 = UIImageView()
    var stepImgView0 = UIImageView()
    var stepImgView50 = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        setProgressBar()
        setStackForProgress()
        setupStepImgView()
        let p = ticketProgressBar.frame.width / 5
//        print("p========",p)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProgressBar() {
//        var arrPointsRange = [0, 10, 20, 30, 40, 50]
//        var currenPoint = 18
//        let totalPoints = 50
        ticketProgressBar.progressImage = UIImage.init(named: "backgroundGrad")
        let dimension: CGFloat = 30
        ticketProgressBar.layer.cornerRadius = dimension / 2
        ticketProgressBar.clipsToBounds = true
        ticketProgressBar.progress = 18
        ticketProgressBar.trackTintColor = .progrssBarBackgroundColor
        addSubview(ticketProgressBar)
        ticketProgressBar.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(200)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(dimension)
        }
    }
    
    private func setStackForProgress() {
        stackView.backgroundColor = .blue
        stackView.layer.opacity = 0.2
        addSubview(stackView)
        
        stackView.snp.makeConstraints{ make in
            make.leading.equalTo(ticketProgressBar.snp.leading)
            make.trailing.equalTo(ticketProgressBar.snp.trailing)
            
            make.top.equalToSuperview().offset(150)
            //            make.centerY.equalTo(ticketProgressBar.snp.centerY)
            make.height.equalTo(90)
        }
    }
    
    private func setupStepImgView(){
        
        
        //        stepImgView0.image = UIImage.init(named: "stepC")
        //        stepImgView0.contentMode = .scaleAspectFit
        //        stepImgView0.backgroundColor = .clear
        //
        //        stackView.addArrangedSubview(stepImgView0)
        //
        //        stepImgView0.snp.makeConstraints{ make in
        //            //                        make.top.equalToSuperview()
        //            make.centerY.equalTo(ticketProgressBar)
        //            make.height.equalTo(90).priority(.high)
        //            make.width.equalTo(35).priority(.high)
        //        }
        
        stepImgView10.image = UIImage.init(named: "stepC")
        stepImgView10.contentMode = .scaleAspectFit
        stepImgView10.backgroundColor = .red
        
        stackView.addArrangedSubview(stepImgView10)
        
        stepImgView10.snp.makeConstraints{ make in
            
            make.height.equalTo(90).priority(.high)
            make.width.equalTo(35).priority(.high)
        }
        
        stepImgView20.image = UIImage.init(named: "stepC")
        stepImgView20.contentMode = .scaleAspectFit
        stepImgView20.backgroundColor = .clear
        
        stackView.addArrangedSubview(stepImgView20)
        
        stepImgView20.snp.makeConstraints{ make in
            //            make.top.equalToSuperview()
            make.centerY.equalTo(ticketProgressBar)
            make.height.equalTo(90).priority(.high)
            make.width.equalTo(35).priority(.high)
        }
        
        stepImgView30.image = UIImage.init(named: "stepC")
        stepImgView30.contentMode = .scaleAspectFit
        stepImgView30.backgroundColor = .clear
        
        stackView.addArrangedSubview(stepImgView30)
        
        stepImgView30.snp.makeConstraints{ make in
            //            make.top.equalToSuperview()
            make.centerY.equalTo(ticketProgressBar)
            make.height.equalTo(90).priority(.high)
            make.width.equalTo(35).priority(.high)
        }
        
        stepImgView40.image = UIImage.init(named: "stepC")
        stepImgView40.contentMode = .scaleAspectFit
        stepImgView40.backgroundColor = .clear
        
        stackView.addArrangedSubview(stepImgView40)
        
        stepImgView40.snp.makeConstraints{ make in
            //            make.top.equalToSuperview()
            make.centerY.equalTo(ticketProgressBar)
            make.height.equalTo(90).priority(.high)
            make.width.equalTo(35).priority(.high)
        }
        
        //        stepImgView50.image = UIImage.init(named: "stepC")
        //        stepImgView50.contentMode = .scaleAspectFit
        //        stepImgView50.backgroundColor = .clear
        //
        //        stackView.addArrangedSubview(stepImgView50)
        //
        //        stepImgView50.snp.makeConstraints{ make in
        //            //            make.top.equalToSuperview()
        //            make.centerY.equalTo(ticketProgressBar)
        //            make.height.equalTo(90).priority(.high)
        //            make.width.equalTo(35).priority(.high)
        //        }
    }
    
    
}
