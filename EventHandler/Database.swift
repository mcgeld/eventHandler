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
    
    func login(username : String, password : String) -> User?
    {
        dbErr = 0;
        let result : NSDictionary = getWebResults(self.ip + "login.php?username=" + username + "&password=" + password)
        if(result["response"] as! String == "success")
        {
            let innerResult = result["result"] as! NSArray?
            let id = (innerResult![0]["id"] as! String).toInt()!
            let firstName = innerResult![0]["firstName"] as! String
            let lastName = innerResult![0]["lastName"] as! String
            let phoneNumber = (innerResult![0]["phone"] as! String).toInt()!
            let rating = (innerResult![0]["rating"] as! NSString).doubleValue
            let locationLat = (innerResult![0]["locationLat"] as! NSString).doubleValue
            let locationLon = (innerResult![0]["locationLon"] as! NSString).doubleValue
            
            let temp : User = User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _phoneNumber: phoneNumber, _rating: rating, _defaultLocation: Location(lat: locationLat, lon: locationLon))
            
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
    
    func getEventsByLocation(location : Location, range : Int) -> [Event]?
    {
        dbErr = 0;
        var latString : String = String(format: "%f", location.latitude);
        let result : NSDictionary = getWebResults(self.ip + "getEventsByLocation.php?lat=" + String(format: "%f", location.latitude) + "&lon=" + String(format: "%f", location.longitude) + "&range=" + String(range))
        if(result["response"] as! String == "success")
        {
            let innerResult = result["result"] as! NSArray?
            var returnList : [Event] = []
            for(var i = 0; i < innerResult?.count; i++)
            {
                let id = (innerResult![i]["id"] as! String).toInt()!
                let title = innerResult![i]["title"] as! String
                let description = innerResult![i]["description"] as! String
                let date = DateTime(dateTimeString: innerResult![i]["date"] as! String)
                let duration = (innerResult![i]["duration"] as! String).toInt()!
                let location = Location(lat: (innerResult![i]["locationLat"] as! NSString).doubleValue, lon: (innerResult![i]["locationLon"] as! NSString).doubleValue)
                let privateEvent = (innerResult![i]["privateEvent"] as! String) == "1"
                let maxAttendance = (innerResult![i]["maxAttendance"] as! String).toInt()
                let minRating = (innerResult![i]["minRating"] as! NSString).doubleValue
                
                returnList.append(Event(_id: id, _title: title, _description: description, _date: date, _duration: duration, _location: location, _private: privateEvent, _maxAttendance: maxAttendance!, _minRating: minRating))
            }
            return returnList
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