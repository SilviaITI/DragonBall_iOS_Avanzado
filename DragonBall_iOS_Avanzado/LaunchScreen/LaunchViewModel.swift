//
//  LaunchViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import Foundation
class LaunchViewModel: LaunchViewControllerDelegate {
   
    
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    var viewState: ((LaunchViewState) -> Void)?
    
    lazy var loginViewModel: LoginViewControllerDelegate = {
          LoginViewModel(
            apiProvider: apiProvider,
             keyChainProvider: keyChainProvider
          )
      }()

      lazy var homeViewModel: HomeViewControllerDelegate = {
          HomeViewModel(
            apiProvider: apiProvider,
             keyChainProvider: keyChainProvider
          )
      }()
    init(apiProvider: ApiProviderProtocol, keyChainProvider: KeyChainProviderProtocol) {
          self.apiProvider = apiProvider
          self.keyChainProvider = keyChainProvider
      }
    
    func onViewAppear() {
        viewState?(.loading(true))
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            if self.isTokenSaved() { self.viewState?(.navigateToHome)
            }
            else {
                self.viewState?(.navigateToLogin)
            }
        }
    }
        func isTokenSaved() -> Bool {
           keyChainProvider.getToken() != nil
        }
    }

