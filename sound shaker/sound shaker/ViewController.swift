//
//  ViewController.swift
//  sound shaker
//
//  Created by Akhil Nadendla on 6/20/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioFiles = ["pew", "pig", "snore", "static", "uuu", "bean", "belch", "giggle"]
    var counter = 0
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            println("user shook the phone")
            
            var audioPath = NSBundle.mainBundle().pathForResource(audioFiles[counter], ofType: "mp3")!
            
            var error : NSError? = nil
            
            player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath), error: &error)
            if error == nil {
                player.play()
            }
            else {
                println(error)
            }

            var temp = counter + 1
            counter = temp % audioFiles.count
        }
    }


}

