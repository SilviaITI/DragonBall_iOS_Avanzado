//
//  LoginViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 13/10/23.
//

import Foundation

class LoginViewModel: LoginViewControllerDelegate {
  
    // MARK: - Dependencies
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol

    // MARK: - Properties
    var viewState: ((LoginViewState) -> Void)?
  
    var heroesViewModel: HeroesViewControllerDelegate {
        HeroesViewModel(apiProvider: apiProvider,
                        keyChainProvider: keyChainProvider)
    }
    // MARK: - Initializers
    init(
        apiProvider: ApiProviderProtocol,
        keyChainProvider: KeyChainProviderProtocol
    ) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLoginResponse),
            name: NotificationCenter.apiLoginNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public functions
    func onLoginPressed(email: String?, password: String?) {
        viewState?(.loading(true))

        DispatchQueue.global().async {
            guard self.isValid(email: email) else {
                self.viewState?(.loading(false))
                self.viewState?(.showErrorEmail("Indique un email válido"))
                return
            }

            guard self.isValid(password: password) else {
                self.viewState?(.loading(false))
                self.viewState?(.showErrorPassword("Indique una password válida"))
                return
            }

            self.doLoginWith(
                email: email ?? "",
                password: password ?? ""
            )
        }
    }

    @objc func onLoginResponse(_ notification: Notification) {
        defer { viewState?(.loading(false)) }
        guard let token = notification.userInfo?[NotificationCenter.tokenKey] as? String,
              !token.isEmpty else {
            return
        }

        keyChainProvider.save(token: token)
        viewState?(.navigateToHeroes)
    }

    // MARK: - Private functions -
    private func isValid(email: String?) -> Bool {
        email?.isEmpty == false && (email?.contains("@") ?? false)
    }

    private func isValid(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 4
    }

    private func doLoginWith(email: String, password: String) {
        apiProvider.login(for: email,
                          with: password)
    }
}

