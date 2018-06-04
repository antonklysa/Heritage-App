//
//  Report+CoreDataProperties.swift
//  Heritage App
//
//  Created by Yaroslav Brekhunchenko on 6/4/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var app: String?
    @NSManaged public var team: String?
    @NSManaged public var channel: String?
    @NSManaged public var time: NSDate?

}
