//
//  PostImageViewController.swift
//  ParseStarterProject
//
//  Created by Akhil Nadendla on 6/22/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityInicator = UIActivityIndicatorView()

    @IBOutlet var imageToPost: UIImageView!
    
    @IBOutlet var message: UITextField!
    
    func displayPopup(title: String, message: String) {
        //create alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageToPost.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func postImage(sender: AnyObject) {
        
        activityInicator = UIActivityIndicatorView(frame: self.view.frame)
        activityInicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityInicator.center = self.view.center
        activityInicator.hidesWhenStopped = true
        activityInicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityInicator)
        activityInicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        //save image, message, etc
        var post = PFObject(className: "Post")
        post["message"] = message.text
        post["userid"] = PFUser.currentUser()?.objectId!
        let imageData = UIImagePNGRepresentation(imageToPost.image)
        let imageFile = PFFile(name: "image.png", data: imageData)
        post["imageFile"] = imageFile
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            self.activityInicator.stopAnimating()
            if error == nil {
                println("Success")
                self.displayPopup("Image Posted!", message: "Your image has been posted successfully")
                self.imageToPost.image = UIImage(named: "default.png")
                self.message.text = ""
            }
            else {
                self.displayPopup("Could not Post Image", message: "Try Again Later")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
