//
//  ViewController.swift
//  Seques Example
//
//  Created by Akhil Nadendla on 5/21/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //seques provide the bridge from one view controller to the next
    //arrows on storyboard show which controller is launched 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSUserDefaults.standardUserDefaults().setObject("ROB", forKey: "name")
        
        var name = NSUserDefaults.standardUserDefaults().objectForKey("name")! as! String
        
        println(name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

