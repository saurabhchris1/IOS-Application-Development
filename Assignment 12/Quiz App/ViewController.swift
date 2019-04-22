//
//  ViewController.swift
//  Quiz App
//
//  Created by Saurabh Jaiswal on 4/17/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit
import SceneKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneKitView: SCNView!
    
     var startStopTextNode: SCNNode!
    var questionNode: SCNNode!
    var nextQuestionNode: SCNNode!
    var quiz: [Question] = []
    var quizQuestionIndex = 0
    var removeNode = 0
    var audioPlayer: AVAudioPlayer!
    let scene = SCNScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        sceneKitView.scene = scene
        sceneKitView.backgroundColor = UIColor.black
        

        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        scene.rootNode.addChildNode(cameraNode)
        // place the camera
        cameraNode.position = SCNVector3(x: 30, y: 10, z: 220)
        cameraNode.camera?.zFar = 800
        cameraNode.camera?.zNear = 0
    
        // allow the user to manipulate the camera
        sceneKitView.allowsCameraControl = true
        
       
        
 
        
        let nextQuestionText = SCNText(string: "Next", extrusionDepth: 0.18)
        nextQuestionText.font = UIFont (name: "Arial", size: 2)
        nextQuestionText.firstMaterial?.diffuse.contents = UIColor.init(red: 0.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        nextQuestionNode = SCNNode(geometry: nextQuestionText)
        let nextQuestionNodeGeometry = nextQuestionNode.geometry as? SCNText
        nextQuestionNodeGeometry?.string = "Next"
        let boundingBoxnextQuestionNode = nextQuestionNode.boundingBox
        let widthnextQuestionNode = abs(boundingBoxnextQuestionNode.max.x - boundingBoxnextQuestionNode.min.x)
        nextQuestionNode.pivot = SCNMatrix4MakeTranslation((widthnextQuestionNode/2.0), 0, 0)
        nextQuestionNode.position.x = 30
        nextQuestionNode.position.y = -3
        nextQuestionNode.position.z = 195
        scene.rootNode.addChildNode(nextQuestionNode)
        
       
        initializeQuiz()
       displayQuizQuestion(index: quizQuestionIndex)
        
        
        let musicURL = Bundle.main.url(forResource: "Star Wars Theme Song By John Williams.mp3", withExtension: nil)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
        } catch {
            print("error accessing music")
        }
        audioPlayer.volume = 0.25
        audioPlayer.numberOfLoops = -1 // loop forever
        audioPlayer.play() // In startGame()
        //audioPlayer.pause()
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
        question.prompt = "The earth is which planet \nfrom the sun?. This will be \na number between 1 and 9 \n(or 8 if you exclude Pluto).\n I sure miss Pluto."
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

    
    func displayQuizQuestion(index: Int) {
        if removeNode == 1 {
            questionNode.removeFromParentNode()
        }
        
        let question = quiz[index]
        let sceneQuestionNo = "Question \(index+1): \n"
        let scenePrompt = question.prompt! + "\n"
        var sceneAnswera = ""
        var sceneAnswerb = ""
        var sceneAnswerc = ""
        var sceneAnswerd = ""
        var sceneAnswere = ""
        
        if question.answers.count > 0 {
           sceneAnswera = "a. \(question.answers[0]) \n"
        }
        if question.answers.count > 1 {
            sceneAnswerb = "b. \(question.answers[1]) \n"
           
        }
        if question.answers.count > 2 {
          sceneAnswerc = "c. \(question.answers[2]) \n"
          
        }
        if question.answers.count > 3 {
         sceneAnswerd = "d. \(question.answers[3]) \n"
      
        }
        if question.answers.count > 4 {
           sceneAnswere = "e. \(question.answers[4]) \n"
          
        }
        
        
        
//        let textGeom = questionNode.geometry as! SCNText
//        textGeom.string = sceneQuestionNo + scenePrompt + sceneAnswera + sceneAnswerb + sceneAnswerc + sceneAnswerd + sceneAnswere
        
        let questionText = SCNText(string: "Question", extrusionDepth: 0.5)
        questionText.font = UIFont (name: "Arial", size: 5)
        questionText.firstMaterial?.diffuse.contents = UIColor.white
        
        questionNode = SCNNode(geometry: questionText)
        let questionGeometry = questionNode.geometry as? SCNText
        questionGeometry?.string = sceneQuestionNo + scenePrompt + sceneAnswera + sceneAnswerb + sceneAnswerc + sceneAnswerd + sceneAnswere
        let boundingBox = questionNode.boundingBox
        let width = abs(boundingBox.max.x - boundingBox.min.x)
        questionNode.pivot = SCNMatrix4MakeTranslation((width/2.0), 0, 0)
        questionNode.pivot = SCNMatrix4MakeRotation(70, 1, 0, 0)
        questionNode.position.x = 0
        questionNode.position.y = -20
        questionNode.position.z = 150
        
        
        let questionMoveAction = SCNAction.moveBy(x: 0, y: 0, z: -1, duration: 0.07)
        questionMoveAction.timingMode = .easeInEaseOut;
        let moveLoop = SCNAction.repeatForever(questionMoveAction)
        
        questionNode.runAction(moveLoop)
        scene.rootNode.addChildNode(questionNode)
        
        removeNode = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let action1 = SCNAction.fadeOut(duration: 0.25)
            let action2 = SCNAction.fadeIn(duration: 0.25)
            let blinkAction = SCNAction.sequence([action1,action2])
            nextQuestionNode.runAction(blinkAction)
        
        let point = touch.location(in: sceneKitView)
        let hitResults = sceneKitView.hitTest(point, options:[SCNHitTestOption.searchMode: SCNHitTestSearchMode.all.rawValue])
            for hitResult in hitResults {
                if hitResult.node.name == nil {
                    print("Entered")
                quizQuestionIndex += 1
                if quizQuestionIndex == quiz.count {
                    quizQuestionIndex = 0
                }
                    displayQuizQuestion(index: quizQuestionIndex)
                    
                }
                
            }
        
        }

    }
    
}

