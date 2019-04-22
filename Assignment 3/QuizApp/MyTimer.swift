//
//  MyTimer.swift
//  QuizApp
//
//  Created by Saurabh Jaiswal on 1/29/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import Foundation
protocol MyTimerDelegate {
    func timeChanged (time: Int)
    func timesUp ()
}
class MyTimer {
    var initialTime: Int
    var currentTime: Int
    
    var running: Bool
    var delegate: MyTimerDelegate?
    init (initialTime: Int) {
        self.initialTime = initialTime
        self.currentTime = initialTime
        self.running = false
}

    func start () {
        running = true
    }
    func stop () {
        running = false
    }
    func reset () {
        currentTime = initialTime
        delegate?.timeChanged(time: currentTime)
    }
    func decrement () {
        if running {
            currentTime -= 1
            delegate?.timeChanged(time: currentTime)
            if currentTime == 0 {
                running = false
                delegate?.timesUp()
                
            }
            
        }
    }
}
