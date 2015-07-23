//
//  Alarms.swift
//  clock
//
//  Created by Akhil Nadendla on 7/12/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import CoreData

@objc(Alarms)
class Alarms: NSManagedObject {
   
    @NSManaged var alarmTurnedOn: Boolean
    @NSManaged var fri: Boolean
    @NSManaged var mon: Boolean
    @NSManaged var sat: Boolean
    @NSManaged var tues: Boolean
    @NSManaged var thurs: Boolean
    @NSManaged var wed: Boolean
    @NSManaged var sun: Boolean
    @NSManaged var alarmLabel: String
    @NSManaged var alarmTime: String
    @NSManaged var amPMtext: String
    @NSManaged var centerPositionY: Float
    @NSManaged var mainHeight: Float
    @NSManaged var mainWidth: Float
    @NSManaged var alarmNumber: Int64
}
