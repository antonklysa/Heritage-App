//
//  Report+CoreDataProperties.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 6/6/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var channel: String?
    @NSManaged public var team: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var hostName: String?
    @NSManaged public var themeSelected: String?
    @NSManaged public var city: String?
    @NSManaged public var isWin: Bool

}
