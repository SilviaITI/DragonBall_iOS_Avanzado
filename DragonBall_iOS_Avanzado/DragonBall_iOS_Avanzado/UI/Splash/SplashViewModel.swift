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
    private let secureDataProvider: SecureDataProviderProtocol
    private let apiProvider: ApiProviderProtocol
    
    // MARK: - Properties
  
    
    var loginViewModel: LoginViewControllerDelegate {
        LoginViewModel(
            apiProvider: apiProvider,
            secureDataProvider: secureDataProvider)
    }
    var heroesViewModel: HeroesViewControllerDelegate {
        HeroesViewModel(apiProvider: apiProvider,
        secureDataProvider: secureDataProvider)
    }
    // Mark: Inicializers
    init(apiProvider: ApiProviderProtocol,
         secureDataProvider: SecureDataProviderProtocol) {
        self.secureDataProvider = secureDataProvider
        self.apiProvider = apiProvider
      
    }
    
    
    // Mark: public functions
    func onViewsAppear() {
        if secureDataProvider.getToken() != nil {
            self.viewState(.navigateToHome)
        } else {
            self.viewState(.navigateToLogin)
        }
    }
}
