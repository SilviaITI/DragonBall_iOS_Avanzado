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
    
    static let entityNameHero = "LocationDao"
    
    @NSManaged var dateShow: String?
    @NSManaged var id: String?
    @NSManaged var latitud: String?
    @NSManaged var longitud: String?
    
    
    convenience init(location: HeroLocation, context: NSManagedObjectContext) {
        self.init( context: context)
        if let id = location.id {
            self.id = id
        }
        if let dateShow = location.date {
            self.dateShow = dateShow
        }
        if let latitud = location.latitude {
            self.latitud = latitud
        }
        if let longitud = location.longitude{
            self.longitud = longitud
        }
    }
}
