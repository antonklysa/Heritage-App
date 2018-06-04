//
//  ReportViewController.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 6/4/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

protocol ReportProtocol {
    var report: Report! {get set}
}

class ReportViewController: BaseViewController, ReportProtocol {

    var report: Report!

}
