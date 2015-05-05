//
//  User.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation


protocol User
{
    var name : String { get set }
    var username : String { get set }
    var phoneNumber : Int { get set }
    var rating : Double { get set }
    var defaultLocation : Location { get set }
    
}