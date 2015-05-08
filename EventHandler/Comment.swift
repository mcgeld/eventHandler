//
//  Comment.swift
//  EventHandler
//
//  Created by Wade Wilkey on 8/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class Comment
{
    var user : User
    var date : NSDate
    var message : String
    
    init(u: User, d: NSDate, m: String)
    {
        self.user = u
        self.date = d
        self.message = m
    }
}