//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet var username: UITextField!
    
    func signupUser() {
        var user = PFUser()
        user.username = username.text
        user.password = "mypass"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                println("failed signup")
            } else {
                // Hooray! Let them use the app now.
                println("signed UP")
                self.performSegueWithIdentifier("showUsers", sender: self)
            }
        }
    }
    
    @IBAction func signin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text, password:"mypass") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("logged in")
                self.performSegueWithIdentifier("showUsers", sender: self)
            } else {
                // The login failed. So signup the user
                self.signupUser()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        /*if PFUser.currentUser() != nil {
            performSegueWithIdentifier("showUsers", sender: self)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

