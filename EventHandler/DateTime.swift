//
//  DateTime.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 5/15/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class DateTime {
    var year : Int
    var month : Int
    var day : Int
    var hour : Int
    var minute : Int
    
    init(dateTimeString : String)
    {
        var dateTimeInfo = split(dateTimeString){$0 == ":"}
        self.year = dateTimeInfo[0].toInt()!
        self.month = dateTimeInfo[1].toInt()!
        self.day = dateTimeInfo[2].toInt()!
        self.hour = dateTimeInfo[3].toInt()!
        self.minute = dateTimeInfo[4].toInt()!
    }
}