//
//  ViewController.swift
//  autoLayoutTest
//
//  Created by Akhil Nadendla on 5/17/15.
//  Copyright (c) 2015 Andec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func isItPrimeButton(sender: AnyObject) {
        var number = TextField.text.toInt()!
        println(number)

        if number == 0 || number == 1 {
            resultLabel.text = "\(number) is not prime"
        }
        else if number == 2 {
            resultLabel.text = "\(number) is prime"
        }
        else if number > 2{
            resultLabel.text = "\(number) is prime"
            for var index = 2; index < number ; index++ {
                if number % index == 0 {
                    resultLabel.text = "\(number) is not prime"
                    break
                }
            }
        }
        else {
            resultLabel.text = "Invalid Input!"
        }
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

