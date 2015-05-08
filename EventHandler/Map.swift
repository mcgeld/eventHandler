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
    var range : Double
    
    init(r: Double)
    {
        self.range = r
    }
    
    
    
    func addEvent(e: Event)
    {
        self.events!.append(e)
    }
    
    func updateRange(r: Double)
    {
        self.range = r
    }
    
    
    
}