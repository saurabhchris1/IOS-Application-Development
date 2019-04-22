//
//  QuizTableViewController.swift
//  QuizApp
//
//  Created by Larry Holder on 2/5/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit
import CoreData

class QuizTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var quiz: [Question] = []
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.managedObjectContext = appDelegate.persistentContainer.viewContext

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        initializeQuizFromDatabase()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quiz.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        let row = indexPath.row
        let question = quiz[row]
        cell.textLabel?.text = question.prompt
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let quizQstn = quiz[indexPath.row]
            let questnObjectID = quizQstn.questionObjectID!
            
            let questionsFromCoreDatabase = managedObjectContext.object(with: questnObjectID)
            
    
           
            self.managedObjectContext.delete(questionsFromCoreDatabase)

            self.appDelegate.saveContext()
            quiz.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "toViewQuestion", sender: nil)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddQuestion" {
            let addQuestionVC = segue.destination as! AddQuestionViewController
            addQuestionVC.quizQuestionNumber = quiz.count + 1
        }
        if segue.identifier == "toViewQuestion" {
            let viewQuestionVC = segue.destination as! ViewQuestionViewController
            viewQuestionVC.question = quiz[self.selectedRow]
        }
    }
    
    @IBAction func unwindToQuizView(segue: UIStoryboardSegue) {

        quiz = []
        initializeQuizFromDatabase()
        self.tableView.reloadData()
    }


    
    func initializeQuizFromDatabase()  {
        var question: Question!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuestionEntity")
        
        var questionEntityData: [NSManagedObject]!
        
        do {
            questionEntityData = try self.managedObjectContext.fetch(fetchRequest)
            
        }
        
        catch {
                print("questionEntityData error: \(error)")
        }
        
        for data in questionEntityData {
            

            question = Question()
            question.prompt = (data.value(forKey: "prompt") as! String)
            let numberOfOptions = data.value(forKey: "numAnswers") as! Int
            
            for i in 1...Int(numberOfOptions) {
                
                let strAnswer = "answer" + String(i)
                question.answers.append(data.value(forKey: String(strAnswer)) as! String)
            }
            
            
            
            question.correctAnswerIndex = data.value(forKey: "correctAnswerIndex") as! Int
            question.questionObjectID = data.objectID
            quiz.append(question)
            
            
        }
    }
}
