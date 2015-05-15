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

class mapView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
      var radiusCircleCount=15
    var theSpan=0.045
    var theRadius=804.0
   // var circle=MKCircle()
    
    //outlets
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var map: MKMapView!
    var manager:CLLocationManager!
     var anotation = MKPointAnnotation()
    
    @IBOutlet var distanceTextBoxOutlet: UITextField!
    
    @IBAction func distanceTextBox(sender: AnyObject)
    {
        var miles=(distanceTextBoxOutlet.text);
        theSpan=toSpan((miles as NSString).doubleValue);
        theRadius=milesToMeters((miles as NSString).doubleValue);
        
    }
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBAction func segmentAction(sender: AnyObject)
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            println("Welcome");
        case 1:
            self.dismissViewControllerAnimated(true, completion: nil)
        case 2:
            println("Profile");
        default:
            break;
        }
        
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

      
        
        distanceTextBoxOutlet.delegate=self;
        
        
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        //Setup our Map View
        map.delegate = self
        map.mapType = MKMapType.Standard
        map.showsUserLocation = true
        
        
        
        
       
    }
    
        //updating location function **** GAME LOOP ****
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject])
    {
        //gives location in coordinates
        //locationLabel.text="\(locations[0]) as CL"
       
        let location=map.userLocation.coordinate
        var newRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(theSpan, theSpan))
        map.setRegion(newRegion, animated: true)
        
    
        //setting and removing annotations
        /*
        map.removeAnnotation(anotation)
        anotation.coordinate = location
        anotation.title = "My Location"
        anotation.subtitle = "This is my location !!!"
        map.addAnnotation(anotation)
        */
        
        
        
       
        //current user location
        var location1 = CLLocation(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
            //Adding the circle to our location
        
            if(radiusCircleCount<1)
            {
                addRadiusCircle(location1)
                radiusCircleCount=30;
            }
        radiusCircleCount--;
        println(radiusCircleCount);
        
        
        
        //Coverting CLlocation to readable address
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
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
    
    
    
    
    //**Adding a circle to the map **//
    func addRadiusCircle(location: CLLocation){
        self.map.delegate = self
        //self.map.removeOverlay(circle);
         var circle = MKCircle(centerCoordinate: location.coordinate, radius: theRadius as CLLocationDistance)
        
        self.map.addOverlay(circle)
    }
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
    
    
    
    //put placemark location into address form and set as text
    func displayLocationInfo(placemark: CLPlacemark!) {
        if placemark != nil {
            
            locationLabel.text="";
            var text="";
        
            text+="\(placemark.locality)"
            text+=" \(placemark.administrativeArea ),"
            text+=" \(placemark.postalCode ) "
            text+=" \(placemark.country)"
            locationLabel.text=text;
        }
        
    }
  
    
        //Errors for location
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    
    func milesToMeters(miles:Double)->Double
    {
        return miles/0.00062137;
        
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        distanceTextBoxOutlet.resignFirstResponder();
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}