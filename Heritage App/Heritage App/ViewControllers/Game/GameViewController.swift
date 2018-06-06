//
//  GameViewController.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class GameViewController: ReportViewController {
    
    var questions: [Question]!
    var gameType: CategoryButtonType!
    
    @IBOutlet weak var countOfAttemptsLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var countOfRightAnswersLabel: UILabel!
    
    private var player : AVAudioPlayer?
    
    private var countOfAttempts: Int = 0
    private var seconds: Double = 30.0
    private var countOfRightAnswers: Int = 0
    private var timer: Timer!
    
    
    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var labelImageViewTopConstraint: NSLayoutConstraint!
    
    //container view
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timerContainerView: UIView!
    
    //images array
    @IBOutlet var imagesArray: [UIImageView]!
    
    
    var collectionViewDataSource: [Question]!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.alpha = 0.0
        self.timerContainerView.alpha = 0.0
        
        setupControllerProps()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.75, delay: 0.0, options: .curveEaseInOut, animations: {  [weak self] in
            self?.labelImageView.alpha = 1
        }) { (flag) in
            self.labelImageViewTopConstraint.constant = 97
            UIView.animate(withDuration: 0.75, delay: 1.0, options: .curveEaseInOut, animations: { [weak self] in
                self?.labelImageView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                self?.view.layoutIfNeeded()
                }, completion: { (flag) in
                    UIView.animate(withDuration: 0.75, delay: 0.75, options: .curveEaseInOut, animations: { [weak self] in
                        self?.containerView.alpha = 1.0
                        self?.timerContainerView.alpha = 1.0
                        }, completion: { (flag) in
                            self.beginTimerUpdates()
                    })
            })
        }
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
    }
    
    private func beginTimerUpdates() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        self.seconds -= 0.1
        self.secondsLabel.text = "\(Int(self.seconds))"
        
        if self.seconds <= 0 {
            self.loseAction()
            timer.invalidate()
        }
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let selectedView: UIImageView = (sender.view as? UIImageView)!
        let indexOfOnject: Int = imagesArray.index(of: selectedView)!
        
        let question: Question = questions[indexOfOnject]
        checkQuestion(question: question, imageView: selectedView)
    }
    
    private func checkQuestion(question: Question, imageView: UIImageView) {
        let answerView: UIView = createAnswerView(withTrueType: question.isRightAnswer?.intValue == 1 ? true : false)
        answerView.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            answerView.alpha = 1.0
        }
        imageView.addSubview(answerView)
        answerView.translatesAutoresizingMaskIntoConstraints = false
        answerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        answerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        answerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        answerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        imageView.removeGestureRecognizer((imageView.gestureRecognizers?.first)!)
        
        //counting
        if question.isRightAnswer?.intValue == 1 {
            countOfRightAnswers += 1
            countOfRightAnswersLabel.text = "\(countOfRightAnswers)"
            
            self.playCorrectAnswerSound()
        } else {
            self.playWrongAnswerSound()
        }
        
        countOfAttempts += 1
        countOfAttemptsLabel.text = "\(countOfAttempts)/5"
        
        //premature lose
        if (countOfAttempts == 3 && countOfRightAnswers == 0) || (countOfAttempts == 4 && countOfRightAnswers == 1) {
            loseAction()
            timer.invalidate()
            return
        }
        
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
    
    private func playCorrectAnswerSound() {
        let url = Bundle.main.url(forResource:"win_sound", withExtension:"wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    private func playWrongAnswerSound() {
        let url = Bundle.main.url(forResource:"wrong", withExtension:"wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    private func winAction() {
        print("------- W I N -------")
        DispatchQueue.main.async { [weak self] in
            let vc: WinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: WinViewController.self)) as! WinViewController
            vc.report = self!.report
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loseAction() {
        print("------- L O S E -------")
        DispatchQueue.main.async { [weak self] in
            let vc: LoseViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: LoseViewController.self)) as! LoseViewController
            vc.report = self!.report
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

