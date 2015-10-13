//
//  ViewController.swift
//  testing pan gesture
//
//  Created by Akhil Nadendla on 7/1/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var catImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        catImage.userInteractionEnabled = true
        let longpress = UILongPressGestureRecognizer(target: self, action: "action:")
        view.addGestureRecognizer(longpress)
        let panGesture = UIPanGestureRecognizer(target: self, action: "draggedView:")
        catImage.addGestureRecognizer(panGesture)
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        println("recieved")
    }
    func draggedView(recognizer:UIPanGestureRecognizer){
        println("pan gesture")
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

