//
//  SplashViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//
import Foundation
import KeychainSwift

class SplashViewModel: SplashViewControllerDelegate {
    var viewState: ((SplashViewState) -> Void)?
    private let keyChainProvider: KeyChainProviderProtocol
    private let apiProvider: ApiProviderProtocol


    lazy var loginViewModel: LoginViewControllerDelegate = {
            LoginViewModel(
                apiProvider: apiProvider,
                keyChainProvider: keyChainProvider
            )
        }()

    lazy var heroesViewModel: HeroesViewControllerDelegate = {
            HeroesViewModel(
                apiProvider: apiProvider,
                keyChainProvider: keyChainProvider
            )
        }()
    
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol) {
        self.keyChainProvider = keyChainProvider
        self.apiProvider = apiProvider
        
 
    }
    
    private var isTokenSaved: Bool {
        keyChainProvider.getData()?.isEmpty == false
    }

    func onViewsAppear() {
        viewState?(.isLoading(loading: true))
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
            self.isTokenSaved ? self.viewState?(.navigateToHome) : self.viewState?(.navigateToLogin)
        }
        
    }
        
    }
