//
//  HomeViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//

import Foundation
class HomeViewModel: HomeViewControllerDelegate {
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    var viewState: ((HomeViewState) -> Void)?
    
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
    }
    func fetchHeroesList() {
        
    }
    
   
    
    
}
