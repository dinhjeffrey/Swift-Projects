//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Akhil Nadendla on 5/21/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // specific data for that user
        //stores data
        NSUserDefaults.standardUserDefaults().setObject("Akhil", forKey: "name")
        //retrieves data also the as String is needed for anytime you're retrieving data from NSUserDefaults
         var tem = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        println(tem)
        
        var arr = [1,2,3]
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        var recalledArray = NSUserDefaults.standardUserDefaults().objectForKey("array") as! NSArray
        println(recalledArray[2])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

