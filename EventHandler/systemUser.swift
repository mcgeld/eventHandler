//
//  systemUser.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 5/7/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class systemUser {
    var id : Int
    var username : String
    var attendance : Int
    var location : String
    var phone : String
    
    init(_id: String, _username: String, _attendance: String, _location: String, _phone: String)
    {
        id = _id.toInt()!
        username = _username
        attendance = _attendance.toInt()!
        location = _location
        phone = _phone
    }
}