//
//  SplashViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//

import UIKit
import KeychainSwift
class SplashViewController: UIViewController {

    // MARK: Protocol
    protocol SplashViewControllerDelegate {
        func isTokenSaved()
        var heroesViewModel: HeroesViewControllerDelegate { get }
        var loginViewModel: LoginViewControllerDelegate { get }
        var viewState: ((SplashViewState) -> Void) { get set }
    }
    // MARK: Enum
    enum SplashViewState {
      
        case navigateToHome
        case navigateToLogin
        // falta onViewsAppear que sería isTokenSaved
    }

    // MARK: Class
    class SplashViewController: UIViewController {
        // MARK: IBOutlets
        @IBOutlet weak var loader: UIActivityIndicatorView!
        // MARK: Properties
        var viewModel: SplashViewControllerDelegate?
        
        // MARK: - LyfeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setObservers()
            viewModel?.isTokenSaved()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
            guard segue.identifier == "SPLASH_TO_LOGIN",
                  let loginViewController = segue.destination as? LoginViewController else {
                return
            }
            
            guard segue.identifier == "SPLASH_TO_HEROES",
                  let heroesViewController = segue.destination as? HeroesViewController else {
                return
            }
            
            loginViewController.viewModel = viewModel?.loginViewModel
            heroesViewController.viewModel = viewModel?.heroesViewModel
        }
        
        // MARK: Public functions
        //
        private func setObservers() {
            viewModel?.viewState = { [weak self] state in
                DispatchQueue.main.async {
                    switch state {
                        
                    case .navigateToHome:
                        self?.performSegue(withIdentifier: "SPLASH_TO_HEROES",
                                           sender: nil)
                    case .navigateToLogin:
                        self?.performSegue(withIdentifier: "SPLASH_TO_LOGIN",
                                           sender: nil)
                        
                    }
                    
                    
                }
            }
        }
    }
}
