//
//  ViewController.swift
//  EventHandler
//
//  Created by Wade Wilkey on 4/5/2015.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import UIKit
//"Import" Database stuff
//let db = Database(_ip: "65.130.124.203");
let db = Database(_ip: "192.168.0.29")

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBAction func logInClicked(sender: UIButton) {
        let user = db.login(usernameTextField.text, password: passwordTextField.text);
        if(user != nil)
        {
            welcomeLabel.text = "Welcome, \(user!.username)!"
        }
        else
        {
            if(db.dbErr == 1)
            {
                welcomeLabel.text = "Username or password incorrect. Try again."
            }
            else
            {
                welcomeLabel.text = "There has been a connection error. Please contact your system administrator."
            }
        }
    }
    //Segmented View
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBAction func segmentChange(sender: UISegmentedControl)
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            welcomeLabel.text="First Segment Selected";
            self.performSegueWithIdentifier("mapSegue", sender: nil);
        case 1:
            welcomeLabel.text="Second Segment Selected";
        case 2:
            /* TESTING FOR LOGIN
            passwordLabel.hidden = false;
            passwordTextField.hidden = false;
            usernameLabel.hidden = false;
            usernameTextField.hidden = false;
            loginButton.hidden = false;
            */
            welcomeLabel.text="Second Segment Selected";
        default:
            break; 
        }
        
        
    }
    
}

