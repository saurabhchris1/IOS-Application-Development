//
//  Questions.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 1/19/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import Foundation

class Question{
    
    var question:String
    var possibleAnswers =  [String]()
    var correctAnswer:Int = 1
    
    
    init() {
        
        self.question = ""
        self.possibleAnswers = [""]
        self.correctAnswer = 1
        
    }
    
}
