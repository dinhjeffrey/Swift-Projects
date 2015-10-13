//
//  FeedTableViewController.swift
//  ParseStarterProject
//
//  Created by Akhil Nadendla on 6/22/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var messages = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    var users = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFUser.query()
        //create dictionary of userid to username
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let users = objects {
                self.messages.removeAll(keepCapacity: true)
                self.users.removeAll(keepCapacity: true)
                self.imageFiles.removeAll(keepCapacity: true)
                self.usernames.removeAll(keepCapacity: true)
                for object in users {
                    if let user = object as? PFUser {
                        self.users[user.objectId!] = user.username!
                        
                    }
                }
            }
            var getFollowingUsersQuery = PFQuery(className: "followers")
            getFollowingUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            getFollowingUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        var followedUser = object["following"] as! String
                        var query = PFQuery(className: "Post")
                        query.whereKey("userid", equalTo: followedUser)
                        query.findObjectsInBackgroundWithBlock({ (userFollowed, error) -> Void in
                            if let userFollowed = userFollowed {
                                for post in userFollowed {
                                    self.messages.append(post["message"] as! String)
                                    self.imageFiles.append(post["imageFile"] as! PFFile)
                                    self.usernames.append(self.users[post["userid"] as! String]!)
                                    self.tableView.reloadData()
                                }
                            }
                            else {
                                println("error")
                            }
                        })
                    }
                }
                // println(self.users)
                //println(self.messages)
            }
        })
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
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! cell //use new class here
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data , error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                myCell.postedImage.image = downloadedImage
            }
        }
        myCell.username.text = usernames[indexPath.row]
        myCell.message.text = messages[indexPath.row]
        return myCell
    }
}
