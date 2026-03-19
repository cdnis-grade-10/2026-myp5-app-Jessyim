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
    
    @IBOutlet weak var timerValue: UILabel!
    var currentIndex = 0
    // MARK: - Variables and Constants
    
    
    var time = 00.00
    var isRunning = false
    var timer:Timer?
    
    
    
    
    // MARK: - IBActions and Functions
    
    func startTimer(){
        guard !isRunning else {return}
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updatetimer), userInfo: nil, repeats: true)
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
    
    @objc func updatetimer(){
        time=time+0.01
        //you add 0.01 to the existing time
        updateTimerLabel()
        // the label is then updated with the new numbers
    }
    func updateTimerLabel(){
        timerValue.text=(String(format:"%.2f",time))
    }
    
    @IBAction func logTime(_ sender: Any) {
        let newTime = round(time)
        finalTime.timeofDate = String(newTime)
    }
    
    @IBAction func Start(_ sender: UIButton) {
        startTimer()
        //this button allows for thet imer to start
    }
    @IBAction func Stop(_ sender: UIButton) {
            stopTimer()
        // this stops the timer
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateTimerLabel()
            stopTimer()
            // Do any additional setup after loading the view.
        }
    }

