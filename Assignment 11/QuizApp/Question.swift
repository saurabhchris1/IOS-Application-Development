//
//  Question.swift
//  QuizApp
//
//  Created by Larry Holder on 1/15/19.
//  Copyright © 2019 Washington State University. All rights reserved.
//

import Foundation
import CoreData

class Question {
    var prompt: String?
    var answers: [String] = []
    var correctAnswerIndex: Int = 0
    var questionObjectID: NSManagedObjectID?
    
}
