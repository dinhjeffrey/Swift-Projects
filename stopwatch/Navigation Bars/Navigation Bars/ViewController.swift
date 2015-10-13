//
//  ViewController.swift
//  Navigation Bars
//
//  Created by Akhil Nadendla on 5/18/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var timer = NSTimer()
    
    var count = 0
    var seconds_ones = 0
    var minutes_ones = 0
    var seconds_tens = 0
    var minutes_tens = 0
    
    var pausePressed = false
    
    var stopWatchStarted = false
    
    func updateTime(){
        if !pausePressed && stopWatchStarted {
            count++
            seconds_ones = count % 10
            seconds_tens = (count / 10) % 6
            minutes_ones = (count / 60) % 10
            minutes_tens = (count / 600) % 6
            time_label.text = "\(minutes_tens)\(minutes_ones):\(seconds_tens)\(seconds_ones)"
        }
    }
    

    @IBOutlet weak var time_label: UILabel!
    
    @IBAction func pause_button(sender: AnyObject) {
        if stopWatchStarted {
            pausePressed = true
            //timer.invalidate() this will pause the timer
        }
    }
    
    @IBAction func play_button(sender: AnyObject) {
        if !stopWatchStarted {
            stopWatchStarted = true
        }
        else {
            pausePressed = false
        }
    }
    
    @IBAction func stop_button(sender: AnyObject) {
        if stopWatchStarted {
            count = 0
            time_label.text = "\(count)\(count):\(count)\(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ticks every second
        //target is the view controller we want to target so use self
        // method that runs every second and result is the func we created
        // userInfo is nil
        // repeats is true to have this happen over and over again
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        time_label.text = "\(count)\(count):\(count)\(count)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

