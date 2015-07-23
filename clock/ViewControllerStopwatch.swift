//
//  ViewControllerStopwatch.swift
//  clock
//
//  Created by Akhil Nadendla on 7/4/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import Darwin
import Foundation

class ViewControllerStopwatch: UIViewController {

    
    var lightColor: UIColor = UIColor(red: 70/256, green: 165/256, blue: 220/256, alpha: 1)
    var mediumColor: UIColor = UIColor(red: 246/256, green: 179/256, blue: 0/256, alpha: 1)
    var darkColor: UIColor = UIColor(red: 3/256, green: 101/256, blue: 156/256, alpha: 1)
    
    var minutes: Int = 0
    var hours: Int = 0
    var seconds:Int = 0
    var stopwatchRunning = false
    var clocktimer: NSTimer = NSTimer()
    var circletimer: NSTimer = NSTimer()
    
    @IBOutlet var TimerCircle1: UIImageView!
    @IBOutlet var TimerCircle3: UIImageView!
    @IBOutlet var TimerCircle2: UIImageView!
    
    @IBOutlet var stopwatchText: UIButton!
    @IBOutlet var stopwatchLabel: UILabel!
    @IBOutlet var resetAndLapButton: UIButton!
    @IBOutlet var StopwatchView: UIView!
    
    @IBOutlet var LapScrollview: UIScrollView!
    
    var resetOn:Bool = false
    
    func setupStopwatch(){
        TimerCircle1.image = TimerCircle1.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle1.tintColor = darkColor
        
        TimerCircle2.image = TimerCircle2.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle2.tintColor = darkColor
        
        TimerCircle3.image = TimerCircle3.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle3.tintColor = darkColor
    }
    
    var scrollviewHeight: CGFloat = 5
    var nextStartingHeight: CGFloat = 10
    var defaultTextHeight: CGFloat = 30
    var defaultTextWidth: CGFloat = 195
    var textSpacing: CGFloat = 5
    var lapNumber: CGFloat = 1
    var labels = [UILabel]()
    var startingTime: Double = 0
    var flashingCounter = 0
    var flashingTimer:NSTimer = NSTimer()
    func flashingeffect(){
        if flashingCounter % 2 == 0 {
            stopwatchLabel.text = ""
        }
        else {
            updateText()
        }
        flashingCounter++
    }
    
    func resetScrollviewVariables(){
        for (var i = 0 ; i < labels.count; i+=1) {
            labels[i].text = ""
        }
        for (var i = 0 ; i < labels.count; i+=1) {
            labels.removeAtIndex(i)
        }
        scrollviewHeight  = 5
        nextStartingHeight  = 10
        defaultTextHeight  = 30
        defaultTextWidth = 210
        textSpacing = 5
        lapNumber = 1
        //reset lap labels
        labels = [UILabel]()
    }
    
    @IBAction func resetOrLapPressed(sender: AnyObject) {
        if resetOn {
            seconds = 0
            minutes = 0
            hours = 0
            animateCounter = 0
            setCircleColor()
            updateText()
            resetScrollviewVariables()
            flashingTimer.invalidate()
            updateText()
        }
        else { //lap on 
            if stopwatchRunning {
                var width = self.view.bounds.width * 0.7
                var height:CGFloat = defaultTextHeight + (textSpacing * 2)
                LapScrollview.contentSize = CGSizeMake(width, scrollviewHeight+defaultTextHeight)
                var label = UILabel(frame: CGRectMake(0,  0, defaultTextWidth, defaultTextHeight))
                label.center = CGPointMake(width/2 , nextStartingHeight)
                label.textAlignment = NSTextAlignment.Center
                var elapsedTime = NSDate.timeIntervalSinceReferenceDate()-startingTime
                startingTime = NSDate.timeIntervalSinceReferenceDate()
                println(elapsedTime)
                var mins = Int(elapsedTime/60.0)
                elapsedTime -= (NSTimeInterval(mins)*60)
                println(elapsedTime)
                var secs = Int(elapsedTime)
                elapsedTime -= NSTimeInterval(secs)
                var millis = Int(elapsedTime*1000)
                let strMinutes =  String(format: "%02d", mins)
                let strSeconds =  String(format: "%02d", secs)
                let strMillis  =  String(format: "%03d", millis)
                label.text = "Lap \(Int(lapNumber))    " + strMinutes + ":" + strSeconds + ":" + strMillis
                label.font = UIFont(name: "Helvetica Neue", size: 20)
                label.numberOfLines = 1
                label.textColor = mediumColor
                labels.append(label)
                self.LapScrollview.addSubview(labels[Int(lapNumber-1)])
                lapNumber++
                scrollviewHeight = scrollviewHeight + defaultTextHeight + (textSpacing * 2)
                nextStartingHeight = (scrollviewHeight+textSpacing)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var rightswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        var leftswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        leftswipe.direction = .Left
        rightswipe.direction = .Right
        view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
        setupStopwatch()
        LapScrollview.scrollEnabled = true
        LapScrollview.userInteractionEnabled = true
    }
    
    var animateCounter:CGFloat = 0
    func setCircleColor(){
        //timer circle 2 is the only one rotating
        //1 is on right
        //3 is on left
        var angleOfRotation: CGFloat = animateCounter%360
        if angleOfRotation >= 0 && angleOfRotation <= 180 {
            //self.view.bringSubviewToFront(TimerCircle3)
            StopwatchView.bringSubviewToFront(TimerCircle3)
            TimerCircle1.tintColor = darkColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
        }
        if angleOfRotation <= 360 && angleOfRotation >= 180 {
            //self.view.bringSubviewToFront(TimerCircle2)
            StopwatchView.bringSubviewToFront(TimerCircle2)
            TimerCircle1.tintColor = mediumColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((angleOfRotation) * CGFloat(M_PI)) / 180.0)
        }
        animateCounter++
    }
    
    func updateText(){
        var min = minutes % 60
        var sec = seconds % 60
        if sec < 10 {
            if min <= 9 {
                stopwatchLabel.text = "0\(min):0\(sec)"
            }
            else {
                stopwatchLabel.text = "\(min):0\(sec)"
            }
        }
        else {
            if min <= 9 {
                stopwatchLabel.text = "0\(min):\(sec)"
            }
            else {
                stopwatchLabel.text = "\(min):\(sec)"
            }
        }

    }

    @IBAction func stopwatchPressed(sender: AnyObject) {
        if !stopwatchRunning {
            stopwatchRunning = true
            flashingTimer.invalidate()
            updateText()
            clocktimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            circletimer =  NSTimer.scheduledTimerWithTimeInterval(0.1667, target: self, selector: Selector("setCircleColor"), userInfo: nil, repeats: true)
            resetAndLapButton.imageView?.image = UIImage(named: "NewLap Icon")
            resetOn = false
            startingTime = NSDate.timeIntervalSinceReferenceDate()
            println(startingTime)
        }
        else {
            stopwatchRunning = false
            clocktimer.invalidate()
            circletimer.invalidate()
            flashingTimer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("flashingeffect"), userInfo: nil, repeats: true)
            resetAndLapButton.imageView?.image = UIImage(named: "Reset Icon")
            resetOn = true
        }
    }
    func updateTime(){
        seconds++
        if seconds % 60 == 0 {
            minutes++
        }
        if minutes % 60 == 0 {
            hours++
        }
        updateText()
    }
 
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Left){
            println("swipe left")
        }
        else if(sender.direction == .Right){
            println("swipe right")
            self.performSegueWithIdentifier("SwitchToTimerFromStopwatch", sender: self)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
