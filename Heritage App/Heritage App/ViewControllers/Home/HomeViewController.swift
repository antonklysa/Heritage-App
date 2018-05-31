//
//  HomeViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    
    @IBAction func startButtonAction(_ sender: Any) {
        let vc: CategoriesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CategoriesViewController.self)) as! CategoriesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
