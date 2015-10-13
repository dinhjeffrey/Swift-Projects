//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

//navigation delegate allows you to access other apps

class ViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var topButton: UIButton!
    
    @IBOutlet var bottomButton: UIButton!
    
    @IBOutlet var registeredYetLabel: UILabel!
    
    var signUpActive = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayPopup(title: String, message: String) {
        //create alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func signup(sender: AnyObject) {
        if username.text == "" || password.text == "" {
            //create alert
            displayPopup("Error: Invalid Username or Password", message: "Please enter a valid value")
        }
        else {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            var errorMessage = "Please try again later"
            if signUpActive {
                //set up user
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if error == nil {
                        println("signup successful")
                        self.performSegueWithIdentifier("login", sender: self)
                    }
                    else {
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayPopup("Failed Signup", message: errorMessage)
                    }
                })
            }
            else { //login
                PFUser.logInWithUsernameInBackground(username.text, password: password.text, block: { (user, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        //logged in
                        println("login successful")
                        self.performSegueWithIdentifier("login", sender: self)
                    }
                    else {
                        //display error
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayPopup("Failed Login", message: errorMessage)

                    }
                })
            }
        }
    }
    @IBAction func login(sender: AnyObject) {
        if signUpActive == true {
            //switch to login mode
            signUpActive = false
            topButton.setTitle("Login", forState: UIControlState.Normal)
            registeredYetLabel.text = "Not Registered?"
            bottomButton.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        else {
            //switch to signup mode
            signUpActive = true
            topButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredYetLabel.text = "Already Registered?"
            bottomButton.setTitle("Login", forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

