//
//  loginView.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 5/29/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit
import Foundation

class loginView: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var createNewUser: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        loginButtonPressed(loginButton)
        return true
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        let tempUser = db.login(usernameTextField.text, password: passwordTextField.text)
        if(tempUser == nil)
        {
            self.errorLabel.hidden = false;
            if(db.dbErr == 1)
            {
                self.errorLabel.text = "Login credentials incorrect"
            }
            else
            {
                self.errorLabel.text = "There has been a connection error. Please contact your system administrator or try again later."
            }
            self.errorLabel.textColor = UIColor.redColor()
        }
        else
        {
            user = tempUser
            performSegueWithIdentifier("loginSegue", sender: nil)
        }
    }
    @IBAction func createNewUserPressed(sender: AnyObject)
    {
        
        performSegueWithIdentifier("createUserSegue", sender: nil)
        
    }
}
