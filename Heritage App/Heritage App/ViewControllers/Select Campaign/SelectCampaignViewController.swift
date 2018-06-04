//
//  SelectCampaignViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class SelectCampaignViewController: ReportViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.report = DataStoreManager.sharedInstance.createNewReportEntity()
    }
    
    //MARK: Actions
    
    @IBAction func campaignButtonAction(_ sender: UIButton) {
        let team: Team = Team(rawValue: sender.tag)!
        self.report.team = team.reportStringValue()
        
        let vc: SelectDifficultyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectDifficultyViewController.self)) as! SelectDifficultyViewController
        vc.report = self.report
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
