//
//  MapViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 23/1/24.
//

import Foundation
import MapKit

class MapViewModel: MapViewControllerDelegate {
  
   
    var viewState: ((MapViewState) -> Void)?
    
    var heroes: Heroes
    var heroLocations: HeroLocations?
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    
    
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol, heroes: Heroes?) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        self.heroes = heroes ?? []
    }
    
//    func fetchLocations() -> HeroLocations  {
////        DispatchQueue.global().async {
////            self.heroes.forEach { hero in
////                if let token = self.keyChainProvider.getToken() {
////                    self.apiProvider.getLocations(by: hero.id, token: token) { locations in
////                        self.heroLocations?.append(contentsOf: locations)
////                    
////        }
////                    
////                }
////            }
////            
////        }
//        return heroLocations ?? []
//       
//    }
    
}
