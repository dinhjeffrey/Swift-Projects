//
//  NoAnimationSegue.swift
//  clock
//
//  Created by Akhil Nadendla on 6/29/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class NoAnimationSegue: UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.presentViewController(
            self.destinationViewController as! UIViewController,
            animated: false,
            completion: nil)
    }
}
