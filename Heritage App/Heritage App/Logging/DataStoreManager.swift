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
    case CS
    case POS
    
    func reportStringValue() -> String {
        switch self {
        case .POS: return "POS team"
        case .CS: return "CS team"
        }
    }
}

enum Difficulty: Int {
    case OneStick
    case OnePack
    case TwoPacks
    case ThreePacks
    
    func reportStringValue() -> String {
        switch self {
        case .OneStick: return "One Stick"
        case .OnePack: return "One Pack"
        case .TwoPacks: return "Two Packs"
        case .ThreePacks: return "Three Packs"
        }
    }
}

class DataStoreManager: NSObject {

    static let sharedInstance = DataStoreManager()
    
    var team : Team? {
        get {
            let value: Int? =  UserDefaults.standard.object(forKey: "team") as? Int
            if (value == nil) {
                return Team.CS
            }
            return Team(rawValue: value!)
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue?.rawValue, forKey: "team")
            defaults.synchronize()
        }
    }
    
    var difficulty : Difficulty? {
        get {
            let value: Int? =  UserDefaults.standard.object(forKey: "difficulty") as? Int
            if (value == nil) {
                return Difficulty.OnePack
            }
            return Difficulty(rawValue: value!)
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue?.rawValue, forKey: "difficulty")
            defaults.synchronize()
        }
    }
    
    var hostName : String? {
        get {
            let value: String? =  UserDefaults.standard.object(forKey: "hostName") as? String
            if value == nil {
                return ""
            }
            return value
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "hostName")
            defaults.synchronize()
        }
    }
    
    var cityName : String? {
        get {
            let value: String? =  UserDefaults.standard.object(forKey: "cityName") as? String
            if value == nil {
                return "Casablanca"
            }
            return value
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "cityName")
            defaults.synchronize()
        }
    }
    
    var syncDate : NSDate? {
        get {
            let value: NSDate? =  UserDefaults.standard.object(forKey: "date") as? NSDate
            return value
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "date")
            defaults.synchronize()
        }
    }
    
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
