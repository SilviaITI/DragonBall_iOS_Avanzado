//
//  HomeViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//

import Foundation
class HeroesViewModel: HeroesViewControllerDelegate {
    // MARK: - Dependencies
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    // MARK: - Properties
    var viewState: ((HeroesViewState) -> Void)?
    
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        
    }
   
    
}
