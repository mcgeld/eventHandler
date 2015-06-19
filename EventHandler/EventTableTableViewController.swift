//
//  EventTableTableViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 20/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EventTableTableViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UITableViewDataSource {

    
    //var events : [Event]?
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    var locationBarHidden:Bool?
    @IBOutlet var addressBar: UISearchBar!
    
    @IBOutlet var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressBar.delegate=self;
        addressBar.hidden = true;
        addressBar.showsCancelButton=true;
        locationBarHidden=true;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //var location = user!.defaultLocation
        //events = db.getEventsByLocation(user!.id, location: location, range: 50)
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
      
    }
    
    
    override func viewWillAppear(animated: Bool) {
        addressBar.hidden=true;
        locationBarHidden=true;
        //var location = user!.defaultLocation
        //events = db.getEventsByLocation(user!.id, location: location, range: 50)
        self.tableView.reloadData()
      
    }

    @IBAction func locationButtonPressed(sender: AnyObject)
    {
        if(locationBarHidden==true)
        {
            addressBar.hidden=false;
            locationBarHidden=false;
        }
        else
        {
            locationBarHidden=true;
            addressBar.hidden=true;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        println(events.count);
        return events.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let i = indexPath.row
        cell.textLabel!.text = events[indexPath.row].title

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    func updateEvents()
    {
        
        events = db.getEventsByLocation(user!.id, location: globalLocation, range: toMiles(user!.theSpan))!;
        
        self.tableView.reloadData()
    }

    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
            addressBar.text="";
        addressBar.resignFirstResponder();
        locationBarHidden=true;
        addressBar.hidden=true;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressBar.text, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark
            {
                var loc = (MKPlacemark(placemark: placemark)).coordinate;
          
                globalLocation.latitude=loc.latitude;
                globalLocation.longitude=loc.longitude;
              
            }
            else
            {
                println("couldn't find");
                
            }
            self.updateEvents();
        })
        
        
        addressBar.resignFirstResponder();
    }
    func toMiles(span:Double)->Double
    {
        return span*69;
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue"
        {
            let detailViewController = segue.destinationViewController as! EventDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let eventObj = events[indexPath.row]
            detailViewController.curEvent = eventObj
        }
    }
    

}
