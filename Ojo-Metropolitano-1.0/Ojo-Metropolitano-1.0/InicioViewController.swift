//
//  InicioViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class InicioViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = PinAnnotation(title: "Usted está aquí", subtitle: "Verifique la Zona !", coordinate: userLocation)
        
        self.mapView.showsUserLocation = true
        self.mapView.addAnnotation(pin)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        //mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D (latitude: 20.695258, longitude: -103.348564),1500, 1500 ),animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    //++++++++++++++++++++++++ Cambia color de tab bar ++++++++++++++++++++++++
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.red
    }
    //------------------------ Cambia color de tab bar ------------------------
    */
 
}
