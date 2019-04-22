//
//  TableViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 2/12/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var quiz: [Question] = []
    var quizQuestionIndex = 0
    
    
    
    @IBAction func unwindToMainViewFunc(segue: UIStoryboardSegue){
        print("Cancel")
        
    }
    
    @IBAction func unwindToMainViewFuncAlternet(segue: UIStoryboardSegue){
        let addQuestionVCSave = segue.source as! AddQuestionViewController
        var newPrompt = addQuestionVCSave.newPromptLabel
        var newAnswers = addQuestionVCSave.newAnswers
        var newCorrectAnswer = addQuestionVCSave.newCorrectAnswer

        print(newAnswers)
        addNewQuestion(newPrompt: newPrompt!, newAnswers: newAnswers, newCorrectAnswer: newCorrectAnswer)


        print(quiz)
       
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
        
        self.tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        initializeQuiz()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        // Configure the cell...
        let row = indexPath.row
        let question = quiz[row]
       
        cell.textLabel?.text = question.prompt

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let detailQuestionArray = [row,quiz] as [Any]
        
        performSegue(withIdentifier: "fromRowtoDetail", sender: detailQuestionArray)
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
            quiz.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "fromRowtoDetail" {
            
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.detailQuestionViewInView = sender as! [Any]
            

        }
    }
    
    

 

}
