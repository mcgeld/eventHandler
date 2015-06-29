//
//  followingView.swift
//  EventHandler
//
//  Created by Brittny Wright on 6/22/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit

class followingView: UITableViewController, UITableViewDataSource, UITableViewDelegate
{
    var friends : [User] = []
    
    override func viewDidLoad()
    {
        friends = db.getFollowing(user!.id)!;
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return friends.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        let i = indexPath.row
        cell.textLabel!.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        
     
        
        return cell
    }
    
 
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
       
        
        let unfollow = UITableViewRowAction(style: .Normal, title: "Unfollow") { action, index in
            println("more button tapped")
        }
        unfollow.backgroundColor = UIColor.lightGrayColor()
        
     
        return [unfollow]
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    
    
}