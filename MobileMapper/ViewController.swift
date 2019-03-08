//
//  ViewController.swift
//  MobileMapper
//
//  Created by Kyle Chung on 3/6/19.
//  Copyright © 2019 Kyle Chung. All rights reserved.
//



import UIKit
import MapKit



class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var Maroon5: MKMapView!
    
    let locationManager = CLLocationManager()
    var CurrentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization(                                                                 )
        Maroon5.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CurrentLocation = locations[0]
        
        print("I like wildfire")
    }
  
    @IBAction func whenZoombuttonpressed(_ sender: Any) {
        let center = CurrentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        Maroon5.setRegion(region, animated: false)
        
        
    }
    @IBAction func whenSearchbuttonpressed(_ sender: Any) {
        
        
        
    }
    
    
}

