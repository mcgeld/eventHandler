//
//  friendContainerView.swift
//  EventHandler
//
//  Created by Brittny Wright on 6/22/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class friendContainerView: UITableViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
 
    @IBOutlet var searchBar: UISearchBar!
    
   
    var friends : [User] = []
    
    override func viewDidLoad()
    {
       
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Table view data source
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
       
        self.tableView.reloadData()
    }
    
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
    


  

    
}