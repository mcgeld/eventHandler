//
//  Map.swift
//  EventHandler
//
//  Created by Wade Wilkey on 7/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation


class Map
{
    var events : [Event]?
    var range : Int
    
    init(r: Int)
    {
        self.range = r
    }
    
    
    
    func addEvent(e: Event)
    {
        self.events!.append(e)
    }
    
}