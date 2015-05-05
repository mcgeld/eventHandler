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
    var creator : EventCreator
    var description : String
    {
        get
        {
            return self.description
        }
        set(desc)
        {
            self.description = desc
        }
    }
    
    init(loc : Location, creator : EventCreator)
    {
        self.location = loc
        self.creator = creator
        self.description = ""
    }
    
    
}