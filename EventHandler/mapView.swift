//
//  mapView.swift
//  EventHandler
//
//  Created by Brittny Wright on 5/5/15.
//  Copyright (c) 2015 Wade Wilkey. All rights reserved.
//
//globals


//packages

import Foundation
import UIKit
import MapKit
import CoreLocation

var events = [Event]()
//var globalLocation = Location(lat: 0, lon: 0)
//var globalLocation = Location()

class mapView: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
   
   // var theSpan=0.045
    var theRadius=804.0
    var updateRegion=true;
    var circleAdded=false;
    var circle=MKCircle();
     var pickerDataSource = [".5", "1", "4", "10","15","25","50"];
    
    //outlets

   
    @IBOutlet var map: MKMapView!
    @IBOutlet var radiusButtonOutlet: UIButton!
    var manager:CLLocationManager!
     var eventPins = [MKPointAnnotation()]
    
    var timer=NSTimer();
    
   
    @IBOutlet var milePicker: UIPickerView!

    @IBOutlet var addressBar: UISearchBar!
    


    
    override func viewDidLoad()
    {
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //picker view set up
       
        
        self.milePicker.dataSource = self;
        self.milePicker.delegate = self;
        milePicker.hidden=true;
    
        milePicker.layer.borderColor = UIColor.blueColor().CGColor
        milePicker.layer.borderWidth = 5
        milePicker.backgroundColor=UIColor.lightGrayColor();
        
        
        addressBar.delegate=self;
        addressBar.showsSearchResultsButton=true;
        addressBar.hidden = false;
        
        //default range of view
        user!.theSpan=toSpan(1);
        theRadius=milesToMeters(1);
       
        
   
        if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
        {
            
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        }
        else
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        }
     
        
        
        
   
        
        //Setup our Map View
        map.delegate = self
        map.mapType = MKMapType.Standard
        map.showsUserLocation = true
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "pinRequest:")
        longPress.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPress)
        
        updateEvents();
        
        
       
       
    }
    @IBAction func radiusButtonAction(sender: AnyObject) {
        milePicker.hidden=false;
    }
    @IBAction func homeButton(sender: AnyObject)
    {
        var location = CLLocationCoordinate2D();
        
        if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
        {
            
            location=CLLocationCoordinate2D(latitude: manager.location.coordinate.latitude, longitude: manager.location.coordinate.longitude);
        }
        else
        {
              location=CLLocationCoordinate2D(latitude: globalLocation.latitude, longitude: globalLocation.longitude);
        }
        
        globalLocation.latitude=location.latitude;
        globalLocation.longitude=location.longitude;
        //let location=map.userLocation.coordinate
        var sp=user!.theSpan*2*1.73205080757;
        
        var newRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(sp, sp));
        
        map.setRegion(newRegion, animated: true)
        
        updateEvents();
        updateRegion=true;
        if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
        {
            manager.startUpdatingLocation();
        }
        
    }
    
    func pinRequest(gestureRecognizer:UIGestureRecognizer)
    {

        if(gestureRecognizer.state==UIGestureRecognizerState.Began)
        {
            
            
        var touchPoint = gestureRecognizer.locationInView(self.map)
            touchPoint.y -= 10;
        var newCoord:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
            //Create the AlertController
            let annotationController: UIAlertController = UIAlertController(title: "New Location", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            annotationController.addAction(cancelAction)
            //Create and add first option action
            let setNewLocation: UIAlertAction = UIAlertAction(title: "Set As New Location", style: .Default) { action -> Void in
                globalLocation.latitude=newCoord.latitude;
                globalLocation.longitude=newCoord.longitude;
                if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
                {
                    self.manager.startUpdatingLocation()
                   
                }
                self.updateRegion=true;
                
            }
            annotationController.addAction(setNewLocation)
            //Create and add a second option action
            let createNewEvent: UIAlertAction = UIAlertAction(title: "Create An Event", style: .Default) { action -> Void in
                var newAnotation = MKPointAnnotation()
                newAnotation.coordinate = newCoord
                newAnotation.title = "New Location"
                newAnotation.subtitle = "New Subtitle"
                self.map.addAnnotation(newAnotation)
                var eventLoc = Location(lat: newCoord.latitude, lon: newCoord.longitude)
                self.performSegueWithIdentifier("createEvent", sender: eventLoc)
                
            }
            annotationController.addAction(createNewEvent)
            
            //We need to provide a popover sourceView when using it on iPad
            //actionSheetController.popoverPresentationController?.sourceView = sender as UIView;
            
            //Present the AlertController
            self.presentViewController(annotationController, animated: true, completion: nil)
            
            
      
        }
        
    }
    

 
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
          println(addressBar.text);
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressBar.text, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark
            {
                var loc = (MKPlacemark(placemark: placemark)).coordinate;
                globalLocation.latitude=loc.latitude;
                globalLocation.longitude=loc.longitude;
                self.updateRegion=true;
                self.manager.startUpdatingLocation();
            }
            else
            {
                println("couldn't find");
                
            }
        })
       
        addressBar.resignFirstResponder();
    }


   
    
    func updateEvents()
    {
        
     
        
        for(var i=eventPins.count-1; i>0; i--)
        {
            map.removeAnnotation(eventPins[i]);
           eventPins.removeLast()
        }
        //var location = Location(lat: map.userLocation.coordinate.latitude, lon: map.userLocation.coordinate.longitude)
        
        
        var location = globalLocation;
        
        events = db.getEventsByLocation(user!.id, location: location, range: toMiles(user!.theSpan))!;
        for i in events
        {
       // println("event latitude: \(i.location.latitude) and longitude \(i.location.longitude)");
        var annotation=MKPointAnnotation();
     
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: i.location!.latitude, longitude: i.location!.longitude);
        
        annotation.title = i.title;
        annotation.subtitle = i.description
      
        map.addAnnotation(annotation)
        
       // println(annotation.title + " " + annotation.subtitle);
       
        
        eventPins.append(annotation);
        }
    }
    
    func update()
    {
        
        let location=CLLocationCoordinate2D(latitude: globalLocation.latitude, longitude: globalLocation.longitude);
        
        if(updateRegion==true)
        {
            //let location=map.userLocation.coordinate
            var sp=user!.theSpan*2*1.73205080757;
            
            var newRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(sp, sp));
            
            map.setRegion(newRegion, animated: true)
            
            updateEvents();
            circleAdded=false;
            updateRegion=false;
            
            //println("Latitude \(location.latitude) and longitude: \(location.longitude)")
        }
        else
        {
            if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
            {
                
                manager.stopUpdatingLocation()
            }
        }
        
        
        
        //current user location
        //  var location1 = CLLocation(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        
        
        //Adding the circle to our location
        
        if(circleAdded==false)
        {
            addRadiusCircle(CLLocation(latitude: location.latitude, longitude: location.longitude));
            circleAdded=true;
            
        }
        
        
        
        //Coverting CLlocation to readable address
        let location1=CLLocation(latitude: globalLocation.latitude, longitude: globalLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(location1, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
        
        
        
        
    }
    
        //updating location function **** GAME LOOP ****
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject])
    {
     
        update();
    
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!)
    {
          var selected:MKPointAnnotation!;
        
        if(mapView.selectedAnnotations.count>0)
        {
            
            if(mapView.selectedAnnotations[0] is MKUserLocation)
            {
                println("Hello");
            }
            else if(eventPins.count>0)
            {
                selected=mapView.selectedAnnotations[0] as! MKPointAnnotation;
            
                if var s=selected
                {
                    if contains(eventPins,s)
                    {
                    
                        var index=find(eventPins, s);
                        index = index! - 1;
                        self.performSegueWithIdentifier("detailSegue2", sender: events[index!])
                    
                    }
                }
            
            
            }
        }
     
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if(annotation is MKUserLocation)
            {
                return nil;
            }
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
      
    }
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!)
    {
        
         var selected:MKPointAnnotation!;
        
    
        if(mapView.selectedAnnotations.count>0)
        {
            if(mapView.selectedAnnotations[0] is MKUserLocation)
            {
                let annotationController: UIAlertController = UIAlertController(title: "New Location", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                    //Just dismiss the action sheet
                }
                annotationController.addAction(cancelAction)
                
                //Create and add a second option action
                let createNewEvent: UIAlertAction = UIAlertAction(title: "Create An Event", style: .Default) { action -> Void in
                    
                    self.performSegueWithIdentifier("createEvent", sender: nil)
                    
                }
                annotationController.addAction(createNewEvent)
                
                
                //Present the AlertController
                self.presentViewController(annotationController, animated: true, completion: nil)
            }
            else
            {
                selected=mapView.selectedAnnotations[0] as! MKPointAnnotation;
            }
        }

        
    
        
    }
    
    
    //**Addwing a circle to the map **//
    func addRadiusCircle(location: CLLocation){
        self.map.delegate = self
        self.map.removeOverlay(circle);
        
        circle = MKCircle(centerCoordinate: location.coordinate, radius: (theRadius * 1.41421356237)  as CLLocationDistance)
        
        self.map.addOverlay(circle)
    }
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.blueColor()
            circle.fillColor = UIColor(red: 0, green: 185, blue: 98, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
    
    
    
    //put placemark location into address form and set as text
    func displayLocationInfo(placemark: CLPlacemark!) {
        if placemark != nil {
            
           
            //locationLabel.text="";
            var text="";
           // text+="\(placemark.subLocality) "
            text+="\(placemark.subThoroughfare) "
            text+="\(placemark.thoroughfare) "
            text+="\(placemark.locality)"
            text+=" \(placemark.administrativeArea ),"
            text+=" \(placemark.postalCode ) "
            text+=" \(placemark.country)"
           // locationLabel.text=text;
            addressBar.placeholder=text;
        }
        
    }
  
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
      
        var miles=0.0;
        if(row == 0)
        {
            miles = 0.5;
           
            
        }
        else if(row == 1)
        {
          miles=1;
        }
        else if(row == 2)
        {
             miles=4;
        }
        else if(row==3)
        {
             miles=10;
        }
        else if(row==4)
        {
             miles=15;
        }
        else if(row==5)
        {
             miles=25;
        }
        else
        {
            miles=50;
        }
        user!.theSpan=toSpan(Double(miles));
        theRadius=milesToMeters(Double(miles));
        if(haveLocation == CLAuthorizationStatus.AuthorizedAlways)
        {
            manager.startUpdatingLocation()
        }
        updateRegion=true;
        updateEvents();
        pickerView.hidden=true;
    }
    
        //Errors for location
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
 
    
    func milesToMeters(miles:Double)->Double
    {
        return (miles/0.000621371195);
        
    }
    //conver to span of map
    func toSpan(miles:Double) ->Double
    {
        return miles/69;
        
    }
    //convert to miles from span
    func toMiles(span:Double)->Double
    {
        return span*69;
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue2"
        {
            let detailViewController = segue.destinationViewController as! EventDetailViewController
            
            let eventObj = sender as! Event;
            detailViewController.curEvent = eventObj;
        }
        else if segue.identifier == "createEvent"
        {
            let vc = segue.destinationViewController as! CreateEventViewController
            let pinLoc = sender as! Location
            vc.pinLoc = pinLoc
        }
    }
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}