//
//  ViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 1/28/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyTimerDelegate {
    func timesUp() {
       
        internalTimer?.invalidate()
        quizQuestionsIndex += 1
        recordAnswerResultBoolean.append(rememberAnswerResultChoice)
        rememberAnswerResultChoice = 0
    
        if quizQuestionsIndex == quizQuestions.count{
            
            quizQuestionsIndex = 0
            quizQuestions = []
           resultOfQuiz()
            
        }
        else{
            
            displayQuiz(quizQuestionsIndex)
        }
        
        myTimer.reset()
        
        
        
    }
    

    
    var quizQuestions: [Question] = []
    var quizQuestionsIndex: Int = 0
    var buttons: [UIButton] = []
    var recordAnswerResultBoolean: [Int] = []
    var rememberAnswerResultChoice: Int = 0
    var myTimer = MyTimer(initialTime: 5)
    var internalTimer: Timer?
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionPrompt: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var againButton: UIButton!
    
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        handelTap(1, sender)
    }
    
    @IBAction func button2Tapped(_ sender: UIButton) {
        
        handelTap(2, sender)
    }
    
 
    @IBAction func button3Tapped(_ sender: UIButton) {
        
        handelTap(3, sender)
    }
    
    @IBAction func button4Tapped(_ sender: UIButton) {
        
        handelTap(4, sender)
    }
    
    @IBAction func button5Tapped(_ sender: UIButton) {
        
        handelTap(5, sender)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        questionLabel.isHidden = false
        questionPrompt.isHidden = false
        hideButtons()
        stackView.isHidden = false
        timeRemainingLabel.isHidden = false
        againButton.isHidden = true
        recordAnswerResultBoolean = []
        rememberAnswerResultChoice = 0
        
        viewDidLoad()
        
        
    }
    
    func handelTap(_ answer: Int, _ button: UIButton) {
        
        resetButtonColor()
        button.setTitleColor(UIColor.red, for: .normal)
        if answer == quizQuestions[quizQuestionsIndex].correctAnswer{
           resultLabel.text = "Correct"
            rememberAnswerResultChoice = 1
        }
        else{
            resultLabel.text = "Incorrect"
            rememberAnswerResultChoice = 0
        }
        resultLabel.isHidden = false
    }
    
    func resetButtonColor(){
        
        for button in buttons{
            button.setTitleColor(self.view.tintColor, for: .normal)
        }
    }
    
    func hideButtons() {
        for button in buttons{
            button.isHidden = true
        }
    }
    
    func initializeQuiz() {
        var question: Question!
 
        question = Question()
        question.questionPrompt = "Where is Washington State University Located?"
        question.answers.append("Washington D.C")
        question.answers.append("Washington State")
        question.correctAnswer = 2
        quizQuestions.append(question)
        
        question = Question()
        question.questionPrompt = "Alexa's father is John, then John is the ______ of Alexa's father (Answer the blank)"
        question.answers.append("Son")
        question.answers.append("Uncle")
        question.answers.append("Father")
        question.answers.append("Grandfather")
        question.answers.append("None of the above")
        question.correctAnswer = 5
        quizQuestions.append(question)
        
        question = Question()
        question.questionPrompt = "The teacher bought a sticker for each of her students. There are 30 students in her class. If she gave 15 away, how many does she have left?"
        question.answers.append("10")
        question.answers.append("15")
        question.answers.append("16")
        question.answers.append("None of the above")
        question.correctAnswer = 2
        quizQuestions.append(question)
        
    }

    
    func displayQuiz(_ index: Int){
       
        let question = quizQuestions[index]
        questionLabel.text = "Question No. \(index + 1):"
        questionPrompt.text = question.questionPrompt
        hideButtons()
        resetButtonColor()
        if question.answers.count > 0 {
            button1.setTitle("a. \(question.answers[0])", for: .normal)
            button1.isHidden = false
        }
        if question.answers.count > 1 {
            button2.setTitle("b. \(question.answers[1])", for: .normal)
            button2.isHidden = false
        }
        if question.answers.count > 2 {
            button3.setTitle("c. \(question.answers[2])", for: .normal)
            button3.isHidden = false
        }
        if question.answers.count > 3 {
            button4.setTitle("d. \(question.answers[3])", for: .normal)
            button4.isHidden = false
        }
        if question.answers.count > 4 {
            button5.setTitle("e. \(question.answers[4])", for: .normal)
            button5.isHidden = false
        }
        resultLabel.isHidden = true
        
        internalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handelTick)
        myTimer.start()
        
    }
    
    func handelTick(_ sender: Timer) {
       
        self.myTimer.decrement()
    }
    
    func timeChanged(time: Int) {
        timeRemainingLabel.text = "\(time)"
    }
    
    func resultOfQuiz() {
        
        questionLabel.isHidden = true
        questionPrompt.isHidden = true
        hideButtons()
        stackView.isHidden = true
        timeRemainingLabel.isHidden = true
        againButton.isHidden = false
        resultLabel.isHidden = false
        var correctAnswerResults: Int = 0
        
        for answerResult in recordAnswerResultBoolean{
            if answerResult == 1{
                correctAnswerResults += 1
            }
        }
        
        resultLabel.text = "Results \n \(correctAnswerResults) right, \(recordAnswerResultBoolean.count - correctAnswerResults) wrong"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTimer.delegate = self
        buttons = [button1, button2, button3, button4, button5]
        initializeQuiz()
        displayQuiz(quizQuestionsIndex)
    }
    
    


}

