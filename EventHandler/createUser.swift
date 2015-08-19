//
//  createUser.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 8/18/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit

class createUser:UIViewController, UITextFieldDelegate
{
    
    var tempUser:User?
    @IBOutlet weak var userNameTextBox: UITextField!
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var emailAddressTextBox: UITextField!
    @IBOutlet weak var fieldsEmpty: UILabel!
    var emptyField=false;
    
    override func viewDidLoad() {
        fieldsEmpty.hidden=true;
        emptyField=false;
        nameTextBox.delegate=self;
        emailAddressTextBox.delegate=self
        userNameTextBox.delegate=self
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    

    
    @IBAction func createUserButtonPressed(sender: AnyObject)
    {
        if(nameTextBox.text != ""&&emailAddressTextBox.text != ""&&userNameTextBox.text != "")
        {
            
        }
        else
        {
            fieldsEmpty.hidden=false;
        }
    }

    @IBAction func userTextBoxDoneEditing(sender: AnyObject) {
        var text=userNameTextBox.text;
      
            tempUser?.username=userNameTextBox.text
   
    }
  
    @IBAction func nameTextBoxDoneEditing(sender: AnyObject) {
        var text=userNameTextBox.text;
      
       
            var nameArr=text.componentsSeparatedByString(" ")
            tempUser?.firstName=nameArr[0];
          
            tempUser?.lastName=nameArr[1];
                
          
     
    }
   
    @IBAction func emailAddressTextBoxDoneEditing(sender: AnyObject)
    {
        var text=emailAddressTextBox.text;
  
        
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        //loginButtonPressed(loginButton)
        return true
    }
    
    
    
    
}