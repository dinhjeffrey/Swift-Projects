//
//  ViewController.swift
//  Controlling the keyboard
//
//  Created by Akhil Nadendla on 5/21/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func ButtonPressed(sender: AnyObject) {
        label.text = textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //sets up textfield delegate
    //    self.textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //closes keyboard if pressed on screen off keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //optional func textFieldShouldReturn(textField: UITextField) -> Bool
    // called when 'return' key pressed. return NO to ignore.
    // handles when return is pressed on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //weird way of saying close the keyboard
        textField.resignFirstResponder()
        return true
    }

}

/*

Add UITextFieldDelegate to the class declaration:

class ViewController: UIViewController, UITextFieldDelegate
Connect the textfield or write it programmatically

@IBOutlet weak var userText: UITextField!
set your view controller as the text fields delegate in view did load:

override func viewDidLoad() {
super.viewDidLoad()
self.userText.delegate = self
}
Add the following function

func textFieldShouldReturn(userText: UITextField!) -> Bool {
userText.resignFirstResponder()
return true;
}
with all this your keyboard will begin to dismiss by touching outside the textfield aswell as by pressing return key.

*/

