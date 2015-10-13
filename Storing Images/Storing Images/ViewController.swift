//
//  ViewController.swift
//  Storing Images
//
//  Created by Akhil Nadendla on 6/20/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://www.hdwallpapers.in/walls/vista_graphics-normal.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        //aysynch grap of the image
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil {
                println("there was an error")
            }
            else {
                let image = UIImage(data: data)
                //to set image directly
                //self.imageView.image = image
                
                //lets save the image instead and after the first time you wont need to download it anymore
                var documentsDirectory:String?
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,  true)
                if paths.count > 0 {
                    documentsDirectory = paths[0] as? String
                    var savePath = documentsDirectory! + "/bach.jpg"
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    self.imageView.image = UIImage(named: savePath)
                }
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

