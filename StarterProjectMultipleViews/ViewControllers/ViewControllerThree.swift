/*
 
 ViewControllerThree.swift
 
 This file will contain the code for the third viewcontroller.
 Please ensure that your code is organised and is easy to read.
 This means that you will need to both structure your code correctly,
 in addition to using the correct syntax for Swift.
 
 Unless you are told otherwise, ensure that you are using the
 camelCase syntax. For example, outputLabel and firstName are good
 examples of using the camelCase syntax.
 
 Within each class, you can see clearly identified sections denoted by
 MARK statements. These MARK statements allow you to structure and organise
 your code.
 
 - @IBOutlets should be listed under the MARK section on IBOutlets
 - Variables and constants listed under the MARK section Variables and Constants
 - Functions (including @IBActions) listed under the section on IBActions and Functions.
 
 As you develop each view controller class with Swift code, please include
 detailed comments to both demonstrate understanding, and which serve you as
 a reminder as to what your code actually does.
 
 */

import UIKit
import SwiftUI

class ViewControllerThree: UIViewController {
    // this is the view for timers
    // MARK: - IBOutlets
    
    @IBOutlet weak var timerImage: UIImageView!
    
    @IBOutlet weak var timerValue: UILabel!
    var currentIndex = 0
    // MARK: - Variables and Constants
    
    
    @State private var time = 00.00
    @State private var isRunning = false
    @State private var timer:Timer?
    
    
    
    
    func startTimer(){
        guard !isRunning else {return}
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updatetImer), userInfo: nil, repeats: true)
        isRunning = true
        //tells the computer that yes the timer is repeating and still counting the timer
    }
    func stopTimer(){
        timer?.invalidate()
        timer=nil
        isRunning = false
        // tells the computer that the timer SHOULD STOP
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        stopTimer()
        time = 00.00
        updateTimerLabel()
    }
    
    @objc func updatetImer(){
        time+=0.01
        updateTimerLabel()
    }
    func updateTimerLabel(){
        timerValue.text=(String(format:"%.2f",time))
    }
    
    // MARK: - IBActions and Functions
    
    @IBAction func startOrStop(_ sender: UIButton) {
        if sender.tag == 1 {
                stopTimer()
        }else{
            startTimer()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
    }

