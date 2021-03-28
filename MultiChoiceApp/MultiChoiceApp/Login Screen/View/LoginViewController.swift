//
//  LoginViewController.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var backgroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var backgroundTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var userNameInputField: UITextField!
    @IBOutlet private var passwordInputField: UITextField!
    
    private lazy var viewModel = LoginViewModel(delegate: self,
                                                loginService: LoginService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameInputField.delegate = self
        passwordInputField.delegate = self
        animateSetup()
        startBackgroundAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriendsSegue" {
            if let destVC = segue.destination as? UINavigationController,
               let targetController = destVC.topViewController as? FriendsViewController {
                targetController.set(dataTransportModel: viewModel.dataTransportModel)
            }
            
        }
    }
    
    @IBAction private func loginButtonTapped(_ sender: Any) {
        viewModel.performLogin()
    }
    
    private func animateSetup() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func startBackgroundAnimation() {
        self.backgroundLeadingConstraint.constant -= 1000
        UIView.animate(withDuration: 10) {
            self.view.layoutIfNeeded()
        } completion: { (Bool) in
            self.backgroundLeadingConstraint.constant += 1000
            UIView.animate(withDuration: 10) {
                self.view.layoutIfNeeded()
            } completion: { (Bool) in
                self.startBackgroundAnimation()
            }
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func proceedToNextScreen() {
        performSegue(withIdentifier: "showFriendsSegue", sender: self)
    }
    
    func showLoginError(message: String) {
        let alert = UIAlertController(title: "Error!",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
