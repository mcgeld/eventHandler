//
//  Event.swift
//  EventHandler
//
//  Created by Wade Wilkey on 5/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class Event
{
    var location : Location
    var creator : User
    var invitees :[User]
    var description : String
    var date : NSDate
    
    init(loc : Location, creator : User, date: NSDate)
    {
        self.location = loc
        self.creator = creator
        self.invitees = [User]()
        self.description = ""
        self.date = date
    }
    
    
}