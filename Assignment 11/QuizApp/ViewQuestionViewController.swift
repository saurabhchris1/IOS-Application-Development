//
//  ViewQuestionViewController.swift
//  QuizApp
//
//  Created by Larry Holder on 2/5/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit

class ViewQuestionViewController: UIViewController {
    
    var question: Question!
    var answerLabels: [UILabel]!

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer3Label: UILabel!
    @IBOutlet weak var answer4Label: UILabel!
    @IBOutlet weak var answer5Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        answerLabels = [answer1Label, answer2Label, answer3Label, answer4Label, answer5Label]
        promptLabel.text = question.prompt
        hideLabels()
        for index in 0..<question.answers.count {
            if !question.answers[index].isEmpty {
                answerLabels[index].text = question.answers[index]
                answerLabels[index].isHidden = false
            }
        }
        answerLabels[question.correctAnswerIndex].textColor = UIColor.red
    }
    
    func hideLabels() {
        for label in answerLabels {
            label.isHidden = true
        }
    }

}
