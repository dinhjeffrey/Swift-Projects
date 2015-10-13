//
//  TableViewController.swift
//  ParseStarterProject
//
//  Created by Akhil Nadendla on 6/23/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var userArray: [String] = []
    
    var activeRecipient = 0
    
    var timer = NSTimer()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        //upload to Parse
        var imageToSend = PFObject(className: "image")
        imageToSend["photo"] = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 0.1))
        imageToSend["senderUsername"] = PFUser.currentUser()!.username!
        imageToSend["recipientUsername"] = userArray[activeRecipient]
        imageToSend.saveInBackgroundWithBlock({ (bool , error) -> Void in
            if error != nil {
                println(error)
            }
        })
    }
    
    func pickImage(sender: AnyObject){
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFUser.query()
        if let curuser = PFUser.currentUser()?.username! {
            query!.whereKey("username", notEqualTo: curuser)
        }
        else {
            return
        }
        
        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let users = objects {
                for user in users {
                    let uname: String! = user.username
                    self.userArray.append(uname)
                }
            }
            self.tableView.reloadData()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("checkForMessage"), userInfo: nil, repeats: true)
    }
    
    func checkForMessage() {
        println("chekcing")
        
        var query = PFQuery(className: "image")
        query.whereKey("recipientUsername", equalTo: PFUser.currentUser()!.username!)
        var images = query.findObjects()
        var done = false
        for image in images! {
            if done == false {
                //download the image
                var imageView:PFImageView  = PFImageView()
                imageView.file = image["photo"] as! PFFile
                imageView.loadInBackground({ (photo, error) -> Void in
                    if error == nil {
                        var displayedImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                        displayedImage.image = photo
                        displayedImage.tag = 3
                        displayedImage.contentMode = UIViewContentMode.ScaleAspectFill
                        self.view.addSubview(displayedImage)
                        /* to add a black bg under the image
                        var bview = UIImage(frame: CG....)
                        bview.backgroundColor = UIColor.blackColor()
                        bview.alpha = .5
                        self.view.addSubview*/
                        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("hideMessage"), userInfo: nil, repeats: false)
                    }
                })
                done = true
            }
        }
        
    }
    
    func hideMessage() {
        for subview in self.view.subviews {
            if subview.tag == 3 {
                subview.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = userArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeRecipient = indexPath.row
        pickImage(self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logout" {
            PFUser.logOut()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
