//
//  FriendView.swift
//  EventHandler
//
//  Created by Brittny Wright on 6/22/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit

class FriendView: UIViewController
{
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var followersContainer: UIView!
    @IBOutlet var followingContainer: UIView!
    @IBOutlet var friendContainer: UIView!
    
    override func viewDidLoad()
    {
        followersContainer.hidden=true;
        followingContainer.hidden=true;
        friendContainer.hidden=false;
        
        super.viewDidLoad();
    }
    
    
    @IBAction func SegmentedControlChange(sender: AnyObject)
    {
        if(segmentedControl.selectedSegmentIndex == 0)
        {
            followersContainer.hidden=false;
            followingContainer.hidden=true;
            friendContainer.hidden=true;
            
        }
        else if(segmentedControl.selectedSegmentIndex == 1)
        {
            followersContainer.hidden=true;
            followingContainer.hidden=true;
            friendContainer.hidden=false;
            
        }
        else
        {
            followersContainer.hidden=true;
            followingContainer.hidden=false;
            friendContainer.hidden=true;
            
        }
        
    }
    
}