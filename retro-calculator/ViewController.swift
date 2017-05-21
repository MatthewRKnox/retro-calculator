//
//  ViewController.swift
//  retro-calculator
//
//  Created by Matthew Knox on 5/20/17.
//  Copyright © 2017 Matthew Knox. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = "0"
    var rightValString = ""
    var currentOperation : Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)

        } catch let err as NSError {
            print(err.debugDescription)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var outputLabel : UILabel!
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(op: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(op: Operation.Multiply)

    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(op: Operation.Subtract)

    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(op: Operation.Add)

    }
    
    @IBAction func onEqualsPressed(_ sender: Any) {
        processOperation(op: currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                    
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                    
                else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }
                    
                else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }
                
                outputLabel.text = result
                leftValString = result
            }
                currentOperation = op
            
            
        }
        else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    
    }
}

