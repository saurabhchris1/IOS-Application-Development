//
//  AddQuestionViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 2/5/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var promptLabel: UITextField!
    
    @IBOutlet weak var answerOneTextField: UITextField!
    @IBOutlet weak var answerTwoTextField: UITextField!
    @IBOutlet weak var answerThreeTextField: UITextField!
    @IBOutlet weak var answerFourTextField: UITextField!
    @IBOutlet weak var answerFiveTextField: UITextField!
    
    @IBAction func button12345Tapped(_ sender: UISegmentedControl) {
        
        newCorrectAnswer = sender.selectedSegmentIndex
        
        
    }
    
    
    
    var addQuestionLabelVar: String?
    
    var newPromptLabel: String?
    var newAnswers: [String] = []
    var newCorrectAnswer: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        promptLabel.delegate = self
        answerOneTextField.delegate = self
        answerTwoTextField.delegate = self
        answerThreeTextField.delegate = self
        answerFourTextField.delegate = self
        answerFiveTextField.delegate = self
    

        // Do any additional setup after loading the view.
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationItem.title = addQuestionLabelVar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newAnswers = []
        
        newPromptLabel = promptLabel.text
        
        var answer1 = answerOneTextField.text
        var answer2 = answerTwoTextField.text
        var answer3 = answerThreeTextField.text
        var answer4 = answerFourTextField.text
        var answer5 = answerFiveTextField.text
        
       
        if answer1 != ""{
            newAnswers.append(answer1!)
        }
        if answer2 != ""{
            newAnswers.append(answer2!)
        }
        if answer3 != ""{
            newAnswers.append(answer3!)
        }
        if answer4 != ""{
            newAnswers.append(answer4!)
        }
        
        if answer5 != ""{
            newAnswers.append(answer5!)
        }
        

        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    @objc func cancelTapped() {
        
        performSegue(withIdentifier: "mainViewFunc", sender: nil)
    }
    
    @objc func saveTapped() {
        
        performSegue(withIdentifier: "mainViewFuncAlternet", sender: nil)
        
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
