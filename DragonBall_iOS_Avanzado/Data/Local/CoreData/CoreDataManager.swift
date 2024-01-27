//
//  CoreData.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func saveHero(hero: Hero)
    func loadHero() -> [HeroDao]
    func deleteAllHeroes()
}
class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    private var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    // Resto de tu implementación...
    
    // saves heroes
    func saveHero(hero: Hero) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: HeroDao.entityName, in: moc) else {
            print("Error al obtener la descripción de la entidad")
            return
        }
        
        do {
            // Crea una instancia de HeroDao utilizando la entidad
            let heroDao = HeroDao(entity: entityDescription, insertInto: moc)
            
            // Configura las propiedades del HeroDao con los valores del Hero
            heroDao.id = hero.id
            heroDao.name = hero.name ?? ""
            heroDao.descriptionHero = hero.description ?? ""
            heroDao.photo = hero.photo?.absoluteString ?? ""
            heroDao.favorite = hero.favorite ?? false
            
            // Intenta guardar el contexto
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
            print("Se han eliminado todos los héroes")
        } catch let error as NSError {
            print("Error al eliminar los héroes: \(error.localizedDescription)")
        }
    }
    
}
