//
//  ViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 13/10/23.
//

import UIKit
protocol LoginViewControllerProtocol {
    func loginButtonAction(email: String, password: String)
}
class LoginViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailLabelError: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordLabelError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   

    @IBAction func loginButtonAction() {
      email: emailTextfield.text
    password: passwordTextfield.text
    }
    
   
}

