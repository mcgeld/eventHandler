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
    
    var firstName="";
    var lastName="";
    var userName="";
    
    var pin=1;
    @IBOutlet weak var userNameTextBox: UITextField!
    
    @IBOutlet weak var pinVerifyLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var emailAddressTextBox: UITextField!
    @IBOutlet weak var fieldsEmpty: UILabel!
    var emptyField=false;
    
    @IBOutlet weak var createUserAfterPinOutlet: UIButton!
    @IBOutlet weak var pinVerifyTextBox: UITextField!
    
    @IBOutlet weak var passwordCheckTextBox: UITextField!
    @IBOutlet weak var verifyButtonOutlet: UIButton!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    @IBOutlet weak var lastNameOutlet: UITextField!
    
    override func viewDidLoad() {
        fieldsEmpty.hidden=true;
        emptyField=false;
        nameTextBox.delegate=self;
        emailAddressTextBox.delegate=self
        userNameTextBox.delegate=self
        passwordCheckTextBox.hidden=true;
        pinVerifyTextBox.hidden=true;
        passwordTextBox.hidden=true;
        createUserAfterPinOutlet.hidden=true;
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        pinVerifyLabel.hidden=true;
        
    }
    

    
    @IBAction func createUserButtonPressed(sender: AnyObject)
    {
        if(nameTextBox.text != ""&&emailAddressTextBox.text != ""&&userNameTextBox.text != "")
        {
       
            pin = Int(arc4random_uniform(999));
            pin = pin+1000;
        
            
            db.sendCreationPinEmail(emailAddressTextBox.text, pinNum: pin)
            
            pinVerifyLabel.hidden=false;
            verifyButtonOutlet.hidden=true;
            emailAddressTextBox.hidden=true;
            nameTextBox.hidden=true;
            userNameTextBox.hidden=true;
            passwordCheckTextBox.hidden=false;
            pinVerifyTextBox.hidden=false;
            passwordTextBox.hidden=false;
            createUserAfterPinOutlet.hidden=false;
            
            println("pin: ");
            println(pin);
            
        }
        else
        {
            fieldsEmpty.hidden=false;
        }
    }

    @IBAction func createUserAfterPinPressed(sender: AnyObject)
    {
        var pinBox=pinVerifyTextBox.text;
        var pass1=passwordTextBox.text;
        var pass2=passwordCheckTextBox.text;
        
        if(pinBox.toInt() == pin)
        {
            println("success");
            
            
        }
        else
        {
          //wrong pin
            
        }
        
        if(pass1==pass2)
        {
            println("correct passwords");
           
           user=db.createUser(userName, _password: passwordTextBox.text, _email: emailAddressTextBox.text, _firstName:firstName, _lastName: lastName);
            performSegueWithIdentifier("newUserLogin", sender: nil)
            
        
        }
        else
        {
            println("passwords don't match");
        }
        
        
    }
    @IBAction func userTextBoxDoneEditing(sender: AnyObject) {
        var text=userNameTextBox.text;
      
            userName=userNameTextBox.text
   
    }
  
    @IBAction func lastNameDoneEditing(sender: AnyObject) {
        lastName=lastNameOutlet.text;
        
    }
    @IBAction func nameTextBoxDoneEditing(sender: AnyObject) {
        var text=userNameTextBox.text;
        firstName=text;
       
                
          
     
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