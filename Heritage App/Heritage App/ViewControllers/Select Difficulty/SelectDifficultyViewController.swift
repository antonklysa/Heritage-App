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
        
        PMISessionManager.sharedInstance.syncReports { (error) in
            if (error == nil) {
                print("Sync completed successfuly.")
            } else {
                print("Sync ERROR. \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.report = DataStoreManager.sharedInstance.createNewReportEntity()
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
        let vc: ConfigurationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ConfigurationViewController.self)) as! ConfigurationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
