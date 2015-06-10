//
//  CreateEventViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 28/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    
    var newEvent: Event?
    var pinLoc : Location?

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var maxAttendanceTF: UITextField!
    
    @IBOutlet weak var isPublicSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var isPublic = true
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        descriptionTV.layer.borderColor = UIColor.lightGrayColor().CGColor
        descriptionTV.layer.borderWidth = 1
        descriptionTV.layer.cornerRadius = 5
        
        
    
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
    
    @IBAction func nextButton(sender: AnyObject) {
        
        let eventTitle = titleTF.text
        let eventDescription = descriptionTV.text
        let maxAttendance = maxAttendanceTF.text.toInt()!
        var isPublic = isPublicSwitch.enabled
        //let loc = Location(lat: 41, lon: 111)
        
        let userID = user!.id
      
       // newEvent = Event(userID, eventTitle, eventDescription, nil, nil, nil, isPublic, maxAttendance, 0, nil)
        newEvent = Event()
        newEvent!.userID = userID
        
        newEvent!.title = eventTitle
        
        newEvent!.description = eventDescription
        newEvent!.maxAttendance = maxAttendance
        newEvent!.isPublic = isPublic
        
        if pinLoc != nil
        {
            newEvent!.location = Location(lat: pinLoc!.latitude, lon: pinLoc!.longitude)
        }

        
        self.performSegueWithIdentifier("eventDateSegue", sender: newEvent)
        
    }
    


/*
    @IBAction func createEvent(sender: AnyObject) {
        
        
        let eventTitle = titleTF.text
        let eventDescription = descriptionTF.text
        let dateStr = dateTF.text
        let startTime = startTimeTF.text
        let date = DateTime(dateTimeString: dateStr + ":" + startTime)
        let duration = durationTF.text.toInt()!
        let maxAttendance = maxAttendanceTF.text.toInt()!
        let privateEvent = privateSwitch.enabled
        let loc = Location(lat: 41, lon: 111)
        
        let userID = user!.id
        
        db.createEvent(userID, _title: eventTitle, _description: eventDescription, _date: date, _duration: duration, _location: loc, _private: privateEvent, _maxAttendance: maxAttendance, _minRating: 0)
        
        titleTF.text = ""
        descriptionTF.text = ""
        dateTF.text = ""
        startTimeTF.text = ""
        durationTF.text = ""
        maxAttendanceTF.text = ""
    
        
        
        println("Valid event")
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "eventDateSegue"
        {
            let vc = segue.destinationViewController as! createEventDateView
            vc.event = newEvent
        }
        
    }
    

}
