//
//  LoginViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import Foundation

//MARK: - Class -
class LoginViewModel: LoginViewControllerDelegate {

    // MARK: - Properties -
    private let apiProvider: ApiProviderProtocol
    private let keyChainProvider: KeyChainProviderProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    var viewState: ((LoginViewState) -> Void)?
    var token: String = ""
    
    lazy var homeViewModel: HomeViewControllerDelegate = {
        HomeViewModel(
          apiProvider: apiProvider,
          keyChainProvider: keyChainProvider,
          coreDataManager: coreDataManager as! CoreDataManager
        )
    }()
    
    // MARK: - Init -
    init(apiProvider: ApiProviderProtocol,
         keyChainProvider: KeyChainProviderProtocol,
         coreDataManager: CoreDataManagerProtocol) {
        self.apiProvider = apiProvider
        self.keyChainProvider = keyChainProvider
        self.coreDataManager = coreDataManager
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLoginResponse),
            name: NotificationCenter.apiLoginNotification,
            object: nil
        )
    }
    
    // MARK: - Deinit -
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Functions -
    func onLoginPressed(email: String?, password: String?) {
        viewState?(.loading(true))
        DispatchQueue.global().async { [self] in
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
            self.keyChainProvider.save(token: token)
        }
    }
    @objc func onLoginResponse(_ notification: Notification) {
        viewState?(.loading(true))
      
        guard let token = notification.userInfo?[NotificationCenter.tokenKey] as? String,
              !token.isEmpty else {
            return
        }
        print(token)
        keyChainProvider.save(token: token)
        viewState?(.loading(false))
        viewState?(.navigateToNext)
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
