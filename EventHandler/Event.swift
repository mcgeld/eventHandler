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
    var id : Int
    var title : String
    var description : String
    var date : DateTime
    var duration : Int
    var location : Location
    var privateEvent : Bool
    var maxAttendance : Int
    var minRating : Double
    var daysFromToday : Int
    
    init(_id : Int, _title : String, _description : String, _date : DateTime, _duration : Int, _location : Location, _private : Bool, _maxAttendance : Int, _minRating : Double, _daysFromToday : Int)
    {
        self.id = _id
        self.title = _title
        self.description = _description
        self.date = _date
        self.duration = _duration
        self.location = _location
        self.privateEvent = _private
        self.maxAttendance = _maxAttendance
        self.minRating = _minRating
        self.daysFromToday = _daysFromToday
    }
}