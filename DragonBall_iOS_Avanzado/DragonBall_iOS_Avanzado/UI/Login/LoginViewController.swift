//
//  ViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 13/10/23.
//

import UIKit

// MARK: - Protocol
protocol LoginViewControllerDelegate {
    var viewState: ((LoginViewState) -> Void)? {get set}
    func onLoginPressed(email: String?, password: String?)
    //var heroesViewModel: HeroesViewControllerDelegate { get }
}

// MARK: - Enum state
enum LoginViewState {
    case loading(_ isLoading: Bool)
    case showErrorEmail(_ error: String?)
    case showErrorPassword (_ error: String?)
    case navigateToHeroes
}
// MARK: - Class
class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailLabelError: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordLabelError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    //MARK: - Properties
    var viewModel: LoginViewControllerDelegate?
    
    // MARK: - Enum textField
    private enum FieldType {
        static let email = 0
        static let password = 1
    }
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setObservers()
    }
    
    // MARK: - public functions
    @IBAction func onLoginPressed() {
        viewModel?.onLoginPressed(
            email: emailTextfield.text ?? "",
            password: passwordTextfield.text ?? "")
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    // MARK: - private functions
    private func setViews(){
        emailTextfield.delegate = self
        emailTextfield.tag = FieldType.email
        passwordTextfield.delegate = self
        passwordTextfield.tag = FieldType.password
        
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyBoard)))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
   
//        guard segue.identifier == "LOGIN_TO_HEROES",
//              let heroesViewController = segue.destination as? HeroesViewController else {
//            return
//        }
//        heroesViewController.viewModel = viewModel?.heroesViewModel
//    }
  }
    private func setObservers() {
        viewModel?.viewState = { state in
            switch state{
            case .loading(let isLoading):
                self.loadingView.isHidden = !isLoading
                break
            case .showErrorEmail(let error):
                self.emailLabelError.text = error
                if let error, !error.isEmpty {
                    self.emailLabelError.isHidden = false
                } else {
                    self.emailLabelError.isHidden = true
                }
                break
            case .showErrorPassword(let error):
                break
            case .navigateToHeroes:
                self.loadingView.isHidden = true
                self.performSegue(withIdentifier: "LOGIN_TO_HEROES",
                                   sender: nil)
                break
            }
        }
    }
}
 
// MARK: - Extension
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == FieldType.email {
            emailLabelError.isHidden = true
        } else if textField.tag == FieldType.password{
            passwordLabelError.isHidden = true
        }
    }
}



