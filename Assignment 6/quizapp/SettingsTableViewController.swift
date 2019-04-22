//
//  SettingsTableViewController.swift
//  quizapp
//
//  Created by Saurabh Jaiswal on 2/18/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var shuffleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shuffleSwitch: UISwitch!
    
 
    
    @IBOutlet weak var timeLimitStepper: UIStepper!
 
    @IBOutlet weak var autoDownloadLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func shuffleChange(_ sender: UISwitch) {
        
        if sender.isOn {
            shuffleLabel.text = "Shuffle: Yes"
            UserDefaults.standard.set(true, forKey: "shuffleItems")
        } else{
            shuffleLabel.text = "Shuffle: No"
            UserDefaults.standard.set(false, forKey: "shuffleItems")
            
        }
    }

    @IBAction func timeLimitChange(_ sender: UIStepper) {
        let timeLimitValue = Int(sender.value)
        timeLabel.text = "Time Limit: \(timeLimitValue) sec"
        UserDefaults.standard.set(timeLimitValue, forKey: "timeLimit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        resetSettingsView()
        
        
       


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case 0: return 3
        case 1: return 2
        
        default: return 0
        }
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let sectionRow = indexPath.section
        
        if ((row == 0) || (row == 1)) && sectionRow == 1 {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) { if UIApplication.shared.canOpenURL(settingsURL) {
            
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
            
        }
        
        
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaults.standard.set(textField.text, forKey: "userName")
    }
    
    func resetSettingsView() {
        
        self.tableView.tableFooterView = UIView()
        userNameTextField.text = UserDefaults.standard.string(forKey: "userName")
        
        if UserDefaults.standard.bool(forKey: "shuffleItems"){
            
            shuffleLabel.text = "Shuffle: Yes"
            shuffleSwitch.isOn = true
        } else{
            shuffleLabel.text = "Shuffle: No"
            shuffleSwitch.isOn = false
            
        }
        
        let timeLimit = UserDefaults.standard.integer(forKey: "timeLimit")
        
        timeLabel.text = "Time Limit: \(timeLimit) sec"
        timeLimitStepper.value = Double(timeLimit)
        
        
        
        if UserDefaults.standard.bool(forKey: "autodownload"){
            
            autoDownloadLabel.text = "Auto Download: On"
            
        } else{
            autoDownloadLabel.text = "Auto Download: Off"
            
        }
        
        let categoryLabelTextValue: String = UserDefaults.standard.string(forKey: "category")!
        
        categoryLabel.text =  "Category: \(categoryLabelTextValue)"
        
       
        
       
    }

}
