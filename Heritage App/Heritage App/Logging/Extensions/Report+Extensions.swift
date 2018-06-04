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
        reportDict["App"] = self.app
        reportDict["Language"] = self.language
        reportDict["Channel"] = self.channel
        reportDict["Level"] = self.level
        reportDict["SelectedCard"] = String(self.selectedCardIndex)
        reportDict["City"] = self.city
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let time: Date = self.time {
            reportDict["Time"] = dateFormatter.string(from: time)
        } else {
            reportDict["Time"] = "Unknown"
        }
        
        return reportDict
    }
    
    func isValidReport() -> Bool {
        if (self.app != nil && self.language != nil && self.channel != nil && self.level != nil && self.time != nil) {
            return true
        } else {
            return false
        }
    }
    
}
