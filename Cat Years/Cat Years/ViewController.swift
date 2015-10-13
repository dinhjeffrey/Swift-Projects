//
//  ViewController.swift
//  Cat Years
//
//  Created by Akhil Nadendla on 5/17/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AgeTextOutput: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func calcAgeButton(sender: AnyObject) {
        var enteredAge = textField.text.toInt()
        //exclamation unwraps the variable
        //in case user typed in an incorrect value
        //exclamation says im sure correct value was entered
        if enteredAge != nil {
            var catAge = enteredAge! * 7
            AgeTextOutput.text = "Your cat is \(catAge)"
        }
        else {
            AgeTextOutput.text = "Your input is invalid"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

