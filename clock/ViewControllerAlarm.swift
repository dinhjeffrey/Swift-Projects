//
//  ViewControllerAlarm.swift
//  clock
//
//  Created by Akhil Nadendla on 7/4/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import Darwin
import CoreData


class ViewControllerAlarm: UIViewController, settings {

    @IBOutlet var tapForAlarmLabel: UILabel!
    
    @IBOutlet var AddIconBG: UIImageView!
    
    @IBOutlet var AddIconPlus: UIImageView!
    
    @IBOutlet var addAlarmButton: UIButton!
    
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var ToolbarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var TimeHourLabel1: UILabel!
    
    @IBOutlet var TimeHourLabel2: UILabel!
    
    @IBOutlet var TimeHourLabel3: UILabel!
    
    @IBOutlet var TimeHourLabel4: UILabel!
    
    @IBOutlet var TimeHourLabel5: UILabel!
    
    @IBOutlet var TimeHourLabel6: UILabel!
    
    @IBOutlet var TimeHourLabel7: UILabel!
    
    @IBOutlet var TimeHourLabel8: UILabel!
    
    @IBOutlet var TimeHourLabel9: UILabel!
    
    @IBOutlet var TimeHourLabel10: UILabel!
    
    @IBOutlet var TimeHourLabel11: UILabel!
    
    @IBOutlet var TimeHourLabel12: UILabel!
    
    @IBOutlet var TimeHourLabel13: UILabel!
    
    @IBOutlet var swipeView: UIView!
    
    @IBOutlet var SwipeViewTimeLines: UIView!
    
    @IBOutlet var hourLinesView: UIView!
    
    @IBOutlet var AlarmHourLinesImageView: UIImageView!
    @IBOutlet var swipeIconImageView: UIImageView!
    @IBOutlet var currentSelectedTimelabel: UILabel!
    @IBOutlet var scrollViewForAlarms: UIScrollView!
    @IBOutlet var scrollviewCenter: NSLayoutConstraint!
    
    var lightColor: UIColor = UIColor(red: 70/256, green: 165/256, blue: 220/256, alpha: 1)
    var mediumColor: UIColor = UIColor(red: 246/256, green: 179/256, blue: 0/256, alpha: 1)
    var darkColor: UIColor = UIColor(red: 3/256, green: 101/256, blue: 156/256, alpha: 1)
    var clearColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    var swipeMode = false
    var allowConfirm:Bool = false
    var startingPostition:CGFloat = 0
    var endingPosition:CGFloat = 0
    var stepBetweenEachPosition:CGFloat = 0
    
    var currentHour24: CGFloat = 12
    var currentMinute: CGFloat = 720
    var scrollViewActive = false
    
    var Spacing: CGFloat = 5
    var currScrollviewHeight:CGFloat = 40
    var AlarmNumber: Int = 1
    var returnedFromSettingsPage: Bool = false
    var returnedFromSettingsPageDeletedAlarm: Bool = false
    var returnedFromSettingsPageDeletedAlarmID: Int64 = -1
    var prevAnimatedTimerLine: Int = -1
    
    @IBOutlet var topSpaceConstraintForSwipeView: NSLayoutConstraint!
    
    @IBAction func AddAlarm(sender: AnyObject) {
        view.bringSubviewToFront(swipeView)
        view.bringSubviewToFront(SwipeViewTimeLines)
        tapForAlarmLabel.text = ""
        swipeMode = true
        ToolbarTopConstraint.constant = -toolbar.bounds.height
        AddIconBG.image = UIImage()
        AddIconPlus.image = UIImage()
        addAlarmButton.userInteractionEnabled = false
        AlarmHourLinesImageView.image = UIImage(named: "Swipe Alarm Hour Lines")
        swipeIconImageView.image = UIImage(named: "Swipe Alarm Icon")
        currentSelectedTimelabel.text = "12:00 PM"
        swipeView.backgroundColor = darkColor
        setTimeHourLabels(true)
        var currentHeight = self.view.bounds.height/2
        topSpaceConstraintForSwipeView.constant = (currentHeight - swipeView.bounds.height/2)
        scrollviewCenter.constant = -10000
    }
    func changePressedColor(sender: UIButton) {
        AddIconPlus.tintColor = mediumColor
    }
    func changeReleasedColor(sender: UIButton){
        AddIconPlus.tintColor = darkColor
    }
    
    func setTimeHourLabels(set: Bool){
        if set {
            TimeHourLabel1.text = "12"
            TimeHourLabel2.text = "2"
            TimeHourLabel3.text = "4"
            TimeHourLabel4.text = "6"
            TimeHourLabel5.text = "8"
            TimeHourLabel6.text = "10"
            TimeHourLabel7.text = "12"
            TimeHourLabel8.text = "2"
            TimeHourLabel9.text = "4"
            TimeHourLabel10.text = "6"
            TimeHourLabel11.text = "8"
            TimeHourLabel12.text = "10"
            TimeHourLabel13.text = "12"
        }
        else {
            TimeHourLabel1.text = ""
            TimeHourLabel2.text = ""
            TimeHourLabel3.text = ""
            TimeHourLabel4.text = ""
            TimeHourLabel5.text = ""
            TimeHourLabel6.text = ""
            TimeHourLabel7.text = ""
            TimeHourLabel8.text = ""
            TimeHourLabel9.text = ""
            TimeHourLabel10.text = ""
            TimeHourLabel11.text = ""
            TimeHourLabel12.text = ""
            TimeHourLabel13.text = ""
        }
    }
    
    func setUpAlarmPage(){
        tapForAlarmLabel.numberOfLines = 1
        tapForAlarmLabel.minimumScaleFactor = 20/tapForAlarmLabel.font.pointSize
        tapForAlarmLabel.adjustsFontSizeToFitWidth = true
        AddIconBG.image = AddIconBG.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        AddIconPlus.image = AddIconPlus.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        AddIconPlus.tintColor = darkColor
        addAlarmButton.addTarget(self, action: "changePressedColor:", forControlEvents: UIControlEvents.TouchDown)
        addAlarmButton.addTarget(self, action: "changeReleasedColor:", forControlEvents: UIControlEvents.TouchUpInside)
        addAlarmButton.addTarget(self, action: "changeReleasedColor:", forControlEvents: UIControlEvents.TouchUpOutside)
        currentSelectedTimelabel.text = ""
        scrollviewCenter.constant = -10000
    }
    func setupTimerHourLines(){
        TimeHourLabel1.numberOfLines = 1
        TimeHourLabel1.minimumScaleFactor = 1/TimeHourLabel1.font.pointSize
        TimeHourLabel1.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel2.numberOfLines = 1
        TimeHourLabel2.minimumScaleFactor = 1/TimeHourLabel2.font.pointSize
        TimeHourLabel2.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel3.numberOfLines = 1
        TimeHourLabel3.minimumScaleFactor = 1/TimeHourLabel3.font.pointSize
        TimeHourLabel3.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel4.numberOfLines = 1
        TimeHourLabel4.minimumScaleFactor = 1/TimeHourLabel4.font.pointSize
        TimeHourLabel4.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel5.numberOfLines = 1
        TimeHourLabel5.minimumScaleFactor = 1/TimeHourLabel5.font.pointSize
        TimeHourLabel5.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel6.numberOfLines = 1
        TimeHourLabel6.minimumScaleFactor = 1/TimeHourLabel6.font.pointSize
        TimeHourLabel6.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel7.numberOfLines = 1
        TimeHourLabel7.minimumScaleFactor = 1/TimeHourLabel7.font.pointSize
        TimeHourLabel7.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel8.numberOfLines = 1
        TimeHourLabel8.minimumScaleFactor = 1/TimeHourLabel8.font.pointSize
        TimeHourLabel8.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel9.numberOfLines = 1
        TimeHourLabel9.minimumScaleFactor = 1/TimeHourLabel9.font.pointSize
        TimeHourLabel9.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel10.numberOfLines = 1
        TimeHourLabel10.minimumScaleFactor = 1/TimeHourLabel10.font.pointSize
        TimeHourLabel10.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel11.numberOfLines = 1
        TimeHourLabel11.minimumScaleFactor = 1/TimeHourLabel11.font.pointSize
        TimeHourLabel11.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel12.numberOfLines = 1
        TimeHourLabel12.minimumScaleFactor = 1/TimeHourLabel12.font.pointSize
        TimeHourLabel12.adjustsFontSizeToFitWidth = true
        
        TimeHourLabel13.numberOfLines = 1
        TimeHourLabel13.minimumScaleFactor = 1/TimeHourLabel13.font.pointSize
        TimeHourLabel13.adjustsFontSizeToFitWidth = true
    }
    
    
    func setupScrollViewForAlarms(){
        scrollviewCenter.constant = 0
        scrollViewActive = true
        let storedHeight = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("CurrentScrollViewHeight"))
        var currHeight: CGFloat = storedHeight
        if NSUserDefaults.standardUserDefaults().objectForKey("AlarmNumber") != nil {
            AlarmNumber = Int(NSUserDefaults.standardUserDefaults().integerForKey("AlarmNumber"))
        }
        
        println("new current height \(currHeight)")
        var viewWidth = scrollViewForAlarms.bounds.width
        var customView = AlarmViewCustom(frame: CGRectMake(10, 60, 301, 107))
        customView.delegate = self
        customView.MainViewWidth.constant = viewWidth
        customView.MainViewHeight.constant = (customView.MainViewWidth.constant * 107) / 301
        var viewHeight = customView.MainViewHeight.constant
        customView.center = CGPoint(x: viewWidth/2, y: currHeight + Spacing + (viewHeight/2))
        
        customView.setAlarmTimeLabel(currentHour24, currentMinute: currentMinute)
        customView.setAlarmLabelFontSize()
        
        customView.setDaysOfWeek(0, dayOn: true)
        customView.setDaysOfWeek(1, dayOn: true)
        customView.setDaysOfWeek(2, dayOn: true)
        customView.setDaysOfWeek(3, dayOn: true)
        customView.setDaysOfWeek(4, dayOn: true)
        customView.setDaysOfWeek(5, dayOn: true)
        customView.setDaysOfWeek(6, dayOn: true)
        
        customView.setAlarmLabel("Alarm \(AlarmNumber)")
        customView.alarmNumber = Int64(AlarmNumber)
        
        self.scrollViewForAlarms.addSubview(customView)
        currHeight = currHeight + viewHeight + (Spacing * 2)
        println("new current height \(currHeight)")
        scrollViewForAlarms.contentSize = CGSizeMake(viewWidth, currHeight + (10 * Spacing))
        storeAlarm(customView, centerY: Float(customView.center.y),mHeight: Float(viewHeight), mWidth: Float(viewWidth), alarmNum: Int64(AlarmNumber))
        
        AlarmNumber++
        NSUserDefaults.standardUserDefaults().setObject(AlarmNumber, forKey: "AlarmNumber")
        NSUserDefaults.standardUserDefaults().setFloat(Float(currHeight), forKey: "CurrentScrollViewHeight")
    }
    
    func reloadScrollView(Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int, Sat: Int, Sun: Int, time: String, AMorPM: String, centerY: Float, AlarmLabel: String, viewWidth: Float, viewHeight: Float, alarmNum: Int64,  alarmTurnOn: Int){
        scrollviewCenter.constant = 0
        scrollViewActive = true
        let storedHeight = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("CurrentScrollViewHeight"))
        var currHeight: CGFloat = storedHeight
        scrollViewForAlarms.userInteractionEnabled = true
        
        println("view width : \(viewWidth)")

        var customView = AlarmViewCustom(frame: CGRectMake(10, 60, 301, 107))
        customView.delegate = self
        customView.MainViewWidth.constant = CGFloat(viewWidth)
        customView.MainViewHeight.constant = CGFloat(viewHeight)
        var viewHeight = customView.MainViewHeight.constant
        customView.center = CGPoint(x: CGFloat(viewWidth)/2, y: CGFloat(centerY))
        
        customView.setAlarmTimeLabelString(time, AMorPM: AMorPM)
        customView.setAlarmLabelFontSize()
        
        println("printing in reload")
        
        println("\(Bool(Sun))")
        
        println("\(Bool(Mon))")
        
        println("\(Bool(Tues))")
        
        println("\(Bool(Wed))")
        
        println("\(Bool(Thurs))")
        
        println("\(Bool(Fri))")
        
        println("\(Bool(Sat))")
        
        customView.setDaysOfWeek(0, dayOn: Bool(Sun))
        customView.setDaysOfWeek(1, dayOn: Bool(Mon))
        customView.setDaysOfWeek(2, dayOn: Bool(Tues))
        customView.setDaysOfWeek(3, dayOn: Bool(Wed))
        customView.setDaysOfWeek(4, dayOn: Bool(Thurs))
        customView.setDaysOfWeek(5, dayOn: Bool(Fri))
        customView.setDaysOfWeek(6, dayOn: Bool(Sat))
        
        customView.setAlarmOnOff(alarmTurnOn)
        
        customView.setAlarmLabel(AlarmLabel)
        
        customView.alarmNumber = alarmNum
        
        
        scrollViewForAlarms.contentSize = CGSizeMake(CGFloat(viewWidth), currHeight + (10 * Spacing))
        
        self.scrollViewForAlarms.addSubview(customView)
    }
    
    func storeAlarm(customView: AlarmViewCustom, centerY: Float, mHeight: Float, mWidth: Float, alarmNum: Int64){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("Alarms", inManagedObjectContext: context)
        let newAlarm = Alarms(entity: ent!, insertIntoManagedObjectContext: context)
        newAlarm.alarmLabel = customView.AlarmNameLabel.text!
        newAlarm.alarmTime = customView.AlarmTimeLabel.text!
        newAlarm.alarmTurnedOn = Boolean(Int(customView.turnedOn))
        newAlarm.mon = 1
        newAlarm.tues = 1
        newAlarm.wed = 1
        newAlarm.thurs = 1
        newAlarm.fri = 1
        newAlarm.sat = 1
        newAlarm.sun = 1
        newAlarm.amPMtext = customView.AlarmTimePMAMLabel.text!
        newAlarm.centerPositionY = centerY
        newAlarm.mainHeight = mHeight
        newAlarm.mainWidth = mWidth
        newAlarm.alarmNumber = alarmNum
        context.save(nil)
        println(newAlarm)
        println("saved object")
    }
    
    
    func checkBounds(loc: CGPoint)-> Bool {
        var ymax = swipeView.center.y+(swipeView.bounds.height/2)
        var ymin = swipeView.center.y-(swipeView.bounds.height/2)
        var xmax = swipeView.center.x+(swipeView.bounds.width/2)
        var xmin = swipeView.center.x-(swipeView.bounds.width/2)
        if loc.y >= ymin && loc.y <= ymax && loc.x >= xmin && loc.x <= xmax {
            return true
        }
        else {
            return false
        }
    }
   
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if swipeMode {
            
        }
        else if !scrollViewActive{
            println("reached touch begin")
            AddAlarm(self)
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInView(self.view)
        if swipeMode {
            println("reached touch end")
            if allowConfirm {
                if checkBounds(touchLocation) {
                    swipeMode = false
                    ToolbarTopConstraint.constant += toolbar.bounds.height
                    AddIconBG.image = UIImage(named: "Add Icon bg")
                    AddIconPlus.image = UIImage(named: "Add Icon Plus")
                    addAlarmButton.userInteractionEnabled = true
                    AlarmHourLinesImageView.image = UIImage()
                    swipeIconImageView.image = UIImage()
                    currentSelectedTimelabel.text = ""
                    swipeView.backgroundColor = clearColor
                    setTimeHourLabels(false)
                    allowConfirm = false
                    view.sendSubviewToBack(SwipeViewTimeLines)
                    setUpAlarmPage()
                    setupScrollViewForAlarms()
                }
                else {
                    if touchLocation.y > swipeView.center.y + swipeView.bounds.height/2 {
                        topSpaceConstraintForSwipeView.constant += (stepBetweenEachPosition/12)
                        currentMinute += 5
                        currentHour24 = floor(currentMinute/60)
                        println(currentHour24)
                        println(currentMinute)
                        setCurrentTimeDuringTap()
                    }
                    else if touchLocation.y < swipeView.center.y - swipeView.bounds.height/2 {
                        topSpaceConstraintForSwipeView.constant -= (stepBetweenEachPosition/12)
                        currentMinute -= 5
                        currentHour24 = floor(currentMinute/60)
                        println(currentHour24)
                        println(currentMinute)
                        setCurrentTimeDuringTap()
                    }
                }
            }
        }

    }
    
    func setCurrentTimeDuringTap(){
        var minutes:Int = Int(currentMinute%60)
        var hours:Int
        if currentHour24 < 12 {
            hours = Int(currentHour24)
            if hours == 0{
                if minutes < 10 {
                    currentSelectedTimelabel.text = "12:0\(minutes) AM"
                }
                else {
                    currentSelectedTimelabel.text = "12:\(minutes) AM"
                }
            }
            else if hours < 10 {
                if minutes < 10 {
                    currentSelectedTimelabel.text = "0\(hours):0\(minutes) AM"
                }
                else {
                    currentSelectedTimelabel.text = "0\(hours):\(minutes) AM"
                }
            }
            else {
                if minutes < 10 {
                    currentSelectedTimelabel.text = "\(hours):0\(minutes) AM"
                }
                else {
                    currentSelectedTimelabel.text = "\(hours):\(minutes) AM"
                }
            }
        }
        else {
            hours = Int(currentHour24-12)
            if hours == 0{
                if minutes < 10 {
                    currentSelectedTimelabel.text = "12:0\(minutes) PM"
                }
                else {
                    currentSelectedTimelabel.text = "12:\(minutes) PM"
                }
            }
            else if hours < 10 {
                if minutes < 10 {
                    currentSelectedTimelabel.text = "0\(hours):0\(minutes) PM"
                }
                else {
                    currentSelectedTimelabel.text = "0\(hours):\(minutes) PM"
                }
            }
            else {
                if minutes < 10 {
                    currentSelectedTimelabel.text = "\(hours):0\(minutes) PM"
                }
                else {
                    currentSelectedTimelabel.text = "\(hours):\(minutes) PM"
                }
            }
        }
      
    }
    
    func setCurrentTimeDuringSwipe(currentTime: CGFloat){
        currentHour24 = round(currentTime)
        currentMinute = round(currentTime)*60
        if currentTime <= 12 {
            var ct = Int(round(currentTime))
            if ct == 0 {
                currentSelectedTimelabel.text = "12:00 AM"
            }
            else if ct == 12 {
                currentSelectedTimelabel.text = "12:00 PM"
            }
            else {
                if ct < 10 {
                    currentSelectedTimelabel.text = "0\(ct):00 AM"
                }
                else {
                    currentSelectedTimelabel.text = "\(ct):00 AM"
                }
            }
        }
        else {
            var ct = Int(round(currentTime-12))
            if ct == 12 {
                currentSelectedTimelabel.text = "12:00 AM"
            }
            else {
                if ct < 10 {
                    currentSelectedTimelabel.text = "0\(ct):00 PM"
                }
                else {
                    currentSelectedTimelabel.text = "\(ct):00 PM"
                }
            }
        }
    }
    
    func setAnimatedEffectOfIncreasingSelectedTime(labelNum: Int, increment: CGFloat){
        switch labelNum {
        case 1:
            TimeHourLabel1.font = TimeHourLabel1.font.fontWithSize(TimeHourLabel1.font.pointSize + increment)
            break
        case 2:
            TimeHourLabel2.font = TimeHourLabel2.font.fontWithSize(TimeHourLabel2.font.pointSize + increment)
            break
        case 3:
            TimeHourLabel3.font = TimeHourLabel3.font.fontWithSize(TimeHourLabel3.font.pointSize + increment)
            break
        case 4:
            TimeHourLabel4.font = TimeHourLabel4.font.fontWithSize(TimeHourLabel4.font.pointSize + increment)
            break
        case 5:
            TimeHourLabel5.font = TimeHourLabel5.font.fontWithSize(TimeHourLabel5.font.pointSize + increment)
            break
        case 6:
            TimeHourLabel6.font = TimeHourLabel6.font.fontWithSize(TimeHourLabel6.font.pointSize + increment)
            break
        case 7:
            TimeHourLabel7.font = TimeHourLabel7.font.fontWithSize(TimeHourLabel7.font.pointSize + increment)
            break
        case 8:
            TimeHourLabel8.font = TimeHourLabel8.font.fontWithSize(TimeHourLabel8.font.pointSize + increment)
            break
        case 9:
            TimeHourLabel9.font = TimeHourLabel9.font.fontWithSize(TimeHourLabel9.font.pointSize + increment)
            break
        case 10:
            TimeHourLabel10.font = TimeHourLabel10.font.fontWithSize(TimeHourLabel10.font.pointSize + increment)
            break
        case 11:
            TimeHourLabel11.font = TimeHourLabel11.font.fontWithSize(TimeHourLabel11.font.pointSize + increment)
            break
        case 12:
            TimeHourLabel12.font = TimeHourLabel12.font.fontWithSize(TimeHourLabel12.font.pointSize + increment)
            break
        case 13:
            TimeHourLabel13.font = TimeHourLabel13.font.fontWithSize(TimeHourLabel13.font.pointSize + increment)
            break
        default:
            break
        }

    }
    
    func draggedView(recognizer:UIPanGestureRecognizer){
        if !swipeMode {
            return
        }
        allowConfirm = true
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            if (view.center.y-(view.bounds.height/2)) + translation.y > 0
            && (view.center.y+(view.bounds.height/2)) + translation.y < self.view.bounds.height {
                if recognizer.state == UIGestureRecognizerState.Ended {
                    var height:CGFloat = view.center.y + translation.y
                    var modifiedHeight:CGFloat
                    var currentHeight:CGFloat = 0
                    if (height - startingPostition) % stepBetweenEachPosition < (stepBetweenEachPosition/2) {
                        modifiedHeight = height - ((height - startingPostition) % stepBetweenEachPosition)
                    }
                    else {
                        modifiedHeight = height + (stepBetweenEachPosition - ((height - startingPostition) % stepBetweenEachPosition))
                    }
                    if modifiedHeight >= self.view.bounds.height {
                        currentHeight = self.view.bounds.height - (swipeView.bounds.height/2)
                    }
                    else if modifiedHeight <= 0 {
                        currentHeight = swipeView.bounds.height/2
                    }
                    else {
                        currentHeight = modifiedHeight
                    }
                    topSpaceConstraintForSwipeView.constant = (currentHeight - swipeView.bounds.height/2)
                    swipeIconImageView.image = UIImage(named: "Confirm Icon")
                    var currentTime = CGFloat((modifiedHeight - startingPostition) / stepBetweenEachPosition)
                    setCurrentTimeDuringSwipe(currentTime)
                    var convertedTime: Int = Int(round(currentHour24))
                    if convertedTime % 2 == 0  {
                            setAnimatedEffectOfIncreasingSelectedTime((convertedTime/2)+1, increment: 10.0)
                    }
                    if prevAnimatedTimerLine > 0 && prevAnimatedTimerLine <= 13  {
                        setAnimatedEffectOfIncreasingSelectedTime(prevAnimatedTimerLine, increment: -10.0)
                    }
                    if convertedTime % 2 == 0 {
                        prevAnimatedTimerLine = (convertedTime/2)+1
                    }
                    else {
                        prevAnimatedTimerLine = -1
                    }
                }
                else {
                    var height:CGFloat = view.center.y + translation.y
                    var modifiedHeight:CGFloat
                    var currentHeight:CGFloat = 0
                    if (height - startingPostition) % stepBetweenEachPosition < (stepBetweenEachPosition/2) {
                        modifiedHeight = height - ((height - startingPostition) % stepBetweenEachPosition)
                    }
                    else {
                        modifiedHeight = height + (stepBetweenEachPosition - ((height - startingPostition) % stepBetweenEachPosition))
                    }
                    currentHeight = height
                    topSpaceConstraintForSwipeView.constant = (currentHeight - swipeView.bounds.height/2)
                    var currentTime = CGFloat((modifiedHeight - startingPostition) / stepBetweenEachPosition)
                    swipeIconImageView.image = UIImage(named: "Swipe Alarm Icon")
                    setCurrentTimeDuringSwipe(currentTime)
                }
            }
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }

    func deleteAlarmLabel(context: NSManagedObjectContext){
        println(returnedFromSettingsPageDeletedAlarmID)
        let requestToDelete = NSFetchRequest(entityName: "Alarms")
        requestToDelete.returnsObjectsAsFaults = false
        var objectToDelete: NSArray = context.executeFetchRequest(requestToDelete, error: nil)!
        //delete object
        if objectToDelete.count > 0 {
            println("number object to delete \(objectToDelete.count)")
            for alarm in objectToDelete {
                var thisAlarm = alarm as! Alarms
                if thisAlarm.alarmNumber == returnedFromSettingsPageDeletedAlarmID {
                    println("deleted alarm \(thisAlarm.alarmNumber)")
                    context.deleteObject(thisAlarm)
                    var currHeight = NSUserDefaults.standardUserDefaults().floatForKey("CurrentScrollViewHeight")
                    currHeight = currHeight - thisAlarm.mainHeight - Float((2*Spacing))
                    NSUserDefaults.standardUserDefaults().setFloat(Float(currHeight), forKey: "CurrentScrollViewHeight")
                    var currAlarmNumber = NSUserDefaults.standardUserDefaults().objectForKey("AlarmNumber") as! Int
                    currAlarmNumber--
                    NSUserDefaults.standardUserDefaults().setObject(currAlarmNumber, forKey: "AlarmNumber")
                    context.save(nil)
                }
                if thisAlarm.alarmNumber > returnedFromSettingsPageDeletedAlarmID {
                    thisAlarm.alarmNumber = thisAlarm.alarmNumber - 1
                    thisAlarm.centerPositionY = thisAlarm.centerPositionY - thisAlarm.mainHeight - Float(2*Spacing)
                    println("new center position: \(thisAlarm.centerPositionY)")
                    context.save(nil)
                }
                //println(thisAlarm)
            }
        }
        //shift objects back and update alarm number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlarmPage()
        setupTimerHourLines()
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        if returnedFromSettingsPageDeletedAlarm == true {
            println("deletedALarm")
            deleteAlarmLabel(context)
        }
        let request = NSFetchRequest(entityName: "Alarms")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        if results.count > 0 {
            //println(results.count)
            tapForAlarmLabel.text = ""
            for alarm in results {
                var thisAlarm = alarm as! Alarms
                reloadScrollView(Int(thisAlarm.mon), Tues: Int(thisAlarm.tues), Wed: Int(thisAlarm.wed), Thurs: Int(thisAlarm.thurs), Fri: Int(thisAlarm.fri), Sat: Int(thisAlarm.sat), Sun: Int(thisAlarm.sun),
                    time: thisAlarm.alarmTime, AMorPM: thisAlarm.amPMtext, centerY: thisAlarm.centerPositionY, AlarmLabel: thisAlarm.alarmLabel, viewWidth: thisAlarm.mainWidth, viewHeight: thisAlarm.mainHeight, alarmNum: thisAlarm.alarmNumber, alarmTurnOn: Int(thisAlarm.alarmTurnedOn))
            }
        }
        else {
            println("no results found")
            AlarmNumber = 1
            currScrollviewHeight = 30
            NSUserDefaults.standardUserDefaults().setObject(AlarmNumber, forKey: "AlarmNumber")
            NSUserDefaults.standardUserDefaults().setFloat(Float(currScrollviewHeight), forKey: "CurrentScrollViewHeight")
        }
        
        var rightswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        var leftswipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        leftswipe.direction = .Left
        rightswipe.direction = .Right
        view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
        scrollViewForAlarms.addGestureRecognizer(leftswipe)
        scrollViewForAlarms.addGestureRecognizer(rightswipe)
        
        var panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "draggedView:")
        panGesture.maximumNumberOfTouches = 1
        self.swipeView.addGestureRecognizer(panGesture)
        swipeView.userInteractionEnabled = true
        setTimeHourLabels(false)
        startingPostition = view.bounds.height * 1/26
        endingPosition = view.bounds.height * 25/26
        stepBetweenEachPosition =  2/52 * view.bounds.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func handleSwipes(sender: UISwipeGestureRecognizer){
        println(swipeMode)
        if(sender.direction == .Left && !swipeMode){
            println("swipe left")
            self.performSegueWithIdentifier("SwitchToClockFromAlarm", sender: self)
        }
        else if(sender.direction == .Right){
            println("swipe right")
        }
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSettings" {
            let secondVC:ViewControllerSettings = segue.destinationViewController as! ViewControllerSettings
            secondVC.monSet = settingsDataMon
            secondVC.tuesSet = settingsDataTues
            secondVC.wedSet = settingsDataWed
            secondVC.thurSet = settingsDataThurs
            secondVC.friSet = settingsDataFri
            secondVC.satSet = settingsDataSat
            secondVC.sunSet = settingsDataSun
            println(settingsDataAlarmLabel)
            secondVC.alarmName = settingsDataAlarmLabel
            secondVC.alarmTime = settingsDataAlarmTime
            secondVC.alarmPMAM = settingsDataAlarmPMAMLabel
            secondVC.alarmNumber = settingsDataAlarmNumber
        }
        
    }
    var settingsDataAlarmTime: String = ""
    var settingsDataAlarmPMAMLabel: String = ""
    var settingsDataAlarmLabel: String = ""
    var settingsDataMon: Bool = true
    var settingsDataTues: Bool = true
    var settingsDataWed: Bool = true
    var settingsDataThurs: Bool = true
    var settingsDataFri: Bool = true
    var settingsDataSat: Bool = true
    var settingsDataSun: Bool = true
    var settingsDataAlarmNumber: Int64 = 0
    
    func userPressedAlarmLabelGoToSettings(alarmTime: String, alarmPMAMLabel: String, alarmLabel: String,  mon: Bool, tues: Bool, wed: Bool, thurs: Bool, fri: Bool, sat: Bool, sun: Bool, alarmNum: Int64) {
        println(alarmLabel)
       // settingsDataAlarmTime = alarmTime
       // settingsDataAlarmLabel = alarmLabel
        //settingsDataAlarmPMAMLabel = alarmPMAMLabel
        settingsDataMon = mon
        settingsDataTues = tues
        settingsDataWed = wed
        settingsDataThurs = thurs
        settingsDataFri = fri
        settingsDataSat = sat
        settingsDataSun = sun
        settingsDataAlarmNumber = alarmNum
        self.performSegueWithIdentifier("showSettings", sender: self)
    }
    
    func userReturnedFromSettingsPage(mon: Bool, tues: Bool, wed: Bool, thurs: Bool, fri: Bool, sat: Bool, sun: Bool, alarmID: Int64){
        println("returned from settings page")
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Alarms")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        if results.count > 0 {
            for alarm in results {
                var thisAlarm = alarm as! Alarms
                if thisAlarm.alarmNumber == alarmID {
                    println("set following")
                    thisAlarm.mon = Boolean(Int(mon))
                    thisAlarm.tues = Boolean(Int(tues))
                    thisAlarm.wed = Boolean(Int(wed))
                    thisAlarm.thurs = Boolean(Int(thurs))
                    thisAlarm.fri = Boolean(Int(fri))
                    thisAlarm.sat = Boolean(Int(sat))
                    thisAlarm.sun = Boolean(Int(sun))
                    
                    println("\(thisAlarm.mon)")
                    
                    println("\(thisAlarm.tues)")
                    
                    println("\(thisAlarm.wed)")
                    
                    println("\(thisAlarm.thurs)")
                    
                    println("\(thisAlarm.fri)")
                    
                    println("\(thisAlarm.sat)")
                    
                    println("\(thisAlarm.sun)")
                    
                    context.save(nil)
                }
            }
        }

    }
    
    func userPressedAlarmOnOff(turnOn: Int, alarmId: Int64) {
        println("storedTurnOnOff")
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Alarms")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        if results.count > 0 {
            for alarm in results {
                var thisAlarm = alarm as! Alarms
                if thisAlarm.alarmNumber == alarmId {
                    println(Boolean(turnOn))
                    thisAlarm.alarmTurnedOn = Boolean(turnOn)
                    context.save(nil)
                }
            }
        }
        //shift objects back and update alarm number
    }
}
