//
//  ViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 13/10/23.
//

import UIKit

// Mark: - Protocol
protocol LoginViewControllerDelegate {
    var viewState: ((LoginViewState) -> Void)? {get set}
    func onLoginPressed(email: String?, password: String?)
}

enum LoginViewState {
    case loading(_ isLoading: Bool)
    case showErrorEmail(_ error: String?)
    case showErrorPassword (_ error: String?)
    case navigateToHeroes
}
class LoginViewController: UIViewController {

    //Mark: - Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailLabelError: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordLabelError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    //Mark: - Properties
    var viewModel: LoginViewControllerDelegate?
    
    //Mark: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setObservers()
        // Do any additional setup after loading the view.
    }
    
    // Marj
    @IBAction func onLoginPressed() {
        viewModel?.onLoginPressed(
            email: emailTextfield.text ?? "",
    password: passwordTextfield.text ?? "")
    }
 
    private func setViews(){
        emailTextfield.delegate = self
        emailTextfield.tag = 0
        passwordTextfield.delegate = self
        passwordTextfield.tag = 0
        
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyBoard)))
    }
   @objc func dismissKeyBoard() {
       view.endEditing(true)
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
                break
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if emailTextfield == textField {
//            emailLabelError.isHidden = true
//        } else if passwordTextfield ==  textField {
//            passwordLabelError.isHidden = true
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch reason {
        case .committed:
          if  emailTextfield == textField {
                emailLabelError.isHidden = true
            }
           if passwordTextfield == textField {
                passwordLabelError.isHidden = true
            }
        @unknown default:
            print("Error al introducir los datos")
        }
    }
}

