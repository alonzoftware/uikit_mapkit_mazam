//
//  ViewController.swift
//  MapKit-Annotations-Lon
//
//  Created by Rene Alonzo Choque Saire on 2/3/25.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var mapTypeSegmentedControl : UISegmentedControl!
    private let locationManager = CLLocationManager( )
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization( )
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation( )
        self.mapView.showsUserLocation = true
        self.mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
    }
    @IBAction func addAnnotationButtonPressed() {
        let annotation = MKPointAnnotation()
        //Close VFatima Home
        //annotation.coordinate = CLLocationCoordinate2D(latitude: -16.47660816416993, longitude: -68.12385957980739)
        //Close AXS
        annotation.coordinate = CLLocationCoordinate2D(latitude:-16.54063096964433 , longitude:  -68.08032941865261)
        annotation.title = "Ahu Tongariki"
        annotation.subtitle = "Fiordland National Park"
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func addCustomAnnotationButtonPressed() {
        let annotation = CoffeeAnnotation()
        //Close VFatima Home
        //annotation.coordinate = CLLocationCoordinate2D(latitude: -16.47660816416993, longitude: -68.12385957980739)
        //Close AXS
        annotation.coordinate = CLLocationCoordinate2D(latitude:-16.540836489467605 , longitude:  -68.08133368818132)
        annotation.title = "Ahu Tongariki"
        annotation.subtitle = "Fiordland National Park"
        annotation.imageURL = "coffee-pin"
        self.mapView.addAnnotation(annotation)
    }
    
    @objc func mapTypeChanged(segmentedControl: UISegmentedControl){
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            self.mapView.mapType = .standard
        case 1:
            self.mapView.mapType = .satellite
        case 2:
            self.mapView.mapType = .hybrid
        default:
            self.mapView.mapType = .standard
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Annotation: \(annotation.self)")
        if annotation is MKUserLocation {
            return nil
        }
       //FIRST OPTION - IMAGE
//        var coffeeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CoffeeAnnotationView")
//        
//        if coffeeAnnotationView == nil {
//            
//            coffeeAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeAnnotationView")
//            coffeeAnnotationView?.canShowCallout = true
//        } else {
//            coffeeAnnotationView?.annotation = annotation
//        }
//        
//        if let coffeeAnnotation = annotation as? CoffeeAnnotation {
//            coffeeAnnotationView?.image = UIImage(named: coffeeAnnotation.imageURL)
//        }else{
//            return nil
//        }
//        
//        return coffeeAnnotationView
        
        //SECOND OPTION - EMOJI
        var coffeeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CoffeeAnnotationView") as? MKMarkerAnnotationView
        
        if coffeeAnnotationView == nil {
            
            coffeeAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeAnnotationView")
//            coffeeAnnotationView?.glyphText = "😃"
            coffeeAnnotationView?.glyphText = "B"
            coffeeAnnotationView?.markerTintColor=UIColor.purple
            coffeeAnnotationView?.glyphTintColor = UIColor.yellow
            
            coffeeAnnotationView?.canShowCallout = true
        } else {
            coffeeAnnotationView?.annotation = annotation
        }
        
        if annotation is CoffeeAnnotation {
        }else{
            return nil
        }
        
        return coffeeAnnotationView
        
        
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        self.mapView.setRegion(region, animated: true)
    }
    
}

