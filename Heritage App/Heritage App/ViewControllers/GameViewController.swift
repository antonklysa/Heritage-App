//
//  GameViewController.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: BaseViewController {
    
    var questions: [Question]!
    var gameType: CategoryButtonType!
    
    @IBOutlet weak var countOfAttemptsLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var countOfRightAnswersLabel: UILabel!
    
    private var countOfAttempts: Int = 0
    private var seconds: Int = 30
    private var countOfRightAnswers: Int = 0
    private var timer: Timer!
    
    
    @IBOutlet weak var labelImageView: UIImageView!
    
    //container view
    @IBOutlet weak var containerView: UIView!
    
    //images array
    @IBOutlet var imagesArray: [UIImageView]!
    
    
    var collectionViewDataSource: [Question]!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllerProps()
    }
    
    
    //MARK: actions
    
    private func setupControllerProps() {
        
        //setup top question label
        if gameType == .typeClothes {
            labelImageView.image = UIImage(named: "clothes_title_image")
        } else if gameType == .typeFood {
            labelImageView.image = UIImage(named: "food_title_image")
        } else {
            labelImageView.image = UIImage(named: "music_title_image")
        }
        
        containerView.layer.cornerRadius = 5
        
        for imageView in imagesArray {
            imageView.image = UIImage(named: questions[imagesArray.index(of: imageView)!].imageNameString!)
            imageView.contentMode = .scaleToFill
            imageView.isUserInteractionEnabled = true
            
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            imageView.addGestureRecognizer(tapGesture)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            self?.seconds -= 1
            self?.secondsLabel.text = "\((self?.seconds)!)"
            
            if self?.seconds == 0 {
                self?.loseAction()
                timer.invalidate()
            }
        })
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let selectedView: UIImageView = (sender.view as? UIImageView)!
        let indexOfOnject: Int = imagesArray.index(of: selectedView)!
        
        let question: Question = questions[indexOfOnject]
        checkQuestion(question: question, imageView: selectedView)
    }
    
    private func checkQuestion(question: Question, imageView: UIImageView) {
        let answerView: UIView = createAnswerView(withTrueType: question.isRightAnswer?.intValue == 0 ? true : false)
        imageView.addSubview(answerView)
        answerView.translatesAutoresizingMaskIntoConstraints = false
        answerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        answerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        answerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        answerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        imageView.removeGestureRecognizer((imageView.gestureRecognizers?.first)!)
        
        //counting
        if question.isRightAnswer?.intValue == 0 {
            countOfRightAnswers += 1
            countOfRightAnswersLabel.text = "\(countOfRightAnswers)"
        }
        
        countOfAttempts += 1
        countOfAttemptsLabel.text = "\(countOfAttempts)/5"
        
        if countOfRightAnswers == 3 {
            winAction()
            timer.invalidate()
            return
        }
        if countOfAttempts == 5 {
            loseAction()
            timer.invalidate()
        }
    }
    
    private func createAnswerView(withTrueType: Bool) -> UIView {
        
        let answerView: UIView = UIView(frame: .zero)
        let checkImage: UIImageView = UIImageView.init(frame: .zero)
        checkImage.contentMode = .scaleToFill
        
        answerView.addSubview(checkImage)
        checkImage.translatesAutoresizingMaskIntoConstraints = false
        checkImage.centerXAnchor.constraint(equalTo: answerView.centerXAnchor).isActive = true
        checkImage.centerYAnchor.constraint(equalTo: answerView.centerYAnchor).isActive = true
        checkImage.image = UIImage(named: withTrueType == true ? "true_icon" : "false_icon")
        
        answerView.backgroundColor = (withTrueType == true ? UIColor(red: 135.0/255.0, green: 188.0/255.0, blue: 78.0/255.0, alpha: 0.8) : UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 54.0/255.0, alpha: 0.8))
        
        return answerView
    }
    
    private func winAction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        print("------- W I N -------")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            
            self?.navigationController?.popViewController(animated: true)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    private func loseAction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        print("------- L O S E -------")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

