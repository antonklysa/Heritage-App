//
//  LoseViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class LoseViewController: ReportViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.report.time = NSDate()
        DataStoreManager.sharedInstance.saveContext()
    }
    
    //MARK: Actions
    
    @IBAction func finishButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
