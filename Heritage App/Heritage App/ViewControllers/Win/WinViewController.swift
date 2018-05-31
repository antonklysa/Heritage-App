//
//  WinViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class WinViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions

    @IBAction func finishButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
