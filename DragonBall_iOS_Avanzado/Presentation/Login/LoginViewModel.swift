//
//  LoginViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import Foundation
class LoginViewModel: LoginViewControllerDelegate {
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    
  
    // MARK: - Properties -
    var viewState: ((LoginViewState) -> Void)?
  
    init(apiProvider: ApiProviderProtocol,
         keyChainProvider: KeyChainProviderProtocol) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        
    }
    //MARK: - Functions
    func onLoginPressed(email: String?, password: String?) {
        viewState?(.loading(true))
        DispatchQueue.global().async {
            guard self.isValidEmail(email: email) else {
                self.viewState?(.loading(false))
                self.viewState?(.showErrorEmail("Indique un email válido"))
                return
            }
            guard self.isValidPassword(password: password) else {
                self.viewState?(.loading(false))
                self.viewState?(.showErrorPassword("El password no es válido"))
                return
            }
            self.doLoginWith(
                email: email ?? "",
                password: password ?? ""
            )
        }
    }
    
    
    private func isValidEmail(email: String?) -> Bool {
        email?.isEmpty == false && (email?.contains("@") ?? false && (email?.contains(".")) ?? false)
    }
    private func isValidPassword(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 4
    }
    private func doLoginWith(email: String, password: String) {
        apiProvider.login(for: email, with: password)
    }
    
}
