//
//  ViewController.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 1/13/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currectAnswer = 1

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var resultLabel: UILabel!
   


    @IBAction func didTapButton(_ sender: UIButton) {
        //buttons in stackView
        for button in self.stackView.subviews as [UIView] {
            if button is UIButton {
                let btn = button as! UIButton
                //if the button tag is same as sender tag then we can
                //make the color red else it will be orignal color
                if button.tag == sender.tag {
                    btn.setTitleColor(UIColor.red, for: .normal)
                    
                    //The correct answer is 3rd option so we can use if to compare
                    // tag of button if it is 3 then the answer is correct and we
                    // can change the result label as correct otherwise incorrect
                    if button.tag == 3 {
                        resultLabel.text = "Correct"
                        resultLabel.isHidden = false
                        resultLabel.textColor = UIColor.green
                        
                    }
                    else{
                        resultLabel.text = "Incorrect"
                        resultLabel.textColor = UIColor.red
                        resultLabel.isHidden = false
                        
                    }
                } else {
                     btn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), for: .normal)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        resultLabel.isHidden = true
        
    }


}

