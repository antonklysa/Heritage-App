//
//  SelectDifficultyViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class SelectDifficultyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    
    @IBAction func difficultyButtonAction(_ sender: Any) {
        let vc: HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        
    }
    
}
