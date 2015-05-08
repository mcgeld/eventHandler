//
//  Database.swift
//  EventHandler
//
//  Created by Malcolm Geldmacher on 5/7/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//

import Foundation

class Database {
    private var ip : String;
    //Error Codes:
    // 0 : Successful connection and query
    // 1 : Successful connection, situational failure
    // 2 : Connection error
    var dbErr : Int = 0;
    
    init(_ip : String)
    {
         self.ip = "http://" + _ip + "/";
    }
    
    private func getWebResults(url : String) -> NSDictionary
    {
        var request = NSMutableURLRequest(URL: NSURL(string: url.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        
        let jsonString = ""
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        request.HTTPMethod = "GET"
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        var parseError: NSError?
        let responseObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &parseError) as? NSDictionary
        
        return responseObject!
    }
    
    func login(username : String, password : String) -> systemUser?
    {
        dbErr = 0;
        let result : NSDictionary = getWebResults(self.ip + "login.php?username=" + username + "&password=" + password)
        if(result["response"] as! String == "success")
        {
            let innerResult = result["result"] as! NSArray?
            let idParm : String = innerResult![0]["id"] as! String
            let temp : systemUser = systemUser(_id: innerResult![0]["id"] as! String, _username: username, _attendance: innerResult![0]["attendance"] as! String, _location: innerResult![0]["location"] as! String, _phone: innerResult![0]["phone"] as! String)
            
            return temp
        }
        else if(result["response"] as! String == "failure")
        {
            dbErr = 1
            return nil
        }
        else
        {
            dbErr = 2
            return nil
        }
    }
    
};