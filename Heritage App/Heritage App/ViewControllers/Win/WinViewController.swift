//
//  WinViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 5/31/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class WinViewController: ReportViewController {

    @IBOutlet weak var heritageImageView: UIImageView!
    @IBOutlet weak var chesterfieldImageView: UIImageView!
    @IBOutlet weak var packImageView: UIImageView!
    @IBOutlet weak var lastImageView: UIImageView!
    @IBOutlet weak var disconnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disconnectButton.alpha = 0.0
        self.lastImageView.alpha = 0.0
        self.packImageView.alpha = 0.0
        self.chesterfieldImageView.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.75, delay: 0.7, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.heritageImageView.alpha = 0
        }) { (flag) in
            UIView.animate(withDuration: 0.75, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.packImageView.alpha = 1.0
                self.chesterfieldImageView.alpha = 1.0
            }, completion: { (flag) in
                UIView.animate(withDuration: 0.75, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.chesterfieldImageView.alpha = 0.0
                }, completion: { (flag) in
                    UIView.animate(withDuration: 0.75, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.lastImageView.alpha = 1.0
                        self.disconnectButton.alpha = 1.0
                    }, completion: { (flag) in
                        //
                    })
                })
            })
        }
        
//        self.report.time = NSDate()
//        DataStoreManager.sharedInstance.saveContext()
    }
    
    //MARK: Actions

    @IBAction func finishButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
