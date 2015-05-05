//
//  EventCreator.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class EventCreator : User
{
    var name : String
    var username : String
    var phoneNumber : Int
    var rating : Double
    var defaultLocation : Location
    
    init(name : String, un : String, phone : Int, loc : Location)
    {
        self.name = name
        self.username = un
        self.phoneNumber = phone
        self.defaultLocation = loc
        self.rating = 100
    }
}