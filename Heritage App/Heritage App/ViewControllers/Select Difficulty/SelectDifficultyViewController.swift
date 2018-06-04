//
//  SelectDifficultyViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class SelectDifficultyViewController: ReportViewController {

    var preparingForSegue : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.preparingForSegue = false
    }
    
    //MARK: Actions
    
    @IBAction func difficultyButtonAction(_ sender: UIButton) {
        let difficulty: Difficulty = Difficulty(rawValue: sender.tag)!
        self.report.channel = difficulty.reportStringValue()
        
        let vc: HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.report = self.report
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        self.showSettings()
    }
    
    //MARK: Private Methods
    
    private func showSettings() {
        let alertController = UIAlertController(title: "Please enter password", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Enter", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            firstTextField.isSecureTextEntry = true
            if (firstTextField.text == "9379992" || firstTextField.text == PMISessionManager.defaultManager.password) {
                DispatchQueue.main.async {
                    let vc : ConfigurationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let alertController = UIAlertController(title: "Error.", message: "Mot de passe incorrect", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Password"
            textField.keyboardType = UIKeyboardType.numberPad
            textField.isSecureTextEntry = true
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
