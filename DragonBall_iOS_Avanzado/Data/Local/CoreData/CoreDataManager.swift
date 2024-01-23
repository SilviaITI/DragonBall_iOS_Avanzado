//
//  CoreData.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var moc: NSManagedObjectContext? {
       
            (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
       
    }

    // saves heroes
    func saveHero(hero: Hero) {
        guard let moc = moc,
              let _ = NSEntityDescription.entity(forEntityName: HeroDao.entityNameHero, in: moc) else {
            return
        }
        
     
        // Configures properties from a 'newHero' with data from hero
        do {
            try moc.save()
            print("Se han guardado los héroes")
        } catch {
            print("Error al guardar los héroes")
        }
        
        
    }
    
    // load saved heroes
    func loadHero() -> [HeroDao] {
        guard let moc = moc else {
            return []
        }

        let fetchRequest: NSFetchRequest<HeroDao> = NSFetchRequest(entityName: HeroDao.entityNameHero)

        do {
            let heroes = try moc.fetch(fetchRequest)
            print("Heroes: \(heroes)")
            return heroes
        } catch {
            print("Error al cargar los héroes: \(error)")
            return []
        }
    }

    // delete heroes from CoreData
    func deleteAll() {
        let fetchHero = NSFetchRequest<HeroDao>(entityName: HeroDao.entityNameHero)
        guard let moc,
              let heroes = try? moc.fetch(fetchHero) else { return }

        heroes.forEach { moc.delete($0) }
        try? moc.save()
    }

}

