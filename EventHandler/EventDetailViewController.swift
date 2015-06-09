//
//  EventDetailViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 30/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    var curEvent : Event?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var maxAttLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = curEvent?.title
        descriptionLabel.text = curEvent?.description
        locLabel.text = "House..."
        dateLabel.text = curEvent?.date!.toString()
        maxAttLabel.text = toString(curEvent?.maxAttendance)
        
        timeLabel.text = "This is the time"
        
        println(curEvent?.title)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
