//
//  LoginViewController.swift
//  Authentic122
//
//  Created by Yaroslav Brekhunchenko on 5/4/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        // TESTING
        if TARGET_OS_SIMULATOR != 0 && self.usernameTextField.text!.count == 0 {
            UIApplication.shared.keyWindow!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectChannelViewController")
            return
        }
        
        let login : String = self.usernameTextField.text!
        let password: String = self.passwordTextField.text!
        if (login.count > 0 && password.count > 0) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            PMISessionManager.defaultManager.login(login: login, password: password, completion: { (error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if (error == nil) {
                    UIApplication.shared.keyWindow!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectChannelViewController")
                } else {
                    let alertController = UIAlertController(title: "Error.", message: error?.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        } else {
            self.usernameTextField.becomeFirstResponder()
        }
    }
    
}

