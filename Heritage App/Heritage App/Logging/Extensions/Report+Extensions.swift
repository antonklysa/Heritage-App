//
//  Report+Extensions.swift
//  NN
//
//  Created by Yaroslav Brekhunchenko on 5/11/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//

import Foundation
import CoreData

extension Report {
    
    static func entityName() -> String {
        return "Report"
    }
    
    static func listOfAllReports() -> [Report] {
        let fetchRequest : NSFetchRequest<Report> = Report.fetchRequest()
        do {
            let reports = try DataStoreManager.sharedInstance.managedObjectContext.fetch(fetchRequest)
            var listOfValidReports: [Report] = []
            for report in reports {
                if (report.isValidReport()) {
                    listOfValidReports.append(report)
                }
            }
            return listOfValidReports
        } catch {
            return []
        }
    }
 
    func dictFromReport() -> [String : Any] {
        var reportDict : [String : Any] = [:]
        reportDict["Host Name"] = DataStoreManager.sharedInstance.hostName
        reportDict["Theme Selected"] = self.themeSelected
        reportDict["Touchpoint"] = DataStoreManager.sharedInstance.team!.reportStringValue()
        
        reportDict["City"] = DataStoreManager.sharedInstance.cityName
        reportDict["Level"] = self.channel
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let time: NSDate = self.time {
            reportDict["Time-Date"] = dateFormatter.string(from: time as Date)
        } else {
            reportDict["Time"] = "Unknown"
        }
        
        return reportDict
    }
    
    func isValidReport() -> Bool {
        if (self.channel != nil && self.time != nil && self.themeSelected != nil) {
            return true
        } else {
            return false
        }
    }
    
}
