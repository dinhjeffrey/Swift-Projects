//
//  ViewController.swift
//  Weather
//
//  Created by Akhil Nadendla on 6/16/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userCity: UITextField!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var city = userCity.text as String!
        city = city.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + city + "/forecasts/latest")
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                (data, response, error) -> Void in
                
                var urlError = false
                var weather = ""
                
                if error == nil{
                    var urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    //println(urlContent)
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    if urlContentArray.count > 0 {
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        weather = weatherArray[0] as! String
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    }
                    else{
                        urlError = true
                    }
                }
                else {
                    urlError = true
                }
                // the info or error message is displayed immeadiatley instead of after its done with queue
                dispatch_async(dispatch_get_main_queue()){
                    if urlError == true {
                        self.showError()
                    }
                    else {
                        self.resultLabel.text = weather
                    }
                }
            })
            task.resume()
            
        }
        else {
            showError()
        }

    }
    
    @IBOutlet var resultLabel: UILabel!
    
    func showError(){
        resultLabel.text = "Couldn't find weather for " + userCity.text! + ". Please try again."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resultLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //closes keyboard if pressed on screen off keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    //optional func textFieldShouldReturn(textField: UITextField) -> Bool
    // called when 'return' key pressed. return NO to ignore.
    // handles when return is pressed on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //weird way of saying close the keyboard
        textField.resignFirstResponder()
        return true
    }

}

