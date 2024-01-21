//
//  HomeViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//

import Foundation
class HomeViewModel: HomeViewControllerDelegate {
    
    
    // MARK: - Properties -
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    var viewState: ((HomeViewState) -> Void)?
    var token: String = ""
    var heroes: Heroes = []
    
    // MARK: - Init -
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
    }
    
    
    // MARK: - Functions -
    func logOut() {
        keyChainProvider.delete(token: token)
        CoreDataManager.shared.deleteAll()
    }
    
    var heroesCount: Int {
        heroes.count
    }
    
    func onViewAppear() {
        viewState?(.loading(true))
        DispatchQueue.global().async {
            guard let token = self.keyChainProvider.getToken()
            else { return }
            self.apiProvider.getHeroes(by: nil, token: token){ heroes in
                self.heroes = heroes
                self.viewState?(.loading(false))
                self.viewState?(.reloadData)
                heroes.forEach { hero in
                    CoreDataManager.shared.saveHero(hero: hero)
                }
            }
        }
    }
  
// TO DO  Mirar con foreACH
//    func filteredHeroes(name: String)  {
//        apiProvider.getHeroes(by: name, token: token) { fetchedHeroes in
//            if let filteredHeroes = fetchedHeroes.filter { fetchedHeroes.name.lowercased().contains(name.lowercased()) }
//           
//        }
//    }

        
        func heroBy(index: Int) -> Hero? {
            if index >= 0 && index < heroesCount {
                return heroes[index]
            } else {
                return nil
            }
        }
    }

