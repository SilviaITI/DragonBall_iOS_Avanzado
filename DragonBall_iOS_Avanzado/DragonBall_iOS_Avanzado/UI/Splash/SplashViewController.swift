//
//  SplashViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//

import UIKit
import KeychainSwift



    // MARK: Protocol
    protocol SplashViewControllerDelegate {
        func onViewsAppear()
        //var heroesViewModel: HeroesViewControllerDelegate { get }
        var loginViewModel: LoginViewControllerDelegate { get }
        var viewState: ((SplashViewState) -> Void)? { get set }
    }

    // MARK: Enum
    enum SplashViewState {
        case isLoading(loading: Bool)
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
            viewModel?.onViewsAppear()
           
        }
        // comprobar si tengo que borrar
        override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)

             navigationController?.setNavigationBarHidden(true, animated: animated)
         }
        
      
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            switch segue.identifier {
                case "SPLASH_TO_LOGIN":
                    guard let loginViewController = segue.destination as? LoginViewController else { return }
                    loginViewController.viewModel = viewModel?.loginViewModel

//                case "SPLASH_TO_HEROES":
//                    guard let heroesViewController = segue.destination as? HeroesViewController else { return }
//                    heroesViewController.viewModel = viewModel?.heroesViewModel

                default:
                    break
            }
        }
            
        
        
        // MARK: Public functions
        //
        private func setObservers() {
            viewModel?.viewState = { [weak self] state in
                DispatchQueue.main.async {
                    switch state {
                        
//                    case .navigateToHome:
//                        self?.performSegue(withIdentifier: "SPLASH_TO_HEROES",
//                                           sender: nil)
                    case .navigateToLogin:
                        self?.performSegue(withIdentifier: "SPLASH_TO_LOGIN",
                                           sender: nil)
                        
                    case .isLoading(loading: let loading):
                        print(loading)
                    case .navigateToHome:
                        print("hola")
                    }
                    
                    
                }
            }
        }
    }

