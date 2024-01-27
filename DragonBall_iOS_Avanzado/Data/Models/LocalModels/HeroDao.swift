//
//  Extension HeroDao.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 27/1/24.
//

import Foundation
import CoreData

@objc(HeroDao)
class HeroDao: NSManagedObject {
    
    static let entityName = "HeroDao"
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var descriptionHero: String
    @NSManaged var photo: String?
    @NSManaged var favorite: Bool



    convenience init(context: NSManagedObjectContext, hero: Hero) {
        self.init(context: context)
        id = hero.id
        name = hero.name ?? ""
        descriptionHero = hero.description ?? ""
        photo = hero.photo?.absoluteString ?? ""
        favorite = hero.favorite ?? false
    }
}
