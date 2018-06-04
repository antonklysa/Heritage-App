//
//  SelectCampaignViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class SelectCampaignViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    
    @IBAction func campaignButtonAction(_ sender: UIButton) {
//        let selectedCampaign: HeritageCampaign = HeritageCampaign(rawValue: sender.tag)!
//        PMISessionManager.defaultManager.teamName = selectedCampaign.apiTitle()
        
        let vc: SelectDifficultyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectDifficultyViewController.self)) as! SelectDifficultyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
