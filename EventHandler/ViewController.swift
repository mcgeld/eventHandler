//
//  ViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit
var db = Database(_ip: "vientapps.com/eventHandler")
//var db = Database(_ip: "192.168.0.29")
var user : User? = nil

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    //Segmented View
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBAction func segmentChange(sender: UISegmentedControl)
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            welcomeLabel.text="First Segment Selected";
            self.performSegueWithIdentifier("mapSegue", sender: nil);
        case 1:
            welcomeLabel.text="Second Segment Selecte";
        case 2:
            welcomeLabel.text = "Login Segment Selected";
        default:
            break; 
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

