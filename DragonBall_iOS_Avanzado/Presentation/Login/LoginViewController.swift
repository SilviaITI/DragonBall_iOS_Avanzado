//
//  LoginViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import UIKit
protocol LoginViewControllerDelegate {
    var viewState:((LoginViewState) -> Void)? {get set}
    var homeViewModel: HomeViewControllerDelegate { get }
    func onLoginPressed(email: String?, password: String?)
}
enum LoginViewState {
    case loading(_ isLoading: Bool)
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case navigateToNext
}
class LoginViewController: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Actions -
    @IBAction func onLoginPressed(_ sender: Any) {
        viewModel?.onLoginPressed(
            email: emailTextfield.text,
            password: passwordTextfield.text)
        
    }
    
    // MARK: - Properties -
    var viewModel: LoginViewControllerDelegate?
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setObservers()
    }
    
    // MARK: - Functions -
    private func initViews() {
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        )
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async{
                switch state {
                case .loading(let isLoading) :
                    self?.loadingView.isHidden = !isLoading
                case .showErrorEmail(let error):
                    self?.errorEmailLabel.text = error
                    self?.errorEmailLabel.isHidden = (error == nil || error?.isEmpty == true)
                case .showErrorPassword(let error):
                    self?.errorPasswordLabel.text = error
                    self?.errorPasswordLabel.isHidden = (error == nil || error?.isEmpty == true)
                case .navigateToNext:
                    self?.loadingView.isHidden = true
                    self?.navigateToNext()
                }
            }
        }
    }
    
  
     // MARK: - Navigation -
     
    func navigateToNext() {
        let home = HomeViewController()
        home.viewModel = self.viewModel?.homeViewModel
        navigationController?.setViewControllers([home], animated: true)
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextfield == textField {
            errorEmailLabel.isHidden
        } else   if passwordTextfield == textField {
            errorPasswordLabel.isHidden
        }
    }
}
