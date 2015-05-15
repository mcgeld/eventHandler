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
    var date : NSDate
    var duration : Int
    var location : Location
    var privateEvent : Bool
    var maxAttendance : Int
    var minRating : Double
    
    init(_id : Int, _title : String, _description : String, _date : NSDate, _duration : Int, _location : Location, _private : Bool, _maxAttendance : Int, _minRating : Double)
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
    }
}