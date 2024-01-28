//
//  CoreData.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import UIKit
import CoreData

//MARK: - Protocol -
protocol CoreDataManagerProtocol {
    func saveHero(hero: Hero)
    func loadHero() -> [HeroDao]
    func deleteAllHeroes()
}

//MARK: - Class -
class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    // MARK: - Properties -
    private var moc: NSManagedObjectContext
    
    // MARK: - Init -
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
   
    // MARK: - Functions -
    //save heroes
    func saveHero(hero: Hero) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: HeroDao.entityName, in: moc) else {
            print("Error al obtener la descripción de la entidad")
            return
        }
        
        do {
          
            let heroDao = HeroDao(entity: entityDescription, insertInto: moc)
          
            heroDao.id = hero.id
            heroDao.name = hero.name ?? ""
            heroDao.descriptionHero = hero.description ?? ""
            heroDao.photo = hero.photo?.absoluteString ?? ""
            heroDao.favorite = hero.favorite ?? false
            
            try moc.save()
            print("Se ha guardado el héroe correctamente")
        } catch let error as NSError {
            print("Error al guardar el héroe: \(error.localizedDescription)")
        }
    }
    
    // load saved heroes
    func loadHero() -> [HeroDao] {
        let fetchRequest: NSFetchRequest<HeroDao> = NSFetchRequest(entityName: HeroDao.entityName)
        
        do {
            let heroes = try moc.fetch(fetchRequest)
            print("Heroes: \(heroes)")
            return heroes
        } catch let error as NSError {
            print("Error al cargar los héroes: \(error.localizedDescription)")
            return []
        }
    }
    
   
    // delete heroes from CoreData
    func deleteAllHeroes() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: HeroDao.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
           
            try moc.execute(deleteRequest)
            try moc.save()
            moc.reset()
            print("Se han eliminado todos los héroes")
        } catch let error as NSError {
            print("Error al eliminar los héroes: \(error.localizedDescription)")
        }
    }

}
