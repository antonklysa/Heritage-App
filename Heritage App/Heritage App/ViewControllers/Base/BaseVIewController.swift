//
//  BaseVIewController.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup controller props
        navigationController?.isNavigationBarHidden = true
    }
}
