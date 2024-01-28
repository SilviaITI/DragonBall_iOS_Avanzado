//
//  HeroAnnotation.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 27/1/24.
//

import UIKit
import MapKit

// MARK: - Class -
class HeroAnnotation: NSObject, MKAnnotation {
    var title: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D

    // MARK: - Init -
    init(title: String? = nil, info: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
    }
}
