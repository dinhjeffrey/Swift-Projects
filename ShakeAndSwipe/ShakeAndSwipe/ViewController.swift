//
//  ViewController.swift
//  ShakeAndSwipe
//
//  Created by Akhil Nadendla on 6/20/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeUP = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUP.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUP)
        
    }
    
    func swiped(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right :
                    println("swiped right")
                    break
                case UISwipeGestureRecognizerDirection.Up :
                    println("swiped up")
                    break
                default:
                    break
            }
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            println("user shook the phone")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

