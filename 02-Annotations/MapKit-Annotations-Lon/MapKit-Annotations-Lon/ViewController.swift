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
        annotation.coordinate = CLLocationCoordinate2D(latitude: -16.47660816416993, longitude: -68.12385957980739)
        annotation.title = "Ahu Tongariki"
        annotation.subtitle = "Fiordland National Park"
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
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        self.mapView.setRegion(region, animated: true)
    }

}

