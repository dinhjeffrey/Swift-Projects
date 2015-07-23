//
//  ViewControllerTest.swift
//  clock
//
//  Created by Akhil Nadendla on 6/30/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit


class ViewControllerTest: UIViewController {
    
    //@IBOutlet var containerView: AlarmViewCustom!
    @IBOutlet var testlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        var customView = AlarmViewCustom(frame: CGRectMake(10, 60, 301, 107))
        customView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        customView.backgroundColor = UIColor.brownColor()
        customView.layer.cornerRadius = 0
        println(customView.MainViewWidth.constant)
        customView.MainViewWidth.constant = self.view.bounds.width * 0.6
        println(customView.MainViewWidth.constant)
        customView.MainViewHeight.constant = (customView.MainViewWidth.constant * 107) / 301
        customView.AlarmNameLabel.numberOfLines = 1
        customView.AlarmNameLabel.minimumScaleFactor = 1/customView.AlarmNameLabel.font.pointSize
        customView.AlarmNameLabel.adjustsFontSizeToFitWidth = true
        customView.AlarmTimeLabel.numberOfLines = 1
        customView.AlarmTimeLabel.minimumScaleFactor = 1/customView.AlarmTimeLabel.font.pointSize
        customView.AlarmTimeLabel.adjustsFontSizeToFitWidth = true
        customView.AlarmTimePMAMLabel.numberOfLines = 1
        customView.AlarmTimePMAMLabel.minimumScaleFactor = 1/customView.AlarmTimeLabel.font.pointSize
        customView.AlarmTimePMAMLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(customView)*/
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
