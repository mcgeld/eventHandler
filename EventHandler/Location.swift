//
//  Location.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class Location
{
    var latitude : Double
    {
        get
        {
            return self.latitude
        }
        set(lat)
        {
            self.latitude = lat
        }
    }
    
    var longitude : Double
    {
        get
        {
            return self.longitude
        }
        set(lon)
        {
            self.longitude = lon
        }
    }
    
    init(lat : Double, lon : Double)
    {
        self.latitude = lat;
        self.longitude = lon;
    }

}