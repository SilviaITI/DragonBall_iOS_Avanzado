//
//  CoreData.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let shared: CoreDataManager = .init()
    private override init() {}
    
    var moc: NSManagedObjectContext? {
        
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
    }
    
    // saves heroes
    func saveHero(hero: HeroDao) {
        guard let moc = moc else {
            return
        }
        
        do {
            // Agrega el nuevo héroe al contexto
            moc.insert(hero)
            
            // Intenta guardar el contexto
            try moc.save()
            print("Se ha guardado el héroe correctamente")
        } catch {
            print("Error al guardar el héroe: \(error)")
        }
    }
    
    
    // load saved heroes
    func loadHero() -> [HeroDao] {
        guard let moc = moc else {
            return []
        }
        
        let fetchRequest: NSFetchRequest<HeroDao> = NSFetchRequest()
        
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
        guard let moc = moc else {
            return
        }
        
        let fetchRequest: NSFetchRequest<HeroDao> = NSFetchRequest()
        
        do {
            let heroes = try moc.fetch(fetchRequest)
            heroes.forEach { moc.delete($0) }
            try moc.save()
            print("Se han eliminado todos los héroes")
        } catch {
            print("Error al eliminar los héroes: \(error)")
        }
    }
}
