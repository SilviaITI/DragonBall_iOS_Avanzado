//
//  HeroTest.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Silvia Casanova Martinez on 28/1/24.
//

import XCTest
@testable import DragonBall_iOS_Avanzado
final class HeroTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testModelHeroe() throws {
        let modelHero = Hero(id: "3", 
                             name: "Goku",
                             description: "Esto es una descripción",
                             photo: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087"),
                             favorite: true)
        
        XCTAssertNotNil(modelHero)
        XCTAssertEqual(modelHero.id, "3")
        XCTAssertEqual(modelHero.name, "Goku")
        XCTAssertEqual(modelHero.photo,  URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087"))
        XCTAssertEqual(modelHero.description, "Esto es una descripción")
    }
    }


