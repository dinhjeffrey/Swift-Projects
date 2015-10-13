//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Akhil Nadendla on 6/20/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* to load a website
        var url = NSURL(string: "http://www.google.com")
        var request = NSURLRequest(URL: url!)
        webview.loadRequest(request)
*/
        
        var html = "<html><head></head><body><h1>Hello World!</h1></body></html>"
        webview.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

