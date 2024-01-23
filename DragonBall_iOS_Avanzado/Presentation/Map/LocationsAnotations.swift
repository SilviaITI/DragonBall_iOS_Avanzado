//
//  LocationsAnotations.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 23/1/24.
//

import Foundation
import MapKit

class LocationsAnotations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, info: String) {
        self.coordinate = coordinate
        self.title = title
        self.info = info
    }

}
