//
//  mainTabView.swift
//  EventHandler
//
//  Created by Brittny Wright on 5/30/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

var globalLocation = Location(lat: 0.0, lon: 0.0)

class mainTabView: UITabBarController, CLLocationManagerDelegate {

     var manager:CLLocationManager!
    
    
    override func viewDidLoad() {
        
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        
        
        var lon = manager.location.coordinate.longitude
        var lat = manager.location.coordinate.latitude
        globalLocation.longitude = lon
        globalLocation.latitude = lat
        
        
        
        
        manager.stopUpdatingLocation()
        
        super.viewDidLoad()
 
        
        
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}