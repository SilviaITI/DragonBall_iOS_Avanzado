//
//  MapViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 23/1/24.
//

import Foundation
import MapKit

// MARK: - Class -
class MapViewModel: MapViewControllerDelegate {
    
    // MARK: - Properties -
    var viewState: ((MapViewState) -> Void)?
    var heroes: Heroes
    var heroLocations: [Location]?
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    
    // MARK: - Init -
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol, heroes: Heroes?) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        self.heroes = heroes ?? []
    }
    
    // MARK: - Functions -
    func onViewsAppear() {
        defer { viewState?(.loading(false))}
        viewState?(.loading(true))
        DispatchQueue.main.async {
            guard let token = self.keyChainProvider.getToken() else {
                return
            }
            self.heroes.forEach { hero in
                self.apiProvider.getLocations(
                    by: hero.id,
                    token: token) { [weak self]
                        heroLocations in
                        self?.heroLocations = heroLocations
                        self?.viewState?(.update(
                            locations: heroLocations ))
                    }
            }
        }
    }
}
