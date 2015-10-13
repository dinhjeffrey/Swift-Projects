//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Akhil Nadendla on 6/16/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //first define url by converting string to url type
        let url = NSURL(string: "http://www.stackoverflow.com")
        //kind of opening mini web browser in phone
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)
        {
            (data, response, error) in
            if error == nil {
                var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(urlContent)
                //gets over the asynch nature of this function. And jumps this to main queue
                dispatch_async(dispatch_get_main_queue()){
                    self.webView.loadHTMLString(urlContent! as String, baseURL: nil)
                }
            }
            //else print error message
        }
        //run the task 
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

