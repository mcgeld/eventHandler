//
//  profileView.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 5/30/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit

class profileView : UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var defaultLocationLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        firstNameLabel.text = user?.firstName
        lastNameLabel.text = user?.lastName
        userNameLabel.text = user?.username
        phoneNumberLabel.text = String(user!.phoneNumber)
        ratingLabel.text = String(format: "%.2f", user!.rating)
        defaultLocationLabel.text = String(format: "%.2f", user!.defaultLocation.latitude) + "," + String(format: "%.2f", user!.defaultLocation.longitude)
    }
    
    @IBAction func editButtonPressed(sender: UIButton) {
        if(self.editButton.currentTitle == "Edit")
        {
            self.logoutButton.hidden = true;
            self.editButton.setTitle("Update", forState: UIControlState.Normal)
            firstNameTextField.hidden = false;
            lastNameTextField.hidden = false;
            phoneNumberTextField.hidden = false;
            
            firstNameLabel.hidden = true;
            lastNameLabel.hidden = true;
            phoneNumberLabel.hidden = true;
            
            firstNameTextField.text = firstNameLabel.text;
            lastNameTextField.text = lastNameLabel.text;
            phoneNumberTextField.text = phoneNumberLabel.text
        }
        else
        {
            //db.editUser()
            self.logoutButton.hidden = false;
            self.editButton.setTitle("Edit", forState: UIControlState.Normal)
            firstNameTextField.hidden = true;
            lastNameTextField.hidden = true;
            phoneNumberTextField.hidden = true;
            
            firstNameLabel.hidden = false;
            lastNameLabel.hidden = false;
            phoneNumberLabel.hidden = false;
            
            firstNameLabel.text = firstNameTextField.text;
            lastNameLabel.text = lastNameTextField.text;
            phoneNumberLabel.text = phoneNumberTextField.text

        }
    }
    @IBAction func logoutButtonPressed(sender: UIButton) {
        user = nil
        performSegueWithIdentifier("logoutSegue", sender: nil)
    }
}