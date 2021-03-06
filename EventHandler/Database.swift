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
    // 0 : Successful connection and query with successful result
    // 1 : Successful connection, situational failure BAD
    // 2 : Connection error
    var dbErr : Int = 0
    var dbMessage : String = ""
    var branchTest : String = ""

    init(_ip : String)
    {
         self.ip = "http://" + _ip + "/"
    }
    
    private func getWebResults(url : String) -> NSDictionary?
    {
        var returnVal : AnyObject?
        for(var i = 0, done = false; !done || i < 5; i++)
        {
            var request = NSMutableURLRequest(URL: NSURL(string: url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
            var response: NSURLResponse?
            var error: NSError?
        
            let jsonString = ""
            request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            request.HTTPMethod = "GET"
        
            let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
            if data != nil
            {
                var parseError: NSError?
                let responseObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &parseError) as? NSDictionary
                return responseObject
            }
        }
        return nil
    }
    
    func login(username : String, password : String) -> User?
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "login.php?username=" + username + "&password=" + password)
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                let id = (innerResult![0]["id"] as! String).toInt()!
                let firstName = innerResult![0]["firstName"] as! String
                let lastName = innerResult![0]["lastName"] as! String
                let email = innerResult![0]["email"] as! String
            
                let temp : User = User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _email: email)
            
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func getEventsByLocation(userId : Int, location : Location, range : Double) -> [Event]?
    {
        dbErr = 0
        var latString : String = String(format: "%f", location.latitude)
        if let result : NSDictionary = getWebResults(self.ip + "getEventsByLocation.php?userId=" + String(userId) + "&lat=" + String(format: "%f", location.latitude) + "&lon=" + String(format: "%f", location.longitude) + "&range=" + String(format: "%f", range))
        {
            dbMessage = result["message"] as! String
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
                    let maxAttendance = (innerResult![i]["maxAttendance"] as! String).toInt()!
                    let minRating = (innerResult![i]["minRating"] as! NSString).doubleValue
                    let daysFromToday = (innerResult![i]["daysFromToday"] as! String).toInt()!
                
                    returnList.append(Event(_id: id, _title: title, _description: description, _date: date, _duration: duration, _location: location, _public: privateEvent, _maxAttendance: maxAttendance, _minRating: minRating, _daysFromToday: daysFromToday))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func getEventsByUser(userId : Int, creatorId : Int) -> [Event]?
    {
        dbErr = 0
        if let result : NSDictionary = getWebResults(self.ip + "getEventsByUser.php?userId=" + String(userId) + "&creatorId=" + String(creatorId))
        {
            dbMessage = result["message"] as! String
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
                    let maxAttendance = (innerResult![i]["maxAttendance"] as! String).toInt()!
                    let minRating = (innerResult![i]["minRating"] as! NSString).doubleValue
                    let daysFromToday = (innerResult![i]["daysFromToday"] as! String).toInt()!
                    
                    returnList.append(Event(_id: id, _title: title, _description: description, _date: date, _duration: duration, _location: location, _public: privateEvent, _maxAttendance: maxAttendance, _minRating: minRating, _daysFromToday: daysFromToday))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func createEvent(_userId : Int, _title : String, _description : String, _date : DateTime, _duration : Int, _location : Location, _private : Bool, _maxAttendance : Int, _minRating : Double) -> Event?
    {
        dbErr = 0
        if let result : NSDictionary = getWebResults(self.ip + "createEvent.php?userId=" + String(_userId) + "&title=" + _title + "&description=" + _description + "&date=" + _date.toString() + "&duration=" + String(_duration) + "&locationLat=" + String(format: "%f", _location.latitude) + "&locationLon=" + String(format: "%f", _location.longitude) + "&private=" + (_private ? "1" : "0") + "&maxAttendance=" + String(_maxAttendance) + "&minRating=" + String(format: "%f", _minRating))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
            
                let id = (innerResult![0]["id"] as! String).toInt()!
                let daysFromToday = (innerResult![0]["daysFromToday"] as! String).toInt()!
            
                return Event(_id: id, _title: _title, _description: _description, _date: _date, _duration: _duration, _location: _location, _public: _private, _maxAttendance: _maxAttendance, _minRating: _minRating, _daysFromToday: daysFromToday)
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func getFollowers(_userId : Int) -> [User]?
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "getFollowers.php?userId=" + String(_userId))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                var returnList : [User] = []
                for(var i = 0; i < innerResult?.count; i++)
                {
                    let id = (innerResult![i]["id"] as! String).toInt()!
                    let firstName = innerResult![i]["firstName"] as! String
                    let lastName = innerResult![i]["lastName"] as! String
                    let username = innerResult![i]["username"] as! String
                    let email = innerResult![i]["email"] as! String
                    
                    returnList.append(User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _email: email))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func getFollowing(_userId : Int) -> [User]?
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "getFollowing.php?userId=" + String(_userId))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                var returnList : [User] = []
                for(var i = 0; i < innerResult?.count; i++)
                {
                    let id = (innerResult![i]["id"] as! String).toInt()!
                    let firstName = innerResult![i]["firstName"] as! String
                    let lastName = innerResult![i]["lastName"] as! String
                    let username = innerResult![i]["username"] as! String
                    let email = innerResult![i]["email"] as! String
                    
                    returnList.append(User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _email: email))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func searchByUsername(_search : String) -> [User]?
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "searchByUsername.php?search=" + String(_search))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                var returnList : [User] = []
                for(var i = 0; i < innerResult?.count; i++)
                {
                    let id = (innerResult![i]["id"] as! String).toInt()!
                    let firstName = innerResult![i]["firstName"] as! String
                    let lastName = innerResult![i]["lastName"] as! String
                    let username = innerResult![i]["username"] as! String
                    let email = innerResult![i]["email"] as! String
                    
                    returnList.append(User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _email: email))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func searchByFullName(_search : String) -> [User]?
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "searchByFullName.php?search=" + String(_search))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                var returnList : [User] = []
                for(var i = 0; i < innerResult?.count; i++)
                {
                    let id = (innerResult![i]["id"] as! String).toInt()!
                    let firstName = innerResult![i]["firstName"] as! String
                    let lastName = innerResult![i]["lastName"] as! String
                    let username = innerResult![i]["username"] as! String
                    let email = innerResult![i]["email"] as! String
                    
                    returnList.append(User(_id: id, _firstName: firstName, _lastName: lastName, _username: username, _email: email))
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
    
    func followUser(userId : Int, followId : Int) -> Bool
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "followUser.php?userId=" + String(userId) + "&followId=" + String(followId))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                return true
            }
            else if(result["response"] as! String == "failure")
            {
                dbErr = 1
                dbMessage = "Follow action failed. Either the user is already following that user, or one of the users doesn't exist";
                return false
            }
            else
            {
                dbErr = 2
                dbMessage = "The database query failed somehow";
                return false
            }
        }
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return false
        }
    }
    
    func unfollowUser(userId : Int, followId : Int) -> Bool
    {
        dbErr = 0;
        if let result : NSDictionary = getWebResults(self.ip + "unfollowUser.php?userId=" + String(userId) + "&followId=" + String(followId))
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                return true
            }
            else if(result["response"] as! String == "failure")
            {
                dbErr = 1
                dbMessage = "Unfollow action failed. Either the user is not following that user, or one of the users doesn't exist";
                return false
            }
            else
            {
                dbErr = 2
                dbMessage = "The database query failed somehow";
                return false
            }
        }
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return false
        }
    }
    
    func sendCreationPinEmail(userEmail : String, pinNum : Int)
    {
        dbErr = 0;
        let result : NSDictionary = getWebResults(self.ip + "sendCreationEmail.php?userEmail=" + userEmail + "&pin=" + String(pinNum))!
    }
    
    func createUser(_username : String, _password : String, _email : String, _firstName : String, _lastName : String) -> User?
    {
        dbErr = 0
        if let result : NSDictionary = getWebResults(self.ip + "createEvent.php?username=" + String(_username) + "&password=" + _password + "&email=" + _email + "&firstName=" + _firstName + "&lastName=" + _lastName)
        {
            dbMessage = result["message"] as! String
            if(result["response"] as! String == "success")
            {
                let innerResult = result["result"] as! NSArray?
                
                let id = (innerResult![0]["id"] as! String).toInt()!
                
                return User(_id: id, _firstName: _firstName, _lastName: _lastName, _username: _username, _email: _email)
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
        else
        {
            dbErr = 2
            dbMessage = "Connection returned nil"
            return nil
        }
    }
};