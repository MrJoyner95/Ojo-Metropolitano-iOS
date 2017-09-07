//
//  PinAnnotation.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Jesus Reynaga Rodriguez on 05/09/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import MapKit

class PinAnnotation : NSObject, MKAnnotation {
    var title : String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle : String , coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
