//
//  DataStoreManager.swift
//  NN
//
//  Created by Yaroslav Brekhunchenko on 3/26/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

enum Team : Int {
    case POS
    case CS
    
    func reportStringValue() -> String {
        switch self {
        case .POS: return "POS team"
        case .CS: return "CS team"
        }
    }
}

enum Difficulty: Int {
    case OnePack
    case TwoPacks
    case ThreePacks
    
    func reportStringValue() -> String {
        switch self {
        case .OnePack: return "One Pack"
        case .TwoPacks: return "Two Packs"
        case .ThreePacks: return "Three Packs"
        }
    }
}

class DataStoreManager: NSObject {

    static let sharedInstance = DataStoreManager()
    
    // MARK: CoreData Stack
    
    public var managedObjectContext: NSManagedObjectContext!
    
    func saveContext () {
        let context = self.managedObjectContext
        if context!.hasChanges {
            do {
                try context!.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    override init() {
        super.init()
        
        self.setupCoreDataStack()
    }
    
    //MARK: Setup
    
    private func setupCoreDataStack() {
        guard let modelURL = Bundle.main.url(forResource: "HeritageLog", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel.init(contentsOf: modelURL) else {
            fatalError("Error initializing mom")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex - 1]
        
        let storeURL = docURL.appendingPathComponent("HeritageLog.sqlite")
        
        let opt: Dictionary<String, Bool> = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: opt)
        } catch {
            fatalError("Error migrating store")
        }
    }
    
    //MARK: Public Methods
    
    func createNewReportEntity() -> Report {
        let report: Report = NSEntityDescription.insertNewObject(forEntityName: Report.entityName(), into: self.managedObjectContext) as! Report
        report.app = "Heritage"
        return report
    }
    
}
