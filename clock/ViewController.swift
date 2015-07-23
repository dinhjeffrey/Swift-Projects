//
//  ViewController.swift
//  clock
//
//  Created by Akhil Nadendla on 6/27/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet var Time: UILabel!
    
    @IBOutlet var AMorPM: UILabel!
    
    @IBOutlet var secondsLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var secondHandImageview: UIImageView!
    
    @IBOutlet var minuteHandImageview: UIImageView!
    
    @IBOutlet var hourHandImageView: UIImageView!
    
    @IBOutlet var clockImageView: UIImageView!
    
    @IBOutlet var clock12Label: UILabel!
    
    @IBOutlet var clock3Label: UILabel!
    
    @IBOutlet var Clock6Label: UILabel!
    
    @IBOutlet var Clock9Label: UILabel!
    
    @IBOutlet var tabBarrier1: UIBarButtonItem!
    
    @IBOutlet var tabBarrier2: UIBarButtonItem!
    
    @IBOutlet var tabBarrier3: UIBarButtonItem!
    
    
    var secondHandPosition: CGFloat = 0.0
    var minuteHandPosition: CGFloat = 0.0
    var hourHandPosition:   CGFloat = 0.0
    var clockMode: Int = 0 //0 will be analog, 1 will be digital, 2 will be analog with number
    
    var clocktimer: NSTimer = NSTimer()
    var digitaltimer: NSTimer = NSTimer()
    
    func getMonth(month:Int)->String {
        switch(month){
            case 1:
                return "January"
            case 2:
                return "February"
            case 3:
                return "March"
            case 4:
                return "April"
            case 5:
                return "May"
            case 6:
                return "June"
            case 7:
                return "July"
            case 8:
                return "August"
            case 9:
                return "September"
            case 10:
                return "October"
            case 11:
                return "November"
            case 12:
                return "December"
            default:
                return ""
        }
    }
    func getDayOfWeek(day:Int)->String {
        switch(day){
            case 1:
                return "Sun,"
            case 2:
                return "Mon,"
            case 3:
                return "Tue,"
            case 4:
                return "Wed,"
            case 5:
                return "Thu,"
            case 6:
                return "Fri,"
            case 7:
                return "Sat,"
            default:
                return ""
        }
    }

    
    func updateTime(){
            //empty clock images
            secondHandImageview.image = UIImage()
            minuteHandImageview.image = UIImage()
            hourHandImageView.image   = UIImage()
            clockImageView.image = UIImage()
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute |
                .CalendarUnitSecond | .CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitWeekday, fromDate: date)
            var hour = components.hour
            let minutes = components.minute
            let seconds = components.second
            let dayOfWeek = components.weekday
            let dayOfMonth = components.day
            let month = components.month
            if hour < 12 {
                AMorPM.text = "AM"
            }
            else {
                AMorPM.text = "PM"
                hour = hour - 12
            }
            if hour == 0 {
                Time.text = "12"
            }
            else if hour < 10 {
                    Time.text = "0\(hour)"
            }
            else if hour >= 10 && hour <= 12 {
                Time.text = "\(hour)"
            }
            if minutes < 10 {
                Time.text = Time.text! + ":0\(minutes)"
            }
            else {
                Time.text = Time.text! +  ":\(minutes)"
            }
            
            if seconds < 10 {
                secondsLabel.text = "0\(seconds)"
            }
            else{
                secondsLabel.text = "\(seconds)"
            }
            
            dateLabel.text = "\(getDayOfWeek(dayOfWeek)) \(getMonth(month)) \(dayOfMonth)"
    }

    func setupHandsInitially(){
        //first load the images
        secondHandImageview.image = UIImage(named: "Second Hand")
        minuteHandImageview.image = UIImage(named: "Minute Hand")
        hourHandImageView.image   = UIImage(named: "Hour Hand")
        //set colors
        secondHandImageview.image = secondHandImageview.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        secondHandImageview.tintColor = UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)
        
        minuteHandImageview.image = minuteHandImageview.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        minuteHandImageview.tintColor = UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)
        
        hourHandImageView.image = hourHandImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        hourHandImageView.tintColor = UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)
        
        clockImageView.image = UIImage(named: "Clock")
        Time.text = ""
        AMorPM.text = ""
        dateLabel.text = ""
        secondsLabel.text = ""
        animateClock()
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func animateClock() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let hour = components.hour
        let minute = components.minute
        let seconds = components.second
        secondHandPosition = 6.0 * CGFloat(seconds)
        minuteHandPosition = 6.0 * CGFloat(minute)
        if hour < 12 {
            hourHandPosition = 30.0 * CGFloat(hour) + ((minuteHandPosition/360)*30)
        }
        else {
            hourHandPosition = 30.0 * CGFloat(hour-12) + ((minuteHandPosition/360)*30)
        }
        self.secondHandImageview.transform = CGAffineTransformMakeRotation(((secondHandPosition * CGFloat(M_PI)) / 180.0))
        self.minuteHandImageview.transform = CGAffineTransformMakeRotation(((minuteHandPosition * CGFloat(M_PI)) / 180.0))
        self.hourHandImageView.transform = CGAffineTransformMakeRotation(((hourHandPosition * CGFloat(M_PI)) / 180.0))
        
    }
    
    func setOrClearClockNumLabels(set : Bool){
        if set == true {
            clock12Label.text = "12"
            clock3Label.text = "3"
            Clock6Label.text = "6"
            Clock9Label.text = "9"
        }
        else {
            clock12Label.text = ""
            clock3Label.text = ""
            Clock6Label.text = ""
            Clock9Label.text = ""
        }
    }
    
    @IBAction func SwitchView(sender: AnyObject) {
        println("switch time representation")
        clockMode = clockMode % 3
        println(clockMode)
        if clockMode == 0 {
            NSUserDefaults.standardUserDefaults().setInteger(clockMode, forKey: "ClockMode")
            setOrClearClockNumLabels(false)
            clocktimer.invalidate()
            updateTime()
            digitaltimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        }
        else if clockMode == 1 {
            NSUserDefaults.standardUserDefaults().setInteger(clockMode, forKey: "ClockMode")
            setOrClearClockNumLabels(false)
            digitaltimer.invalidate()
            setupHandsInitially()
            clocktimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("animateClock"), userInfo: nil, repeats: true)
        }
        else if clockMode == 2 {
           NSUserDefaults.standardUserDefaults().setInteger(clockMode, forKey: "ClockMode")
           setOrClearClockNumLabels(true)
        }
        clockMode++
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        clockMode = NSUserDefaults.standardUserDefaults().integerForKey("ClockMode")
        if clockMode == 2 {
            setupHandsInitially()
            clocktimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("animateClock"), userInfo: nil, repeats: true)
        }
        /*
        if results.count > 0 {
            println(results.count)
            var str = "AlarmNumber"
            println("Number of Alarms: \(NSUserDefaults.standardUserDefaults().objectForKey(str))")
            for alarm in results {
                var thisAlarm = alarm as! Alarms
                //context.deleteObject(thisAlarm)
                //context.save(nil)
                println(thisAlarm)
            }
        }
        else {
            println("no results found")
        }*/

        SwitchView(self)
        //setup
        Time.numberOfLines = 1
        Time.minimumScaleFactor = 20/Time.font.pointSize
        Time.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        //let's disable the barrier buttons...not supposed to be clickable
        //tabBarrier1.enabled = false
        //tabBarrier2.enabled = false
        //tabBarrier3.enabled = false
    }
    override func viewDidAppear(animated: Bool) {
        var rightswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        var leftswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        leftswipe.direction = .Left
        rightswipe.direction = .Right
        view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Left){
            println("swipe left")
            self.performSegueWithIdentifier("switchToTimerFromClock", sender: self)
        }
        else if(sender.direction == .Right){
            println("swipe right")
            self.performSegueWithIdentifier("SwitchToAlarmFromClock", sender: self)
        }
    }
}

