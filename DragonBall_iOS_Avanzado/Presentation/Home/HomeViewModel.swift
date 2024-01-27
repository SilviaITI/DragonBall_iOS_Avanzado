//
//  HomeViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//

import Foundation
class HomeViewModel: HomeViewControllerDelegate {
    lazy var loginViewModel: LoginViewControllerDelegate = {
          LoginViewModel(
            apiProvider: apiProvider,
             keyChainProvider: keyChainProvider,
            coreDataManager: coreDataManager
          )
      }()
   
    // MARK: - Properties -
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    private let coreDataManager: CoreDataManagerProtocol
    var viewState: ((HomeViewState) -> Void)?
    var token: String = ""
    var heroes: Heroes = []
    
  
    
    // MARK: - Init -
    init(apiProvider: ApiProviderProtocol, 
         keyChainProvider: KeyChainProviderProtocol,
         coreDataManager: CoreDataManager) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        self.coreDataManager = coreDataManager
       
    }
    
    
    // MARK: - Functions -
    func logOut() {
        keyChainProvider.delete(token: token)
        coreDataManager.deleteAllHeroes()
       
    }
    
    var heroesCount: Int {
        heroes.count
    }
    
    func onViewAppear() {
       
        viewState?(.loading(true))
        
        DispatchQueue.global().async {
           
            guard let token = self.keyChainProvider.getToken()
            else { return }
         let savedHeroes = self.coreDataManager.loadHero()
            if !savedHeroes.isEmpty {
                self.heroes = savedHeroes.map { heroDao in
                    return Hero(id: heroDao.id ,
                                name: heroDao.name ,
                                description: heroDao.descriptionHero ,
                                photo: URL(string: heroDao.photo ?? "" ),
                                favorite: heroDao.favorite)
                }
                self.viewState?(.reloadData)
                self.viewState?(.loading(false))
                print("Saved Heroes: \(savedHeroes)")
                
            } else {
                self.apiProvider.getHeroes(by: nil, token: token){ heroes in
                    self.heroes = heroes
                    self.viewState?(.reloadData)
                    self.viewState?(.loading(false))
                        for hero in heroes {
                            self.coreDataManager.saveHero(hero: hero)
                           

                        }
                    
          
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
    func fecthHeroes() -> Heroes {
        heroes
    }
    }


