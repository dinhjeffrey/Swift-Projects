//
//  ViewControllerSettings.swift
//  clock
//
//  Created by Akhil Nadendla on 7/14/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerSettings: UIViewController, UITextFieldDelegate {

    @IBOutlet var etaLabel: UILabel!
    @IBOutlet var AlarmLabelTextField: UITextField!

    @IBOutlet var AlarmVolume: UIButton!
    @IBOutlet var SnoozeAmount: UIButton!
    @IBOutlet var DefaultRingtone: UIButton!
    @IBOutlet var Challenge: UIButton!
    
    @IBOutlet var sundayBG: UIImageView!
    @IBOutlet var mondayBG: UIImageView!
    @IBOutlet var tuesdayBG: UIImageView!
    @IBOutlet var wednesdayBG: UIImageView!
    @IBOutlet var thurdayBG: UIImageView!
    @IBOutlet var fridayBG: UIImageView!
    @IBOutlet var saturdayBG: UIImageView!
    
    @IBOutlet var sundayText: UIButton!
    @IBOutlet var mondayText: UIButton!
    @IBOutlet var tuesdayText: UIButton!
    @IBOutlet var wednesdayText: UIButton!
    @IBOutlet var thursdayText: UIButton!
    @IBOutlet var fridayText: UIButton!
    @IBOutlet var saturdayText: UIButton!
    @IBOutlet var MainViewBackground: UIView!
    @IBOutlet var testlabel: UITextField!
    
    var monSet: Bool = true
    var tuesSet: Bool = true
    var wedSet: Bool = true
    var thurSet: Bool = true
    var friSet: Bool = true
    var satSet: Bool = true
    var sunSet: Bool = true
    
    var alarmName: String = ""
    var alarmTime:String = ""
    var alarmPMAM: String  = ""
    var alarmNumber: Int64 = 0
    
    var lightColor: UIColor = UIColor(red: 70/256, green: 165/256, blue: 220/256, alpha: 1)
    var mediumColor: UIColor = UIColor(red: 246/256, green: 179/256, blue: 0/256, alpha: 1)
    var darkColor: UIColor = UIColor(red: 3/256, green: 101/256, blue: 156/256, alpha: 1)
    var whiteColor: UIColor = UIColor.whiteColor()
    
    @IBOutlet var deleteAlarmPressed: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "deleteAlarm" {
            let secondVC:ViewControllerAlarm = segue.destinationViewController as! ViewControllerAlarm
            secondVC.returnedFromSettingsPageDeletedAlarm = true
            secondVC.returnedFromSettingsPageDeletedAlarmID = alarmNumber
        }
        else {
            let secondVC:ViewControllerAlarm = segue.destinationViewController as! ViewControllerAlarm
            secondVC.userReturnedFromSettingsPage(monSet, tues: tuesSet, wed: wedSet, thurs: thurSet, fri: friSet, sat: satSet, sun: sunSet, alarmID: alarmNumber)
        }
    }
    
    
    @IBAction func deleteAlarmButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("deleteAlarm", sender: self)
    }
    
    @IBAction func ExitButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("exitAlarm", sender: self)

    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupButtonTextWidths(){
        //set up button text
        DefaultRingtone.titleLabel?.numberOfLines = 1
        DefaultRingtone.titleLabel?.minimumScaleFactor =  1 / DefaultRingtone.titleLabel!.font.pointSize
        DefaultRingtone.titleLabel?.adjustsFontSizeToFitWidth = true
        
        AlarmVolume.titleLabel?.numberOfLines = 1
        AlarmVolume.titleLabel?.minimumScaleFactor =  1 / AlarmVolume.titleLabel!.font.pointSize
        AlarmVolume.titleLabel?.adjustsFontSizeToFitWidth = true
        
        SnoozeAmount.titleLabel?.numberOfLines = 1
        SnoozeAmount.titleLabel?.minimumScaleFactor =  1 / SnoozeAmount.titleLabel!.font.pointSize
        SnoozeAmount.titleLabel?.adjustsFontSizeToFitWidth = true
        
        Challenge.titleLabel?.numberOfLines = 1
        Challenge.titleLabel?.minimumScaleFactor =  1 / Challenge.titleLabel!.font.pointSize
        Challenge.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       /* alarmTimeLabel.minimumFontSize = 1 / alarmTimeLabel.font.pointSize
        alarmTimeLabel.adjustsFontSizeToFitWidth = true
        AlarmTimeAmorPMLabel.numberOfLines = 1
        AlarmTimeAmorPMLabel.minimumScaleFactor = 1/AlarmTimeAmorPMLabel.font.pointSize
        AlarmTimeAmorPMLabel.adjustsFontSizeToFitWidth = true
        */
        setupButtonTextWidths()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Alarms")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
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
        }
        setupDays()
      /*alarmTimeLabel.text = alarmTime
        AlarmTimeAmorPMLabel.text = alarmPMAM */
        AlarmLabelTextField.text = alarmName
        MainViewBackground.backgroundColor = darkColor
        println("this is alarm with id \(alarmNumber)")
        
        etaLabel.numberOfLines = 1
        etaLabel.minimumScaleFactor = 1 / etaLabel.font.pointSize
        etaLabel.adjustsFontSizeToFitWidth = true
        // set label Attribute
        var myString:NSString = "0d04h21m19s"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: etaLabel.font.pointSize)!])
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: etaLabel.font.pointSize-4)!, range: NSRange(location: 1, length: 1))
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: etaLabel.font.pointSize-4)!, range: NSRange(location: 4, length: 1))
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: etaLabel.font.pointSize-4)!, range: NSRange(location: 7, length: 1))
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: etaLabel.font.pointSize-4)!, range: NSRange(location: 10, length: 1))
        etaLabel.attributedText = myMutableString
        
        // set label Attribute
        var mystr:NSString = "12:00PM"
        var mutableStr =  NSMutableAttributedString(string: mystr as String, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: testlabel.font.pointSize)!])
        mutableStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: testlabel.font.pointSize - 8)!, range: NSRange(location: 5, length: 2))
        mutableStr.addAttribute(NSBaselineOffsetAttributeName, value: testlabel.font.pointSize/3.5, range: NSRange(location: 5, length: 2))
        testlabel.attributedText = mutableStr
        
        //set this up so you can return from keyboard
        AlarmLabelTextField.delegate = self
        
    }
    //deal with keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    //restrict max characters allowed in Label
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        return newLength <= 12 // Bool
    }

    
    func setupDays() {
        let origImageSun = UIImage(named: "Day Sat Sun Icon Large")
        let tintedImageSun = origImageSun?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        sundayText.setImage(tintedImageSun, forState: .Normal)
        
        let origImageMon = UIImage(named: "Day Mon Icon Large")
        let tintedImageMon = origImageMon?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        mondayText.setImage(tintedImageMon, forState: .Normal)
        
        let origImageTues = UIImage(named: "Day Tues Thurs Icon Large")
        let tintedImageTues = origImageTues?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tuesdayText.setImage(tintedImageTues, forState: .Normal)

        let origImageWed = UIImage(named: "Day Wed Icon Large")
        let tintedImageWed = origImageWed?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        wednesdayText.setImage(tintedImageWed, forState: .Normal)
        
        let origImageThurs = UIImage(named: "Day Tues Thurs Icon Large")
        let tintedImageThurs = origImageThurs?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        thursdayText.setImage(tintedImageThurs, forState: .Normal)
        
        let origImageFri = UIImage(named: "Day Fri Icon Large")
        let tintedImageFri = origImageFri?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        fridayText.setImage(tintedImageFri, forState: .Normal)
        
        let origImageSat = UIImage(named: "Day Sat Sun Icon Large")
        let tintedImageSat = origImageSat?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        saturdayText.setImage(tintedImageSat, forState: .Normal)

        if sunSet == false {
            sundayBG.image = UIImage()
            sundayText.tintColor = whiteColor
        }
        else {
            sundayBG.image = UIImage(named: "Day BG Icon Large")
            sundayText.tintColor = darkColor
        }
        if monSet == false {
            mondayBG.image = UIImage()
            mondayText.tintColor = whiteColor
        }
        else {
            mondayBG.image = UIImage(named: "Day BG Icon Large")
            mondayText.tintColor = darkColor
        }
        if tuesSet == false {
            tuesdayBG.image = UIImage()
            tuesdayText.tintColor = whiteColor
        }
        else {
            tuesdayBG.image = UIImage(named: "Day BG Icon Large")
            tuesdayText.tintColor = darkColor
        }
        if wedSet == false {
            wednesdayText.tintColor = whiteColor
            wednesdayBG.image = UIImage()
        }
        else {
            wednesdayBG.image = UIImage(named: "Day BG Icon Large")
            wednesdayText.tintColor = darkColor
        }
        if thurSet == false {
            thurdayBG.image = UIImage()
            thursdayText.tintColor = whiteColor
        }
        else {
            thurdayBG.image = UIImage(named: "Day BG Icon Large")
            thursdayText.tintColor = darkColor
        }
        if friSet == false {
            fridayBG.image = UIImage()
            fridayText.tintColor = whiteColor
        }
        else {
            fridayBG.image = UIImage(named: "Day BG Icon Large")
            fridayText.tintColor = darkColor
        }
        if satSet == false {
            saturdayBG.image = UIImage()
            saturdayText.tintColor = whiteColor
        }
        else {
            saturdayBG.image = UIImage(named: "Day BG Icon Large")
            saturdayText.tintColor = darkColor
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func DayButtonPressed(sender: AnyObject) {
        println(sender.tag)
        switch sender.tag {
        case 0:
            if sunSet == true {
                sunSet = false
                sundayBG.image = UIImage()
                sundayText.tintColor = whiteColor
            }
            else {
                sunSet = true
                sundayBG.image = UIImage(named: "Day BG Icon Large")
                sundayText.tintColor = darkColor
            }
            break
        case 1:
            if monSet == true {
                monSet = false
                mondayBG.image = UIImage()
                mondayText.tintColor = whiteColor
            }
            else {
                monSet = true
                mondayBG.image = UIImage(named: "Day BG Icon Large")
                mondayText.tintColor = darkColor
            }
            break
        case 2:
            if tuesSet == true {
                tuesSet = false
                tuesdayBG.image = UIImage()
                tuesdayText.tintColor = whiteColor
            }
            else {
                tuesSet = true
                tuesdayBG.image = UIImage(named: "Day BG Icon Large")
                tuesdayText.tintColor = darkColor
            }
            break
        case 3:
            if wedSet == true {
                wedSet = false
                wednesdayBG.image = UIImage()
                wednesdayText.tintColor = whiteColor
            }
            else {
                wedSet = true
                wednesdayBG.image = UIImage(named: "Day BG Icon Large")
                wednesdayText.tintColor = darkColor
            }
            break
        case 4:
            if thurSet == true {
                thurSet = false
                thurdayBG.image = UIImage()
                thursdayText.tintColor = whiteColor
            }
            else {
                thurSet = true
                thurdayBG.image = UIImage(named: "Day BG Icon Large")
                thursdayText.tintColor = darkColor
            }
            break
        case 5:
            if friSet == true {
                friSet = false
                fridayBG.image = UIImage()
                fridayText.tintColor = whiteColor
            }
            else {
                friSet = true
                fridayBG.image = UIImage(named: "Day BG Icon Large")
                fridayText.tintColor = darkColor
            }
            break
        case 6:
            if satSet == true {
                satSet = false
                saturdayBG.image = UIImage()
                saturdayText.tintColor = whiteColor
            }
            else {
                satSet = true
                saturdayBG.image = UIImage(named: "Day BG Icon Large")
                saturdayText.tintColor = darkColor
            }
            break
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
