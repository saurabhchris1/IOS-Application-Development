//
//  AddQuestionViewController.swift
//  QuizApp
//
//  Created by Larry Holder on 1/30/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit
import CoreData

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    
    var quizQuestionNumber: Int = 0
//    var quizQuestion: Question?

    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var promptTextField: UITextField!
    
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var answer5TextField: UITextField!
    
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.appDelegate = UIApplication.shared.delegate as? AppDelegate
    self.managedObjectContext = appDelegate.persistentContainer.viewContext
    

        // Do any additional setup after loading the view.
        promptTextField.delegate = self
        answer1TextField.delegate = self
        answer2TextField.delegate = self
        answer3TextField.delegate = self
        answer4TextField.delegate = self
        answer5TextField.delegate = self
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.title = "Add Question \(quizQuestionNumber)"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
    
        
    }
    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        print("saveTapped")
        
        var count = 0
        let questionEnt = NSEntityDescription.insertNewObject(forEntityName:"QuestionEntity", into: self.managedObjectContext)
        
        questionEnt.setValue(promptTextField.text, forKey: "prompt")
        
        
        if answer1TextField.text != "" {
            questionEnt.setValue(answer1TextField.text!, forKey: "answer1")
            count = 1
        }
        if answer2TextField.text != "" {
            questionEnt.setValue(answer2TextField.text!, forKey: "answer2")
            count = 2
        }
        if answer3TextField.text != "" {
            questionEnt.setValue(answer3TextField.text!, forKey: "answer3")
            count = 3
        }
        if answer4TextField.text != "" {
            questionEnt.setValue(answer4TextField.text!, forKey: "answer4")
            count = 4
        }
        if answer5TextField.text != "" {
            questionEnt.setValue(answer5TextField.text!, forKey: "answer5")
            count = 5
        }
        
        questionEnt.setValue( correctAnswerSegmentedControl.selectedSegmentIndex, forKey: "correctAnswerIndex")
        
        questionEnt.setValue(count, forKey: "numAnswers")
        

        
        self.appDelegate.saveContext() // In AppDelegate.swift
        
//        quizQuestion = question
        performSegue(withIdentifier: "unwindToQuizView", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
   

}
