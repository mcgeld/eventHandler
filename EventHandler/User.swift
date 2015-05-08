//
//  User.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class User
{
    var name : String
    var username : String
    var phoneNumber : Int
    var rating : Double
    var defaultLocation : Location
    var createdEvents : [Event]
    var invitedEvents : [Event]
    

    
    init(name : String, username : String, phone : Int, loc : Location)
    {
        self.name = name
        self.username = username
        self.phoneNumber = phone
        self.defaultLocation = loc
        self.rating = 100
        self.createdEvents = [Event]()
        self.invitedEvents = [Event]()
    }
    

}