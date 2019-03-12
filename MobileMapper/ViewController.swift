//
//  ViewController.swift
//  MobileMapper
//
//  Created by Kyle Chung on 3/6/19.
//  Copyright © 2019 Kyle Chung. All rights reserved.
//
import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    @IBOutlet var Maroon5: MKMapView!
    let locationManager = CLLocationManager()
    var CurrentLocation: CLLocation!
    var parks: [MKMapItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization(                                                                 )
        Maroon5.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        Maroon5.delegate = self
    }
    
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CurrentLocation = locations[0]
        print("I like wildfire")
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(Maroon5.userLocation) {
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        let newbutton = UIButton(type: .detailDisclosure)
       
        
        pin.rightCalloutAccessoryView = button
        pin.leftCalloutAccessoryView = newbutton
        pin.detailCalloutAccessoryView?.addSubview(button)
        return pin
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var currentMapItem = MKMapItem()
        if let title = view.annotation?.title, let parkName = title {
            for mapitem in parks {
                if mapitem.name == parkName {
                    currentMapItem = mapitem
                }
            }
            
        }
        let placemark = currentMapItem.placemark
        print(placemark)
       
        
    }
    @IBAction func whenZoombuttonpressed(_ sender: Any) {
        let center = CurrentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        Maroon5.setRegion(region, animated: false)
        print("I like tables")
    }
    @IBAction func whenSearchbuttonpressed(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Park"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: CurrentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
                for mapItem in response.mapItems {
                    self.parks.append(mapItem)
                    let annotation = MKPointAnnotation()
                    annotation.title = mapItem.name
                    annotation.coordinate = mapItem.placemark.coordinate
                    self.Maroon5.addAnnotation(annotation)
                }
            // if let if there is data, what should I do?
         // guard let if there is no data, what should I do?
            print(response)
        }
        print("hats")
    }
}

