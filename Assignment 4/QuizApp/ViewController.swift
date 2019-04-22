//
//  ViewController.swift
//  QuizApp
//
//  Created by Larry Holder on 1/8/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var quiz: [Question] = []
    var quizQuestionIndex = 0
    var buttons: [UIButton] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        handleTap(1, sender)
    }
    @IBAction func button2Tapped(_ sender: UIButton) {
        handleTap(2, sender)
    }
    @IBAction func button3Tapped(_ sender: UIButton) {
        handleTap(3, sender)
    }
    @IBAction func button4Tapped(_ sender: UIButton) {
        handleTap(4, sender)
    }
    @IBAction func button5Tapped(_ sender: UIButton) {
        handleTap(5, sender)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        quizQuestionIndex += 1
        if quizQuestionIndex == quiz.count {
            quizQuestionIndex = 0
        }
        displayQuizQuestion(index: quizQuestionIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttons = [button1, button2, button3, button4, button5]
        initializeQuiz()
        displayQuizQuestion(index: quizQuestionIndex)
    }
    
    func handleTap(_ answer: Int, _ button: UIButton) {
        resetButtonColors()
        button.setTitleColor(UIColor.red, for: .normal)
        if answer == (quiz[quizQuestionIndex].correctAnswerIndex + 1) {
            resultLabel.text = "Correct!"
        } else {
            resultLabel.text = "Incorrect!"
        }
        resultLabel.isHidden = false
    }

    func resetButtonColors() {
        for button in buttons {
            button.setTitleColor(self.view.tintColor, for: .normal)
        }
    }
    
    func hideButtons() {
        for button in buttons {
            button.isHidden = true
        }
    }
    
    func displayQuizQuestion(index: Int) {
        let question = quiz[index]
        questionLabel.text = "Question \(index+1):"
        promptLabel.text = question.prompt
        hideButtons()
        resetButtonColors()
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
    }
    
    func initializeQuiz() {
        var question: Question!
        
        // Question 1
        question = Question()
        question.prompt = "Who is the CEO of Apple?"
        question.answers.append("Bill Gates")
        question.answers.append("Steve Jobs")
        question.answers.append("Tim Cook")
        question.answers.append("Larry Holder")
        question.answers.append("None of the above")
        question.correctAnswerIndex = 2
        quiz.append(question)
        
        // Question 2
        question = Question()
        question.prompt = "The earth is which planet from the sun?. This will be a number between 1 and 9 (or 8 if you exclude Pluto). I sure miss Pluto."
        question.answers.append("1")
        question.answers.append("2")
        question.answers.append("3")
        question.answers.append("4")
        question.answers.append("5")
        question.correctAnswerIndex = 2
        quiz.append(question)
        
        // Question 3
        question = Question()
        question.prompt = "2 + 2 = 4?"
        question.answers.append("True")
        question.answers.append("False")
        question.correctAnswerIndex = 0
        quiz.append(question)
    }
    
    func addNewQuestion(newPrompt: String!, newAnswers: [String]!, newCorrectAnswer: Int!) {
        var question: Question!
        
        question = Question()
        
        question.prompt = newPrompt
        for answer in newAnswers{
            question.answers.append(answer)
        }
        
        question.correctAnswerIndex = newCorrectAnswer
        
        quiz.append(question)
        
        
        
    }
    
    @IBAction func unwindToMainViewFunc(segue: UIStoryboardSegue){
        print("Cancel")
        
    }
    
    @IBAction func unwindToMainViewFuncAlternet(segue: UIStoryboardSegue){
        let addQuestionVCSave = segue.source as! AddQuestionViewController
        var newPrompt = addQuestionVCSave.newPromptLabel
        var newAnswers = addQuestionVCSave.newAnswers
        var newCorrectAnswer = addQuestionVCSave.newCorrectAnswer
        
        print(newAnswers)
        addNewQuestion(newPrompt: newPrompt!, newAnswers: newAnswers, newCorrectAnswer: newCorrectAnswer!)

     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainViewToAddQuestionView"{
            
            let addQuestionVC = segue.destination as! AddQuestionViewController
            addQuestionVC.addQuestionLabelVar = "Add Question " + String(quiz.count + 1)
        }
    }

}

