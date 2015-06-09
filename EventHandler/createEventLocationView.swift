//
//  createEventLocationView.swift
//  EventHandler
//
//  Created by Wade Wilkey on 7/6/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit

class createEventLocationView: UIViewController {

    var event: Event?
    var state : Bool?
    
    @IBOutlet weak var useCurLocation: UISwitch!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    
    
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        state = true
        
        addressTF.hidden = true
        cityTF.hidden = true
        stateTF.hidden = true
        zipTF.hidden = true
        
        addrLabel.hidden = true
        cityLabel.hidden = true
        stateLabel.hidden = true
        zipLabel.hidden = true
        
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSwitchState(sender: AnyObject) {
        if(state == true)
        {
            state = false
            
            addressTF.hidden = false
            cityTF.hidden = false
            stateTF.hidden = false
            zipTF.hidden = false
            
            addrLabel.hidden = false
            cityLabel.hidden = false
            stateLabel.hidden = false
            zipLabel.hidden = false
            
        }
        else
        {
            
            state = true
            
            addressTF.hidden = true
            cityTF.hidden = true
            stateTF.hidden = true
            zipTF.hidden = true
            
            addrLabel.hidden = true
            cityLabel.hidden = true
            stateLabel.hidden = true
            zipLabel.hidden = true
        }
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        
        
        if(useCurLocation.enabled == true)
        {
            event!.location = Location(lat: globalLocation.latitude, lon: globalLocation.longitude)
            //event!.location?.latitude = globalLocation.latitude
            //event!.location?.longitude = globalLocation.longitude
           // println(globalLocation.latitude)
            //println(globalLocation.longitude)
        }
        else
        {
            //I'll take this out when I get the address stuff working
            event!.location?.latitude = globalLocation.latitude
            event!.location?.longitude = globalLocation.longitude
            //Get event by address....Coming soon.
        }
        
        var id = event!.userID!
        var title = event!.title!
        var desc = event!.description!
        var date = event!.date!
        var duration = event!.duration!
        println(event!.location!.latitude)
        println(event!.location!.longitude)
        var lon = event!.location!
        
        var isPublic = event!.isPublic!
        var maxAtt = event!.maxAttendance!
        
        db.createEvent(event!.userID!, _title: event!.title!, _description: event!.description!, _date: event!.date!, _duration: event!.duration!, _location: event!.location!, _private: event!.isPublic!, _maxAttendance: event!.maxAttendance!, _minRating: 0)
        
        
        
       
        let alertView = UIAlertController(title: "Event", message: "Created Successfully", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.performSegueWithIdentifier("toMapSegue", sender: nil)
        }
        alertView.addAction(OKAction)
        presentViewController(alertView, animated: true, completion: nil)

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
