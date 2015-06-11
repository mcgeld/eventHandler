//
//  createEventDateView.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/6/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit

class createEventDateView: UIViewController {

    var event : Event?
    //var dpMode1 : UIDatePickerModeTime
    
    @IBOutlet weak var datePicker: UIDatePicker!
   
    @IBOutlet weak var durationTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        let date = datePicker.date
        
        var formatter = NSDateFormatter()
        
        formatter.dateFormat = "YYYY':'MM':'dd':'HH':'mm'"
        
        let strDate = formatter.stringFromDate(date)
        println(strDate)
        let dateTime = DateTime(dateTimeString: strDate)
        println(dateTime.toString())
        let duration = durationTF.text.toInt()
        
       
        
        event!.duration = duration
        event!.date = dateTime
        
        self.performSegueWithIdentifier("eventLocationSegue", sender: event)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "eventLocationSegue"
        {
            let vc = segue.destinationViewController as! createEventLocationView
            vc.event = event
        }
    }
    

}
