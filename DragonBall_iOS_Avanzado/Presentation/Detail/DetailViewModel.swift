//
//  DetailViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 27/1/24.
//

import Foundation
import MapKit

// MARK: - Class -
class DetailViewModel: DetailViewControllerDelegate {
    
    // MARK: - Properties -
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    var vieweState: ((DetailState) -> Void)?
    private var hero: Hero
    private var heroLocations: [Location] = []
    
    // MARK: - Init -
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol,  hero: Hero) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        self.hero = hero
    }
    
    // MARK: - Functions -
    func onViewsAppear() {
        defer { vieweState?(.loading(false))}
        vieweState?(.loading(true))
        DispatchQueue.main.async {
            guard let token = self.keyChainProvider.getToken() else {
                return
            }
            self.apiProvider.getLocations(
                by: self.hero.id,
                token: token) { [weak self]
                   heroLocations in
                    self?.heroLocations = heroLocations
                    self?.vieweState?(.update(
                        hero: self?.hero,
                        locations: heroLocations ))
                }
            }
        }
    }
    
    

