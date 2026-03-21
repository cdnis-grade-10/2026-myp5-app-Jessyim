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
        let totalSeconds = Int(time)
        let hours = totalSeconds/3600
        //total seconds divided by 3600 is the total hours used
        let minutes = (totalSeconds % 3600) / 60
        //the remainder value from dividing the total hours is at the front in braket, is taken out and divided by 60 to get how many minutes is left
        let seconds = totalSeconds % 60
        // the seconds is the remainder of the totalseconds divided by 60 which is the minute
        let centiseconds = Int((time - Double(totalSeconds)) * 100)
        //the fraction part of total seocnd multiplied by 100 to get a infinite value.
        timerValue.text=(String(format:"%02d:%02d:%02d.%02d",hours,minutes,seconds,centiseconds))
        //%02d ensures double digits forevery singke part of teh value
    }
    
    @IBAction func logTime(_ sender: Any) {
        let totalMinutes = ceil(time/60)
        // ceil takes the number and rounds it, useful for calculating total minutes
        let totalhours = Int(totalMinutes) / 60
        //the value of total minutes divided by 60 gives us to hours, int only give teh 1st half
        let newMinutes = Int(totalMinutes) % 60
        // the remaineder gives us teh "minutes" actually used
        let newTime = timerValue.text ?? "00:00:00.00"
        // for formating purposes not rlly needed anymore
        previousData.hourtimeofDate = String(totalhours)
        previousData.minutestimeofDate = String(newMinutes)
        previousData.latestDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        let entry = aSingleLogEntry(activity: previousData.nameOfActivity,date: Date(),hours:totalhours,minutes: newMinutes)
        //sends teh format fro a single entry 
        storeData.entries.append(entry)
        storeData.saveData()
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

