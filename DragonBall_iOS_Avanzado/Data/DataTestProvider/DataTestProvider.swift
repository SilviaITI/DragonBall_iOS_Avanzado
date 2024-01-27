//
//  DataTestProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 17/1/24.
//

import Foundation
class DataTestProvider: ApiProviderProtocol {
  
    func login(for user: String, with password: String) {
        
    }
    
    func getHeroes(by name: String?, token: String, completion: ((Heroes) -> Void)?) {
        
    }
    
    func getLocations(by heroId: String?, token: String, completion: (([Location]) -> Void)?) {
        
    }
    
    //TO DO: - Crear los datos harcodeados para los unit test
}
