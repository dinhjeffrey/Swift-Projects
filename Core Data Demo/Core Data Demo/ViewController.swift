//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Akhil Nadendla on 6/20/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        //entity is essentially a table
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! NSManagedObject
        
        newUser.setValue("Rob", forKey: "username")
        newUser.setValue("pass", forKey: "password")
        
        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        
        //to request certain values in the database
        //request.predicate = NSPredicate(format: "username = %g", "Kirsten")
        
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)

        if results?.count > 0 {
        
            for result: AnyObject in results! {
                //if gets rid of the optional printout
                if let pass = result.password! {
                    println(pass)
                    /* TO UPDATE PASSWORDS
                    if user == "kirsten" {
                        result.setValue("pass6", forKey: "password")
                    */
                }
            }
            
            println(results)
        }
        
        /*
            context.deleteObject(result as NSManagedObject)
            to delete objects from database
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

