//
//  ViewControllerTimer.swift
//  clock
//
//  Created by Akhil Nadendla on 6/29/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import Darwin
import AVFoundation

class ViewControllerTimer: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet var TimerKnobGripImage: UIImageView!
    
    @IBOutlet var TimerKnobHandleImage: UIImageView!
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var TimerLines: UIImageView!
    @IBOutlet var TimerLinesBelow: UIImageView!
    @IBOutlet var TimerCircle1: UIImageView!
    @IBOutlet var TimerCircle2: UIImageView!
    @IBOutlet var TimerCircle3: UIImageView!
    @IBOutlet var TimerView: UIView!
    @IBOutlet var trashIcon: UIButton!
    @IBOutlet var TimerLabelTextFeild: UITextField!
    @IBOutlet var plusOneMinuteButton: UIButton!
    
    var lightColor: UIColor = UIColor(red: 70/256, green: 165/256, blue: 220/256, alpha: 1)
    var mediumColor: UIColor = UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)//UIColor(red: 246/256, green: 179/256, blue: 0/256, alpha: 1)//UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)
    var darkColor: UIColor = UIColor(red: 3/256, green: 101/256, blue: 156/256, alpha: 1)
    var whiteColor: UIColor = UIColor.whiteColor()

    @IBOutlet var Timer60Label: UILabel!
    @IBOutlet var Timer30Label: UILabel!
    @IBOutlet var Timer45Label: UILabel!
    @IBOutlet var Timer15Label: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var playImageBG: UIImageView!
    
    
    var angleOfRotation:CGFloat = 0.0
    var seconds: Int = 0
    var minutes:Int = 0
    var hours:Int = 0
    var updateTimeCurrentSeconds: Int = 0
    
    var netDrag: CGFloat = 0
    var prevAngleOfRotation: CGFloat = 0
    var masterAngle: CGFloat = 0
    
    var gestureDisabled: Bool = false
    var timerOn: Bool = false
    var played: Bool = false
    
    var digitaltimer: NSTimer = NSTimer()
    var flashingTimer: NSTimer = NSTimer()
    var flashingCounter: Int = 0
    var timerLabelText: NSMutableAttributedString = NSMutableAttributedString()
    var playOn: Bool = false
    
    var timerSoundEffect: String = "timerSound"
    var player: AVAudioPlayer = AVAudioPlayer()
    var currentFontSize: CGFloat = 0.0
    
    @IBOutlet var deleteTimerPressed: UIButton!

    
    @IBAction func deleteTrashButtonPressed(sender: AnyObject) {
        angleOfRotation = 0.0
        seconds = 0
        minutes = 0
        hours = 0
        netDrag = 0
        prevAngleOfRotation = 0
        masterAngle = 0
        gestureDisabled = false
        timerOn = false
        played = false
        digitaltimer.invalidate()
        flashingTimer.invalidate()
        flashingCounter = 0
        timerLabelText = NSMutableAttributedString()
        playOn = false
        let origImage = UIImage(named: "Play Icon")
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        playButton.setImage(tintedImage, forState: .Normal)
        playButton.tintColor = darkColor
        playButton.hidden = true
        playImageBG.hidden = true
        TimerKnobGripImage.hidden = false
        TimerKnobHandleImage.hidden = false
        updateTimeCurrentSeconds = 0
        self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
        self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
        calculateAndSetTimerValue(angleOfRotation)
        setTimerLineColor()
        setCircleColor()
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "TimerON")
    }
    
    @IBAction func addOneMinutePressed(sender: AnyObject) {
        if timerOn {
            minutes++
            if minutes % 60 == 0 {
                hours++
            }
            minutes %= 60
            
            seconds++
            updateTime()
        }
    }
    
    @IBAction func playPressed(sender: AnyObject) {
        if playOn == false {
            if minutes == 0 && seconds == 0 && hours == 0 {
                println("can't start timer with zero time")
                return
            }
            timerOn = true
            TimerKnobGripImage.hidden = true
            TimerKnobHandleImage.hidden = true
            playOn = true
            if !played {
                seconds = 0
                played = true
                updateTimeCurrentSeconds = (hours*60*60) + (minutes*60) + seconds
            }
            else {
                println("reset")
                timerLabel.attributedText = timerLabelText
            }
            let origImage = UIImage(named: "Pause Icon")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            playButton.setImage(tintedImage, forState: .Normal)
            playButton.tintColor = darkColor
            flashingTimer.invalidate()
            digitaltimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        }
        else if playOn == true {
            playOn = false
            if player.playing {
                player.stop()
                deleteTrashButtonPressed(self)
                return
            }
            let origImage = UIImage(named: "Play Icon")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            flashingTimer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("flashingeffect"), userInfo: nil, repeats: true)
            playButton.setImage(tintedImage, forState: .Normal)
            playButton.tintColor = darkColor
            digitaltimer.invalidate()
        }
    }
    
    func flashingeffect(){
        if flashingCounter % 2 == 0 {
            timerLabelText.addAttribute(NSForegroundColorAttributeName, value: whiteColor, range: NSRange(location: 0, length:  timerLabelText.length))
            if( hours == 0) {
                timerLabelText.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length:  timerLabelText.length-5))
            }
            timerLabel.attributedText = timerLabelText
        }
        else {
            timerLabelText.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length:  timerLabelText.length))
            timerLabel.attributedText = timerLabelText
        }
        flashingCounter++
    }
    
    func changePressedColor(sender: UIButton) {
            playButton.tintColor = mediumColor
    }
    func changeReleasedColor(sender: UIButton){
            playButton.tintColor = darkColor
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        playPressed(sender)
    }
    
    func updateTime(){
        println("timer running")
        println(hours)
        println(minutes)
        println(seconds)
        var tempString: String = ""
        var tempAngle: CGFloat = CGFloat( minutes*60 + seconds )
        tempAngle = (tempAngle / 3600) * 360
        setCircleColor(tempAngle)
        setTimerLineColor(tempAngle)
        seconds--
        if seconds <= 0 {
            if minutes >= 1 {
                seconds = 59
            }
            minutes--
            if minutes <= 0 {
                if hours >= 1 {
                    minutes = 59
                }
                hours--
            }
        }
        if seconds <= 0 && minutes <= 0 && hours <= 0 {
            println("ring timer")
            player.play()
            tempString = "00:00"
            if hours < 0 {
                hours = 0
            }
        }
        else {
            if seconds < 10 {
                if minutes <= 9 {
                    tempString = "0\(minutes):0\(seconds)"
                }
                else if minutes == 60 {
                    tempString = "00:0\(seconds)"
                }
                else {
                    tempString = "\(minutes):0\(seconds)"
                }
            }
            else {
                if minutes <= 9 {
                    if seconds == 60 {
                        tempString = "0\(minutes):00"
                    }
                    else {
                        tempString = "0\(minutes):\(seconds)"
                    }
                }
                else if minutes == 60 {
                    if seconds == 60 {
                        tempString = "00:00"
                    }
                    else {
                        tempString = "00:\(seconds)"
                    }
                }
                else {
                    if seconds == 60 {
                        tempString = "\(minutes):00"
                    }
                    else {
                        tempString = "\(minutes):\(seconds)"
                    }
                }
            }
        }
        if hours >= 0 {
            var hourStr: NSString = "\(hours)hr"
            var mystr:NSString = (hourStr as String) + (tempString as String)
            println(mystr)
            var mutableStr =  NSMutableAttributedString(string: mystr as String, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: currentFontSize)!])
            mutableStr.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: currentFontSize-35)!, range: NSRange(location: 0, length: hourStr.length))
            if hours == 0 {
                mutableStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length:  3))
            }
            mutableStr.addAttribute(NSBaselineOffsetAttributeName, value: currentFontSize/3, range: NSRange(location: 0, length:  hourStr.length))
            timerLabel.attributedText = mutableStr
            timerLabelText = mutableStr
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupTimer(){
        TimerKnobGripImage.image = TimerKnobGripImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerKnobGripImage.tintColor = darkColor
        TimerKnobHandleImage.image = TimerKnobHandleImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerKnobHandleImage.tintColor = mediumColor
        TimerLines.image = TimerLines.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerLines.tintColor = darkColor
            
        TimerLinesBelow.image = TimerLinesBelow.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerLinesBelow.tintColor = darkColor
        
        TimerCircle1.image = TimerCircle1.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle1.tintColor = darkColor
        
        TimerCircle2.image = TimerCircle2.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle2.tintColor = darkColor
        
        TimerCircle3.image = TimerCircle3.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        TimerCircle3.tintColor = darkColor
        
        TimerKnobGripImage.userInteractionEnabled = true
    }
    
    func setUpTextConstraints(){
        TimerLabelTextFeild.delegate = self
        TimerLabelTextFeild.minimumFontSize = 1/TimerLabelTextFeild.font.pointSize
        TimerLabelTextFeild.adjustsFontSizeToFitWidth = true
        plusOneMinuteButton.titleLabel!.numberOfLines = 1
        plusOneMinuteButton.titleLabel!.minimumScaleFactor = 1 / plusOneMinuteButton.titleLabel!.font.pointSize
        plusOneMinuteButton.titleLabel!.adjustsFontSizeToFitWidth = true
        timerLabel.numberOfLines = 1
        timerLabel.minimumScaleFactor = 1/timerLabel.font.pointSize
        timerLabel.adjustsFontSizeToFitWidth = true
        currentFontSize = timerLabel.font.pointSize
        var mystr:NSString = "0hr00:00"
        var mutableStr =  NSMutableAttributedString(string: mystr as String, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: currentFontSize)!])
        mutableStr.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: currentFontSize-35)!, range: NSRange(location: 0, length: 3))
        mutableStr.addAttribute(NSBaselineOffsetAttributeName, value: currentFontSize/3, range: NSRange(location: 0, length:  3))
        mutableStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length:  3))
        timerLabel.attributedText = mutableStr
        timerLabelText = mutableStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        var rightswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        var leftswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        leftswipe.direction = .Left
        rightswipe.direction = .Right
        view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
        var panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "draggedView:")
        //panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        TimerKnobGripImage.addGestureRecognizer(panGesture)
        view.userInteractionEnabled = true
        TimerView.userInteractionEnabled = true
        
        setUpTextConstraints()
        
        var audioPath = NSBundle.mainBundle().pathForResource(timerSoundEffect, ofType: "wav")!
        player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath), error: nil)
        
        //setup play button
        let origImage = UIImage(named: "Play Icon")
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        playButton.setImage(tintedImage, forState: .Normal)
        playButton.tintColor = darkColor
        playButton.addTarget(self, action: "changePressedColor:", forControlEvents: UIControlEvents.TouchDown)
        playButton.addTarget(self, action: "changeReleasedColor:", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.addTarget(self, action: "changeReleasedColor:", forControlEvents: UIControlEvents.TouchUpOutside)
        playImageBG.hidden = true
        playButton.hidden = true
        if NSUserDefaults.standardUserDefaults().boolForKey("TimerON") {
            println("entered view did load")
            println(hours)
            println(minutes)
            println(seconds)
            gestureDisabled = false
            timerOn = true
            playOn = false
            playButton.hidden = false
            playImageBG.hidden = false
            self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
            self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
            calculateAndSetTimerValue(angleOfRotation)
            setTimerLineColor()
            setCircleColor()
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "TimerON")

        }
    }
    func checkBounds(loc: CGPoint)-> Bool {
        var upperboundary:CGFloat = 0.95
        var ymax = TimerView.center.y+(TimerView.bounds.height/2)*upperboundary
        var ymin = TimerView.center.y-(TimerLines.bounds.height/2)*upperboundary
        var xmax = TimerView.center.x+(TimerView.bounds.width/2)*upperboundary
        var xmin = TimerView.center.x-(TimerView.bounds.width/2)*upperboundary
        if loc.y >= ymin && loc.y <= ymax && loc.x >= xmin && loc.x <= xmax {
            var lowerboundary:CGFloat = 0.3
            ymax = TimerView.center.y+(TimerView.bounds.height/2)*lowerboundary
            ymin = TimerView.center.y-(TimerView.bounds.height/2)*lowerboundary
            xmax = TimerView.center.x+(TimerView.bounds.width/2)*lowerboundary
            xmin = TimerView.center.x-(TimerView.bounds.width/2)*lowerboundary
            if loc.y <= ymax && loc.y >= ymin && loc.x >= xmin && loc.x <= xmax {
                return false
            }
            return true
        }
        else {
            return false
        }
    }
    
    func calculateAndSetTimerValue(angle: CGFloat){
        minutes = Int(60 * ((angle+1)/360))
        hours = Int(masterAngle / 360)
        var tempString:NSString = ""
        if masterAngle != 0 {
            self.playImageBG.hidden = false
            self.playButton.hidden = false
        }
        if minutes < 10 {
                tempString = "0\(minutes):00"
        }
        else {
                if minutes == 60 {
                    tempString = "00:00"
                }
                else {
                    tempString = "\(minutes):00"
                }
        }
        if hours >= 0 {
            var hourStr: NSString = "\(hours)hr"
            var mystr:NSString = (hourStr as String) + (tempString as String)
            println(mystr)
            var mutableStr =  NSMutableAttributedString(string: mystr as String, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: currentFontSize)!])
            mutableStr.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: currentFontSize-35)!, range: NSRange(location: 0, length: hourStr.length))
            if hours == 0 {
                mutableStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length:  3))
            }
            mutableStr.addAttribute(NSBaselineOffsetAttributeName, value: currentFontSize/3, range: NSRange(location: 0, length:  hourStr.length))
            timerLabel.attributedText = mutableStr
            timerLabelText = mutableStr
        }
    }
    func setTimerLineColor(){
        var min:Int = Int(60 * ((angleOfRotation+1)/360))
        var number = Int(min / 5)
        number += 1
        if number == 13 {
            number = 12
        }
        if number >= 1 && number <= 12 {
            TimerLines.image = UIImage(named: "Timer Lines Clkwise\(number)")
            TimerLines.image = TimerLines.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            TimerLines.tintColor = mediumColor
        }
    }
    func setTimerLineColor(specifiedAngle: CGFloat){
        var min:Int = Int(60 * ((specifiedAngle+1)/360))
        var number = Int(min / 5)
        number += 1
        if number == 13 {
            number = 12
        }
        if number >= 1 && number <= 12 {
            TimerLines.image = UIImage(named: "Timer Lines Clkwise\(number)")
            TimerLines.image = TimerLines.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            TimerLines.tintColor = mediumColor
        }
    }
    func setCircleColor(){
        //timer circle 2 is the only one rotating
        //1 is on right
        //3 is on left
        if angleOfRotation >= 0 && angleOfRotation <= 180 {
            TimerView.bringSubviewToFront(TimerCircle3)
            TimerCircle1.tintColor = darkColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
        }
        if angleOfRotation <= 360 && angleOfRotation >= 180 {
            TimerView.bringSubviewToFront(TimerCircle2)
            TimerCircle1.tintColor = mediumColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((angleOfRotation) * CGFloat(M_PI)) / 180.0)
        }
    }
    func setCircleColor(specifiedAngle: CGFloat){
        //timer circle 2 is the only one rotating
        //1 is on right
        //3 is on left
        if specifiedAngle >= 0 && specifiedAngle <= 180 {
            TimerView.bringSubviewToFront(TimerCircle3)
            TimerCircle1.tintColor = darkColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((specifiedAngle * CGFloat(M_PI)) / 180.0))
        }
        if specifiedAngle <= 360 && specifiedAngle >= 180 {
            TimerView.bringSubviewToFront(TimerCircle2)
            TimerCircle1.tintColor = mediumColor
            TimerCircle3.tintColor = darkColor
            TimerCircle2.tintColor = mediumColor
            self.TimerCircle2.transform = CGAffineTransformMakeRotation(((specifiedAngle) * CGFloat(M_PI)) / 180.0)
        }
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //close keyboard
        self.view.endEditing(true)
        //ignore input if timer running
        if timerOn {
            return
        }
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInView(self.view)
        if checkBounds(touchLocation) {
            var x = touchLocation.x - TimerView.center.x
            var y = touchLocation.y - TimerView.center.y
            y *= -1
            var angle:CGFloat = 0.0
            if x >= 0 && y >= 0 {
                angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                angle = 90 - angle
            }
            else if x >= 0 && y <= 0 {
                angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                angle = 90 + angle
            }
            else if (x <= 0 && y >= 0) {
                angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                angle = 270 + angle
            }
            else if x <= 0 && y <= 0 {
                angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                angle = 180 + (90-angle)
            }
            if isnan(angle) == false{
                if angle % 6 < 3 {
                    angle = angle - (angle%6)
                }
                else {
                    angle = angle + (6-(angle%6))
                }
                var minutes:Int = Int(60 * ((angle+1)/360))
                if minutes % 15 == 1 {
                    angle -= 6
                }
                else if minutes % 15 == 14{
                    angle += 6
                }
                if angle == 360 {
                    angle -= 6
                }
                self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
                self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
            }
            angleOfRotation = angle
            masterAngle += (angleOfRotation-(masterAngle%360))
            calculateAndSetTimerValue(angleOfRotation)
            setTimerLineColor()
            setCircleColor()
            if masterAngle == 0 {
                println("hide play button")
                playButton.tintColor = darkColor
                playImageBG.hidden = true
                playButton.hidden = true
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("performi segue")
        if timerOn == true {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "TimerON")
        }
        else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "TimerON")
        }
    }
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Left){
            println("swipe left")
            self.performSegueWithIdentifier("switchToStopwatchFromTimer", sender: self)
        }
        else if(sender.direction == .Right){
            println("swipe right")
            self.performSegueWithIdentifier("switchToClockFromTimer", sender: self)
        }
    }
    
    
    func calcNetDrag() -> Bool{
        if prevAngleOfRotation > 300 && angleOfRotation < 100 {
            println("crossed 60")
            netDrag += (360-prevAngleOfRotation)+(angleOfRotation)
            masterAngle += (360-prevAngleOfRotation)+(angleOfRotation)
            return true
        }
        else if prevAngleOfRotation < 100 && angleOfRotation > 300{
            if masterAngle - ((360-angleOfRotation)+(prevAngleOfRotation)) <= 0 {
                //println("reverted across 60")
                masterAngle = 0
                prevAngleOfRotation = 0
                angleOfRotation = 0
                gestureDisabled = true
                return false
            }
            else {
                netDrag -= (360-angleOfRotation)+(prevAngleOfRotation)
                masterAngle -= (360-angleOfRotation)+(prevAngleOfRotation)
                return true
            }
        }
        else {
            netDrag += angleOfRotation-prevAngleOfRotation
            masterAngle += angleOfRotation-prevAngleOfRotation
            return true
        }
    }
    
    func draggedView(recognizer:UIPanGestureRecognizer){
        if timerOn {
            return
        }
        if recognizer.state == UIGestureRecognizerState.Began {
            netDrag = 0
            gestureDisabled = false
            prevAngleOfRotation = angleOfRotation
        }
        else if recognizer.state == UIGestureRecognizerState.Ended  && !gestureDisabled{
            var angle:CGFloat = angleOfRotation
            if angle % 6 < 3 {
                angle = angle - (angle%6)
            }
            else {
                angle = angle + (6-(angle%6))
            }
            if isnan(angle) == false{
                self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
                self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
                calcNetDrag()
                println("net drag = \(netDrag)")
                if angle == 360 {
                    angle = 0
                }
                angleOfRotation = angle
                println("drag ended with \(angle)")
                calculateAndSetTimerValue(angleOfRotation)
                setTimerLineColor()
                setCircleColor()
                println("master angle = \(masterAngle)")
            }
            if angle == 0 {
                println("hide play button")
                playButton.tintColor = darkColor
                playImageBG.hidden = true
                playButton.hidden = true
            }
        }
        else if !gestureDisabled {
            let touchLocation = recognizer.locationInView(self.view)//locationOfTouch(0, inView: self.view)
            var x = touchLocation.x - TimerView.center.x
            var y = touchLocation.y - TimerView.center.y
            y *= -1
            if checkBounds(touchLocation) {
                var x = touchLocation.x - TimerView.center.x
                var y = touchLocation.y - TimerView.center.y
                y *= -1
                var angle:CGFloat = 0.0
                if x >= 0 && y >= 0 {
                    angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                    angle = 90 - angle
                }
                else if x >= 0 && y <= 0 {
                    angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                    angle = 90 + angle
                }
                else if (x <= 0 && y >= 0) {
                    angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                    angle = 270 + angle
                }
                else if x <= 0 && y <= 0 {
                    angle = atan(abs(y)/abs(x)) * (180/CGFloat(M_PI))
                    angle = 180 + (90-angle)
                }
                var validDrag:Bool = calcNetDrag()
                if validDrag {
                    if angle == 360 {
                        angle = 0
                    }
                    prevAngleOfRotation = angleOfRotation
                    angleOfRotation = angle
                    calculateAndSetTimerValue(angleOfRotation)
                    setTimerLineColor()
                    setCircleColor()
                    if isnan(angle) == false{
                        self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
                        self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angle * CGFloat(M_PI)) / 180.0))
                    }
                }
                else {
                    calculateAndSetTimerValue(angleOfRotation)
                    setTimerLineColor()
                    setCircleColor()
                    if isnan(angleOfRotation) == false{
                        self.TimerKnobGripImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
                        self.TimerKnobHandleImage.transform = CGAffineTransformMakeRotation(((angleOfRotation * CGFloat(M_PI)) / 180.0))
                    }
                }
                if masterAngle == 0 {
                    println("hide play button")
                    playButton.tintColor = darkColor
                    playImageBG.hidden = true
                    playButton.hidden = true
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
