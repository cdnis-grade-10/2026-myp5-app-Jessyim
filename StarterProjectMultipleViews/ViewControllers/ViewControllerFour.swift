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
    
    
    // MARK: - Variables and Constants
    
    
    // MARK: - IBActions and Functions

    func commentLabel(){
        let timeName = finalTime.timeofDate
        finalLabel.text = timeName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentLabel()
        // Do any additional setup after loading the view.
    }

    

}

