//
//  SecondViewController.swift
//  To Do List
//
//  Created by Akhil Nadendla on 6/16/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var item: UITextField!
    
    @IBAction func addItem(sender: AnyObject)
    {
<<<<<<< HEAD
        toDoList.append(item.text!)
=======
        toDoList.append(item.text)
>>>>>>> origin/master
        item.text = ""
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //allows for tap to close keyboard
<<<<<<< HEAD
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
=======
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
>>>>>>> origin/master
        self.view.endEditing(true)
    }
    
    //allows for close keyboard using return button
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        item.resignFirstResponder()
        return true
    }
    

}

