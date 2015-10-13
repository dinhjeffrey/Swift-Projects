//
//  ViewController.swift
//  Animations
//
//  Created by Akhil Nadendla on 6/16/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentFrame = 1

    @IBOutlet var alien: UIImageView!

    @IBAction func updateFrame(sender: AnyObject) {
        if currentFrame > 5 {
            currentFrame = 1
        }
        var n = String(currentFrame)
        alien.image = UIImage(named: "frame" + n + ".png")
        currentFrame++
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

