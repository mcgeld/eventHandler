//
//  ViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit
import CoreLocation
//var db = Database(_ip: "vientapps.com/eventHandler")
var db = Database(_ip: "192.168.0.29/eventHandler")
var user=db.login("caden311", password: "snow311");



class ViewController: UIViewController {

    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        
        

        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    //Segmented View

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

