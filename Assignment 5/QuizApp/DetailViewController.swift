//
//  DetailViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 2/12/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var question: Question?

    @IBOutlet weak var promptQuestion: UILabel!
    
    @IBOutlet weak var answerA: UILabel!
    @IBOutlet weak var answerB: UILabel!
    @IBOutlet weak var answerC: UILabel!
    @IBOutlet weak var answerD: UILabel!
    @IBOutlet weak var answerE: UILabel!
    
    
    
    
    func hideAnswerLabels() {
        
        answerA.isHidden = true
        answerB.isHidden = true
        answerC.isHidden = true
        answerD.isHidden = true
        answerE.isHidden = true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         hideAnswerLabels()
        
        
            if let q = question{
                promptQuestion.text = q.prompt
               var correctAnswer = q.correctAnswerIndex
            
            if q.answers.count > 0 {
                answerA.text = q.answers[0]
                answerA.isHidden = false
                if correctAnswer == 0{
                    answerA.textColor = UIColor.red
                }
            }
            if q.answers.count > 1 {
                answerB.text = q.answers[1]
                answerB.isHidden = false
                if correctAnswer == 1{
                    answerB.textColor = UIColor.red
                }
               
            }
            if q.answers.count > 2 {
                answerC.text = q.answers[2]
                answerC.isHidden = false
                if correctAnswer == 2{
                    answerC.textColor = UIColor.red
                }
             
            }
            if q.answers.count > 3 {
                answerD.text = q.answers[3]
                answerD.isHidden = false
                if correctAnswer == 3{
                    answerD.textColor = UIColor.red
                }
          
            }
            if q.answers.count > 4 {
                answerE.text = q.answers[4]
                answerE.isHidden = false
                if correctAnswer == 4{
                    answerE.textColor = UIColor.red
                }
                
            }
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
