/*
 
 ViewControllerOne.swift
 
 This file will contain the code for the first viewcontroller.
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

class ViewControllerFour: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var finalLabel: UILabel!
    // shows the logged time
    
    @IBOutlet weak var Inputtext: UITextField!
    // where th ereflections are written
    
    @IBOutlet weak var dashboardButton: UIButton!
    // just the buttonback to dashboard
    
    // MARK: - Variables and Constants
    
    
    // MARK: - IBActions and Functions

    func commentLabel(){
        let timeName = "You logged \(previousData.hourtimeofDate) hours, \(previousData.minutestimeofDate) minutes of \(previousData.nameOfActivity) today"
        // shows hours or minutes you have logged
        finalLabel.text = timeName
        // displays text
    }
    
    @IBAction func reflectionSaved(_ sender: UIButton) {
        
        guard let noteText = Inputtext.text, !noteText.isEmpty else {
            // Optionally show an alert if the field is empty
            return
        }
        
        let activity = previousData.nameOfActivity
        // recall, this is in storage folder with teh name of the activities
        
        if let lastIndex = storeData.entries.indices.last {
            // gets the last logged time, and adds the relfetcion to it
            storeData.entries[lastIndex].reflection = noteText
            storeData.saveData()
            //ensure that ethe data is stored well
            
            Inputtext.text = ""
            // cleasrs teh text field after saving
        }else{
            print("no log entry found for ,\(activity)")
            // not rlly useful
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Inputtext.backgroundColor = UIColor(red: 0.9, green: 0.8, blue: 1.0, alpha: 1.0)
        //buttons are too small, so size up and make them bold
        // make a frame to actually make it llook like a button
        
        commentLabel()
        // Do any additional setup after loading the view.
    }

    

}

