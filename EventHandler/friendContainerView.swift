//
//  friendContainerView.swift
//  EventHandler
//
//  Created by Brittny Wright on 6/22/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class friendContainerView: UITableViewController, UITableViewDataSource, UITableViewDelegate, ABAddressBookRef
{
 
    
    var adbk : ABAddressBook!
    var friends : [User] = []
    
    override func viewDidLoad()
    {
        var status=determineStatus();
        getContactNames();
        
    }
    
    func createAddressBook() -> Bool {
        if self.adbk != nil {
            return true
        }
        var err : Unmanaged<CFError>? = nil
        let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
        if adbk == nil {
            println(err)
            self.adbk = nil
            return false
        }
        self.adbk = adbk
        return true
    }
    
    func determineStatus() -> Bool {
        let status = ABAddressBookGetAuthorizationStatus()
        switch status {
        case .Authorized:
            return self.createAddressBook()
        case .NotDetermined:
            var ok = false
            ABAddressBookRequestAccessWithCompletion(nil) {
                (granted:Bool, err:CFError!) in
                dispatch_async(dispatch_get_main_queue()) {
                    if granted {
                        ok = self.createAddressBook()
                    }
                }
            }
            if ok == true {
                return true
            }
            self.adbk = nil
            return false
        case .Restricted:
            self.adbk = nil
            return false
        case .Denied:
            self.adbk = nil
            return false
        }
    }
    
    func getContactNames() {
        if !self.determineStatus() {
            println("not authorized")
            return
        }
        let people = ABAddressBookCopyArrayOfAllPeople(adbk).takeRetainedValue() as NSArray as [ABRecord]
            
        
        for person in people
        {
          
            
            println(ABRecordCopyCompositeName(person).takeRetainedValue())
            
            
        
        }
    }
    
}