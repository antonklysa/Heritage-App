//
//  Report+CoreDataProperties.swift
//  NN
//
//  Created by Yaroslav Brekhunchenko on 5/11/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var app: String?
    @NSManaged public var language: String?
    @NSManaged public var channel: String?
    @NSManaged public var level: String?
    @NSManaged public var time: Date?
    @NSManaged public var city: String?
    @NSManaged public var selectedCardIndex: Int64

}
