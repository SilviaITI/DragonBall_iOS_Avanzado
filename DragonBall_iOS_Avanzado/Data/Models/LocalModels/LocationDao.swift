//
//  LocationDao.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import Foundation
import CoreData

@objc(LocationDao)
class LocationDao: NSManagedObject {
    
    static let entityName = "LocationDao"
    
    @NSManaged var dateShow: String?
    @NSManaged var id: String?
    @NSManaged var latitud: String?
    @NSManaged var longitud: String?
    
    convenience init(location: Location, context: NSManagedObjectContext) {
        self.init( context: context)
        id = location.id
        dateShow = location.date
        latitud = location.latitud
        longitud = location.longitud
    }
}
