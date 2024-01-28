//
//  CoreDataTest.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Silvia Casanova Martinez on 28/1/24.
//

//import XCTest
//import CoreData
//@testable import DragonBall_iOS_Avanzado
//
//final class CoreDataTest: XCTestCase {
//  
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
// 
//    var coreDataStack = CoreDataStack.shared
//    var moc: NSManagedObjectContext
//    var coreDataManager: CoreDataManagerProtocol
//    // Test para asegurarse de que se guarda un héroe correctamente
//    func testSaveHero() {
//        let hero = Hero(id: "1", name: "Goku", description: "Saiyan Warrior", photo: URL(string: "https://example.com/goku.jpg"), favorite: true)
//        
//        coreDataManager.saveHero(hero: hero)
//        
//        // Verifica que el héroe se haya guardado correctamente
//        let savedHeroes = coreDataManager.loadHero()
//        XCTAssertEqual(savedHeroes.count, 1, "Error al guardar el héroe")
//        XCTAssertEqual(savedHeroes.first?.name, "Goku", "El nombre del héroe guardado no coincide")
//    }
//    
//    // Test para asegurarse de que se eliminan todos los héroes correctamente
//    func testDeleteAllHeroes() {
//        let hero = Hero(id: "1", name: "Goku", description: "Saiyan Warrior", photo: URL(string: "https://example.com/goku.jpg"), favorite: true)
//        
//        coreDataManager.saveHero(hero: hero)
//        coreDataManager.deleteAllHeroes()
//        
//        // Verifica que el héroe se haya guardado correctamente
//        let savedHeroes = coreDataManager.loadHero()
//         XCTAssertNil(savedHeroes)
//       
//    }
//    
//}
