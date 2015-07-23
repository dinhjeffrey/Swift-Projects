//
//  AlarmViewCustom.swift
//  clock
//
//  Created by Akhil Nadendla on 7/10/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

protocol settings {
    func userPressedAlarmLabelGoToSettings(alarmTime: String, alarmPMAMLabel: String, alarmLabel: String,  mon: Bool, tues: Bool, wed: Bool, thurs: Bool, fri: Bool, sat: Bool, sun: Bool, alarmNum: Int64)
    func userPressedAlarmOnOff(turnOn: Int, alarmId: Int64)
}


@IBDesignable class AlarmViewCustom: UIView {
    
    // Our custom view from the XIB file
    var view: UIView!
    
    var delegate: settings? = nil


    @IBOutlet var MainView: UIView!
    
    @IBOutlet var AlarmViewBG: UIImageView!
    
    @IBOutlet var MainViewHeight: NSLayoutConstraint!
    @IBOutlet var MainViewWidth: NSLayoutConstraint!
    @IBOutlet var AlarmTimeLabel: UILabel!
    @IBOutlet var AlarmTimePMAMLabel: UILabel!
    @IBOutlet var AlarmNameLabel: UILabel!
    
    @IBOutlet var SundayText: UIImageView!
    @IBOutlet var MondayText: UIImageView!
    @IBOutlet var TuesdayText: UIImageView!
    @IBOutlet var WednesdayText: UIImageView!
    @IBOutlet var ThursdayText: UIImageView!
    @IBOutlet var FridayText: UIImageView!
    @IBOutlet var SaturdayText: UIImageView!
    
    @IBOutlet var MondayBG: UIImageView!
    @IBOutlet var TuesdayBG: UIImageView!
    @IBOutlet var WednesdayBG: UIImageView!
    @IBOutlet var ThursdayBG: UIImageView!
    @IBOutlet var FridayBG: UIImageView!
    @IBOutlet var SaturdayBG: UIImageView!
    @IBOutlet var SundayBG: UIImageView!
    
    @IBOutlet var AlarmIconImageView: UIImageView!
    
    var turnedOn = true
    
    var monSet: Bool = true
    var tuesSet: Bool = true
    var wedSet: Bool = true
    var thursSet: Bool = true
    var friSet: Bool = true
    var satSet: Bool = true
    var sunSet: Bool = true
    
    var alarmNumber: Int64 = 0
    
    var lightColor: UIColor = UIColor(red: 70/256, green: 165/256, blue: 220/256, alpha: 1)
    var mediumColor: UIColor = UIColor(red: 246/256, green: 179/256, blue: 0/256, alpha: 1)//UIColor(red: 2/256, green: 136/256, blue: 209/256, alpha: 1)
    var darkColor: UIColor = UIColor(red: 3/256, green: 101/256, blue: 156/256, alpha: 1)
    
    @IBAction func goToSettingsPage(sender: AnyObject) {
        if (delegate != nil) {
            delegate!.userPressedAlarmLabelGoToSettings(AlarmTimeLabel.text!, alarmPMAMLabel: AlarmTimePMAMLabel.text!, alarmLabel: AlarmNameLabel.text!, mon: monSet, tues: tuesSet, wed: wedSet, thurs: thursSet, fri: friSet, sat: satSet, sun: sunSet, alarmNum: alarmNumber)
        }
    }
    
    @IBAction func TurnAlarmOnOff(sender: AnyObject) {
        if turnedOn == true {
            turnedOn = false
            AlarmIconImageView.image = UIImage(named: "Alarm Clock Icon")
            if (delegate != nil) {
                delegate!.userPressedAlarmOnOff(0, alarmId: alarmNumber)
            }

        }
        else {
            turnedOn = true
            AlarmIconImageView.image = UIImage(named: "Alarm Clock Icon Active")
            if (delegate != nil) {
                delegate!.userPressedAlarmOnOff(1, alarmId: alarmNumber)
            }
        }
    }
    
    func setAlarmOnOff(On: Int){
        if On == 1 {
            turnedOn = true
            AlarmIconImageView.image = UIImage(named: "Alarm Clock Icon Active")
        }
        else {
            turnedOn = false
            AlarmIconImageView.image = UIImage(named: "Alarm Clock Icon")
        }

    }
    
    func setDaysOfWeek(day: Int, dayOn: Bool){
        switch (day){
        case 0:
            if dayOn {
                SundayText.image = SundayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                SundayText.tintColor = darkColor
                sunSet = true
            }
            else {
                //SundayBG.image = UIImage()
                SundayText.image = SundayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                SundayText.tintColor = UIColor.whiteColor()
                sunSet = false
            }
            break
        case 1:
            if dayOn {
                MondayText.image = MondayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                MondayText.tintColor = darkColor
                monSet = true
            }
            else {
                //MondayBG.image = UIImage()
                MondayText.image = MondayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                MondayText.tintColor = UIColor.whiteColor()
                monSet = false
            }
            break
        case 2:
            if dayOn {
                TuesdayText.image = TuesdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                TuesdayText.tintColor = darkColor
                tuesSet = true
            }
            else {
                //TuesdayBG.image = UIImage()
                TuesdayText.image = TuesdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                TuesdayText.tintColor = UIColor.whiteColor()
                tuesSet = false
            }
            break
        case 3:
            if dayOn {
                WednesdayText.image = WednesdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                WednesdayText.tintColor = darkColor
                wedSet = true
            }
            else {
                //WednesdayBG.image = UIImage()
                WednesdayText.image = WednesdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                WednesdayText.tintColor = UIColor.whiteColor()
                wedSet = false
            }
            break
        case 4:
            if dayOn {
                ThursdayText.image = ThursdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                ThursdayText.tintColor = darkColor
                thursSet = true
            }
            else {
                //ThursdayBG.image = UIImage()
                ThursdayText.image = ThursdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                ThursdayText.tintColor = UIColor.whiteColor()
                thursSet = false
            }
            break
        case 5:
            if dayOn {
                FridayText.image = FridayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                FridayText.tintColor = darkColor
                friSet = true
            }
            else {
                //FridayBG.image = UIImage()
                FridayText.image = FridayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                FridayText.tintColor = UIColor.whiteColor()
                friSet = false
            }
            break
        case 6:
            if dayOn {
                SaturdayText.image = SaturdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                SaturdayText.tintColor = darkColor
                satSet = true
            }
            else {
                //SaturdayBG.image = UIImage()
                SaturdayText.image = SaturdayText.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                SaturdayText.tintColor = UIColor.whiteColor()
                satSet = false
            }
            break
        default:
            break
        }
    }
    
    func setAlarmLabel(label: String){
        AlarmNameLabel.text = label
    }
    
    func setAlarmLabelFontSize(){
        AlarmNameLabel.numberOfLines = 1
        AlarmNameLabel.minimumScaleFactor = 1/AlarmNameLabel.font.pointSize
        AlarmNameLabel.adjustsFontSizeToFitWidth = true
        
        AlarmTimeLabel.numberOfLines = 1
        AlarmTimeLabel.minimumScaleFactor = 1/AlarmTimeLabel.font.pointSize
        AlarmTimeLabel.adjustsFontSizeToFitWidth = true
        
        AlarmTimePMAMLabel.numberOfLines = 1
        AlarmTimePMAMLabel.minimumScaleFactor = 1/AlarmTimeLabel.font.pointSize
        AlarmTimePMAMLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setAlarmTimeLabelString(time: String, AMorPM: String){
        AlarmTimeLabel.text = time
        AlarmTimePMAMLabel.text = AMorPM
    }
    
    func setAlarmTimeLabel(currentHour24: CGFloat, currentMinute:CGFloat) -> String{
        if currentHour24 < 12 || currentHour24 == 24 {
            AlarmTimePMAMLabel.text = "AM"
        }
        else {
            AlarmTimePMAMLabel.text = "PM"
        }
        if currentHour24 == 0 || currentHour24 == 24 || currentHour24 == 12 {
            if currentMinute % 60 < 10 {
                AlarmTimeLabel.text = "12:0\(Int(round(currentMinute%60)))"
            }
            else {
                AlarmTimeLabel.text = "12:\(Int(round(currentMinute%60)))"
            }
        }
        else if currentHour24 < 12 {
            if currentHour24 < 10 {
                if currentMinute % 60 < 10 {
                    AlarmTimeLabel.text = "0\(Int(round(currentHour24))):0\(Int(round(currentMinute%60)))"
                }
                else {
                    AlarmTimeLabel.text = "0\(Int(round(currentHour24))):\(Int(round(currentMinute%60)))"
                }
            }
            else {
                if currentMinute % 60 < 10 {
                    AlarmTimeLabel.text = "\(Int(round(currentHour24))):0\(Int(round(currentMinute%60)))"
                }
                else {
                    AlarmTimeLabel.text = "\(Int(round(currentHour24))):\(Int(round(currentMinute%60)))"
                }
            }
        }
        else {
            if currentHour24-12 < 10 {
                if currentMinute % 60 < 10 {
                    AlarmTimeLabel.text = "0\(Int(round(currentHour24-12))):0\(Int(round(currentMinute%60)))"
                }
                else {
                    AlarmTimeLabel.text = "0\(Int(round(currentHour24-12))):\(Int(round(currentMinute%60)))"
                }
            }
            else {
                if currentMinute % 60 < 10 {
                    AlarmTimeLabel.text = "\(Int(round(currentHour24-12))):0\(Int(round(currentMinute%60)))"
                }
                else {
                    AlarmTimeLabel.text = "\(Int(round(currentHour24-12))):\(Int(round(currentMinute%60)))"
                }
                
            }
        }

        return ""
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
       // MainView!.backgroundColor = lightColor
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
        
        AlarmViewBG.image = AlarmViewBG.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        AlarmViewBG.tintColor = darkColor
    }
    
    required init(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
        AlarmViewBG.image = AlarmViewBG.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        AlarmViewBG.tintColor = darkColor
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "AlarmViewCustom", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
}
