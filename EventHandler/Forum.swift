//
//  Forum.swift
//  EventHandler
//
//  Created by Wade Wilkey on 8/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class Forum
{
    var comments : [Comment]?
    
    
    func addComment(c: Comment)
    {
        comments!.append(c)
    }
    
    
}
