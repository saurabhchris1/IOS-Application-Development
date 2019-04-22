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
    
    @IBAction func newQuizTapped(_ sender: UIButton) {
        getNews()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttons = [button1, button2, button3, button4, button5]

        getNews()
     

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
    
    
    func getNews() {
        let url = URL(string:"https://opentdb.com/api.php?amount=5")
        
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleNewsResponse)
                dataTask.resume()
    
    }
    
    func handleNewsResponse (data: Data?, response: URLResponse?, error: Error?) {
        print("completion handler ")
        var question: Question!
        quiz = []
        
        if let err = error {
            print("error: \(err.localizedDescription)")
            
        } else {
            
            let jsonObj = try! JSONSerialization.jsonObject(with: data!)
            let jsonDict1 = jsonObj as! [String: AnyObject]
            print(jsonDict1)
            
            let quizQuestionjsonArray = jsonDict1["results"] as! [AnyObject]
            
            
            DispatchQueue.main.async {
                for i in 0...4 {
                    let jsonDict2 = quizQuestionjsonArray[i] as! [String: AnyObject]
                    var questionStr = jsonDict2["question"] as! String
                   questionStr = questionStr.replacingOccurrences(of: "&#039;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                     questionStr = questionStr.replacingOccurrences(of: "&quot;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                    
                    var correctAnswerStr = jsonDict2["correct_answer"] as! String
                    correctAnswerStr = correctAnswerStr.replacingOccurrences(of: "&#039;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                    correctAnswerStr = correctAnswerStr.replacingOccurrences(of: "&quot;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                    
               
                    var incorrectAnswers = jsonDict2["incorrect_answers"] as! NSArray
 
                    
                    
                    
                    question = Question()
                    question.prompt = questionStr
                    let lastAnswerIndex = 0
                    for (_,name) in incorrectAnswers.enumerated(){
                        
                        var incAnsName = name as! String
                        incAnsName = incAnsName.replacingOccurrences(of: "&#039;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                        incAnsName = incAnsName.replacingOccurrences(of: "&quot;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                        
                        question.answers.append(incAnsName)
                        
                    }
                    question.answers.append(correctAnswerStr)
                    
                    
                    
                    question.answers.shuffle()
                    let shuffledAnswer = question.answers.index(of: correctAnswerStr)
                    
                    
                    question.correctAnswerIndex = shuffledAnswer!
                    self.quiz.append(question)
                }
                self.quizQuestionIndex = 0
                self.displayQuizQuestion(index: self.quizQuestionIndex)
            }
           
            }
        
        }
    
}



