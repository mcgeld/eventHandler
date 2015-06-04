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
    var id : Int
    var firstName : String
    var lastName : String
    var username : String
    var phoneNumber : Int
    var rating : Double
    var theSpan:Double //The length in degrees the user wants to display local events
    
    init(_id : Int, _firstName : String, _lastName : String, _username : String, _phoneNumber : Int, _rating : Double)
    {
        self.id = _id
        self.firstName = _firstName
        self.lastName = _lastName
        self.username = _username
        self.phoneNumber = _phoneNumber
        self.rating = _rating
        self.theSpan=0.045
    }
    
    /*func addEvent(e: Event)
    {
        createdEvents.append(e)
    }
    
    func addToInvitedList(e: Event)
    {
        invitedEvents.append(e)
    }*/
}