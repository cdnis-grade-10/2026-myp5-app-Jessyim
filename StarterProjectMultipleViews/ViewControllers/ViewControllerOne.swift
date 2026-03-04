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

class ViewControllerOne: UIViewController {
    
    // MARK: - IBOutlets
    
    
    
    // MARK: - Variables and Constants
    var nameOfCAS = String()
    
    
    // MARK: - IBActions and Functions
  
    
    @IBAction func Creativity(_ sender: Any) {
        nameOfActivity.buttonName = "Creativity"
        // the button is chosen as creativty so the name creativity is stored into the storage file under the structure called name of activity, and specifically the button name
    }
    
    @IBAction func Activity(_ sender: Any) {
        nameOfActivity.buttonName = "Activity"
        // similarly the name activity is stored
    }
    
    @IBAction func Service(_ sender: Any) {
        nameOfActivity.buttonName = "Service"
        // service is chosen to be stored
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

}

