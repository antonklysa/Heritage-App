//
//  CredentialsCell.swift
//  MusicApp
//
//  Created by Yaroslav Brekhunchenko on 5/22/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import Mantle

class CredentialsCell: UITableViewCell {

    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var credentialsButton: UIButton!
    
    @IBAction func credentialsButtonAction(_ sender: Any) {
        if let url = URL(string: self.credentialsButton.title(for: .normal)!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
}
