//
//  SplashViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//
import Foundation
import KeychainSwift


class SplashViewModel: SplashViewControllerDelegate {
    var viewState: ((SplashViewState) -> Void)
    private let keyChainProvider: KeyChainProviderProtocol
    private let apiProvider: ApiProviderProtocol
    
    // MARK: - Properties
  
    
   lazy var loginViewModel: LoginViewControllerDelegate = {
        LoginViewModel(
            apiProvider: apiProvider,
            keyChainProvider: keyChainProvider)
    }()
   lazy var heroesViewModel: HeroesViewControllerDelegate = {
        HeroesViewModel(apiProvider: apiProvider,
                        keyChainProvider: keyChainProvider)
    }()
    // Mark: Inicializers
    init(apiProvider: ApiProviderProtocol,
         keyChainProvider: KeyChainProviderProtocol) {
        self.keyChainProvider = keyChainProvider
        self.apiProvider = apiProvider
      
    }
    
    
    // Mark: public functions
    func onViewsAppear() {
        if keyChainProvider.getData() != nil {
            self.viewState(.navigateToHome)
        } else {
            self.viewState(.navigateToLogin)
        }
    }
}
