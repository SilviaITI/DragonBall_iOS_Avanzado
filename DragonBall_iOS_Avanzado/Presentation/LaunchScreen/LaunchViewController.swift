//
//  LaunchViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import UIKit

// MARK: - Protocol -
protocol LaunchViewControllerDelegate {
    var viewState:((LaunchViewState) -> Void)? {get set}
    var loginViewModel: LoginViewControllerDelegate { get }
    var homeViewModel: HomeViewControllerDelegate { get }
    func onViewAppear()
}

// MARK: - Enum States -
enum LaunchViewState {
    case loading(_ isLoading: Bool)
    case navigateToLogin
    case navigateToHome
}

//MARK: - Class -
class LaunchViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Properties -
    var viewModel: LaunchViewControllerDelegate?
    
    // MARK: - LyfeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewAppear()
        setObservers()
    }
    
    // MARK: - Functions -
    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                case .navigateToHome :
                    self?.navigateToHome()
                case .navigateToLogin:
                    self?.navigateToLogin()
                }
            }
        }
    }
    
    // MARK: - Navigation -
    private func navigateToLogin() {
        DispatchQueue.main.async {
            let loginViewController = LoginViewController()
            loginViewController.viewModel = self.viewModel?.loginViewModel
            self.navigationController?.setViewControllers([loginViewController], animated: true)
        }
    }
    
    private func navigateToHome() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            homeViewController.viewModel = self.viewModel?.homeViewModel
            self.navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
}
