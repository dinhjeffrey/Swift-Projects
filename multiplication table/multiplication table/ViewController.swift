//
//  ViewController.swift
//  multiplication table
//
//  Created by Akhil Nadendla on 5/21/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var numberRows = 20

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    @IBAction func sliderMoved(sender: AnyObject) {
        table.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return numberRows
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let timesTable = Int(sliderValue.value * 20) // will give us a number form 0 to 20
        cell.textLabel?.text = String(timesTable * (indexPath.row + 1))
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

