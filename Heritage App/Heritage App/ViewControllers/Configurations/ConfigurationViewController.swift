//
//  ConfigurationViewController.swift
//  PMI
//
//  Created by Yaroslav Brekhunchenko on 11/17/17.
//  Copyright © 2017 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import ActionSheetPicker_3_0

class ConfigurationViewController: BaseViewController {

    @IBOutlet weak var touchpointKaButton: UIButton!
    @IBOutlet weak var touchpointPosButton: UIButton!
    @IBOutlet weak var lastSyncLabel: UILabel!
    @IBOutlet weak var citySelectedLabel: UILabel!
    @IBOutlet weak var hostNameTextField: UITextField!
    
    //MARK: UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentTeam: Team = DataStoreManager.sharedInstance.team {
            if currentTeam == Team.CS {
                self.touchpointPosButton.isSelected = false
                self.touchpointKaButton.isSelected = true
            } else if currentTeam == Team.POS {
                self.touchpointPosButton.isSelected = true
                self.touchpointKaButton.isSelected = false
            }
        }
        
        self.citySelectedLabel.text = DataStoreManager.sharedInstance.cityName
        
        if let lastSyncDate: NSDate = DataStoreManager.sharedInstance.syncDate {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.lastSyncLabel.text = dateFormatter.string(from: lastSyncDate as Date)
        } else {
            self.lastSyncLabel.text = "-"
        }
    }
    
    private func selectTeam(_ team: Team) {
        if (team == .POS) {
            self.touchpointPosButton.isSelected = true
            self.touchpointKaButton.isSelected = false
        } else {
            self.touchpointPosButton.isSelected = false
            self.touchpointKaButton.isSelected = true
        }
        
        DataStoreManager.sharedInstance.team = team
    }
    
    //MARK: Actions
    
    @IBAction func touchpointButtonAction(_ sender: UIButton) {
        let team: Team = Team(rawValue: sender.tag)!
        self.selectTeam(team)
    }
    
    @IBAction func selectCityButtonAction(_ sender: UIButton) {
        let delegateOptions = ["Casablanca",
                               "Rabat",
                               "Marrakesh",
                               "Tanger",
                               "Fès",
                               "Agadir",
                               "Salé",
                               "Meknès",
                               "Tétouan",
                               "Chefchaouen",
                               "Nador",
                               "Al hoceima",
                               "Kénitra",
                               "El Jadida",
                               "Oujda",
                               "Taza",
                               "Témara",
                               "Mohammédia",
                               "Béni Mellal",
                               "Essaouira",
                               "Khouribga",
                               "Safi",
                               "Nador",
                               "Ouarzazate",
                               "Settat",
                               "Larache",
                               "Ifran",
                               "Errachidia"]
        ActionSheetStringPicker.show(withTitle: "Choose a city :", rows: delegateOptions, initialSelection: 0, doneBlock: {
            picker, index, selectedValue in
            
            DataStoreManager.sharedInstance.cityName = selectedValue as! String
            self.citySelectedLabel.text = selectedValue as! String
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func syncButtonAction(_ sender: Any) {
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ConfigurationViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let hostName: String = textField.text {
            DataStoreManager.sharedInstance.hostName = hostName
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
}
