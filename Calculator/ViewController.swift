//
//  ViewController.swift
//  Calculator
//
//  Created by Janus Manlapaz on 12/27/15.
//  Copyright (c) 2015 Janus Manlapaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel! //implicitly unwrapped optional
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
   
 
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        let range = display.text!.rangeOfString(".")
        if(range == nil || range?.startIndex > display.text!.endIndex || digit != ".")
        {
    
            if userIsInTheMiddleOfTypingANumber {
                display.text! +=  digit

            }
            else {
                display.text = digit
                userIsInTheMiddleOfTypingANumber = true
            }
        }

    }
    @IBAction func operate(sender: UIButton) {
       
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0 //lame
            }
        }
    }
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0 //lame
        }
        
        
    }
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue //look up
            
        }
        set{
            display.text = "\(newValue)" //converts Double string
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

