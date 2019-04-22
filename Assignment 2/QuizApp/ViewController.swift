//
//  ViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 1/13/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

   
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var questionPromptLabel: UILabel!
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBOutlet weak var optionA: UIButton!
    
    @IBOutlet weak var optionB: UIButton!
    
    @IBOutlet weak var optionC: UIButton!
    
    @IBOutlet weak var optionD: UIButton!
    
    @IBOutlet weak var optionE: UIButton!
    
    
    
    
    let question1 = Question()
    let question2 = Question()
    let question3 = Question()
    
    var questionNumber: Int = 0
    var selectedAnswer: Int = 0
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        questionBank()
        
        
    }
    
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        for button in self.stackView.subviews as [UIView]{
            
            if button is UIButton{
                
                let btn = button as! UIButton
                
                if button.tag == sender.tag{
                    
                    btn.setTitleColor(UIColor.red, for: .normal)
                
                    if button.tag == (selectedAnswer + 1) {
                       
                        resultLabel.text = "Correct"
                        resultLabel.isHidden = false
                        resultLabel.textColor = UIColor.green
                        
                    }
                    else if ((button.tag == 0) && ((selectedAnswer + 1) == 5)) {
                       
                        resultLabel.text = "Correct"
                        resultLabel.isHidden = false
                        resultLabel.textColor = UIColor.green
                        
                    }
                    else{
                  
                        resultLabel.text = "Incorrect"
                        resultLabel.textColor = UIColor.red
                        resultLabel.isHidden = false
                        
                    }
                }
                 
                else{
                    
                    btn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
                }
                
            }
        }
    }
    
    
    func questionBank(){
        
        if questionNumber == 3{
            questionNumber = 0
        }
        
        
        question1.question = "Where is Washington State University Located?"
        question1.possibleAnswers = ["Washington D.C","Washington State"]
        question1.correctAnswer = 1
        
        question2.question = "Alexa's father is John, then John is the ______ of Alexa's father (Answer the blank)"
        question2.possibleAnswers = ["Son", "Uncle", "Father", "Grandfather", "None of the above"]
        question2.correctAnswer = 4
        
        question3.question = "The teacher bought a sticker for each of her students. There are 30 students in her class. If she gave 15 away, how many does she have left?"
        question3.possibleAnswers = ["10", "15", "16", "None of the above"]
        question3.correctAnswer = 1
        
        let quizArray = [question1, question2, question3]
        
     
        questionNumberLabel.text = "Question " +  String(questionNumber + 1)
        
        questionPromptLabel.text = quizArray[questionNumber].question
        
        
        
     
            
        let sizeOptions =  (self.stackView.subviews as [UIView]).count - quizArray[questionNumber].possibleAnswers.count
        
     
        
        switch sizeOptions {
        
        case 1 :
            
            optionA.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionB.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionC.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionD.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionE.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            resultLabel.isHidden = true
          
            optionC.isHidden = false
            optionD.isHidden = false
            optionA.setTitle("a. " + quizArray[questionNumber].possibleAnswers[0], for: .normal)
            optionB.setTitle("b. " + quizArray[questionNumber].possibleAnswers[1], for: .normal)
            optionC.setTitle("c. " + quizArray[questionNumber].possibleAnswers[2], for: .normal)
            optionD.setTitle("d. " + quizArray[questionNumber].possibleAnswers[3], for: .normal)
            optionE.isHidden = true
            selectedAnswer = quizArray[questionNumber].correctAnswer
            
        case 2 :
            optionA.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionB.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionC.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionD.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionE.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            resultLabel.isHidden = true
            
            optionC.isHidden = false
            optionA.setTitle("a. " + quizArray[questionNumber].possibleAnswers[0], for: .normal)
            optionB.setTitle("b. " + quizArray[questionNumber].possibleAnswers[1], for: .normal)
            optionC.setTitle("c. " + quizArray[questionNumber].possibleAnswers[2], for: .normal)
            optionD.isHidden = true
            optionE.isHidden = true
            selectedAnswer = quizArray[questionNumber].correctAnswer
            
        case 3 :
            
            optionA.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionB.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionC.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionD.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionE.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            resultLabel.isHidden = true
            
            optionA.setTitle("a. " + quizArray[questionNumber].possibleAnswers[0], for: .normal)
            optionB.setTitle("b. " + quizArray[questionNumber].possibleAnswers[1], for: .normal)
            optionC.isHidden = true
            optionD.isHidden = true
            optionE.isHidden = true
            selectedAnswer = quizArray[questionNumber].correctAnswer
    
        
        
   
        default:
            optionA.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionB.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionC.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionD.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            optionE.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
            resultLabel.isHidden = true
            
          
            optionC.isHidden = false
            optionD.isHidden = false
            optionE.isHidden = false
            optionA.setTitle("a. " + quizArray[questionNumber].possibleAnswers[0], for: .normal)
            optionB.setTitle("b. " + quizArray[questionNumber].possibleAnswers[1], for: .normal)
            optionC.setTitle("c. " + quizArray[questionNumber].possibleAnswers[2], for: .normal)
            optionD.setTitle("d. " + quizArray[questionNumber].possibleAnswers[3], for: .normal)
            optionE.setTitle("e. " + quizArray[questionNumber].possibleAnswers[4], for: .normal)
            selectedAnswer = quizArray[questionNumber].correctAnswer
        }
        
        questionNumber += 1
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       questionBank()
        
    }


}

