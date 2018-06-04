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

enum ChannelType : String {
    case POS
    case Souk
    case CoffeeShops
    case Festivals
    case WorldCup
    case Universities
    case LAMP
}

enum AppLanguage : String {
    case French
    case Arabic
}

class DataStoreManager: NSObject {

    static let sharedInstance = DataStoreManager()

    var selectedAppLanguage : AppLanguage {
        get {
            let value = UserDefaults.standard.string(forKey: "AppLanguage")
            if (value == nil) {
                UserDefaults.standard.set(AppLanguage.French.rawValue, forKey: "AppLanguage")
                UserDefaults.standard.synchronize()
                return AppLanguage(rawValue: UserDefaults.standard.string(forKey: "AppLanguage")!)!
                
            }
            return AppLanguage(rawValue: value!)!
        }
        set(v) {
            UserDefaults.standard.set(v.rawValue, forKey: "AppLanguage")
            UserDefaults.standard.synchronize()
            
            self.updateSelectedChannel()
        }
    }
    
    var selectedCity : String {
        get {
            let value = UserDefaults.standard.string(forKey: "SelectedCity")
            if (value == nil) {
                UserDefaults.standard.set("Marrakesh", forKey: "SelectedCity")
                UserDefaults.standard.synchronize()
                return UserDefaults.standard.string(forKey: "SelectedCity")!
                
            }
            return value!
        }
        set(v) {
            UserDefaults.standard.set(v, forKey: "SelectedCity")
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedChannelType : ChannelType {
        get {
            let value = UserDefaults.standard.string(forKey: "ChannelType")
            if (value == nil) {
                UserDefaults.standard.set(ChannelType.Souk.rawValue, forKey: "ChannelType")
                UserDefaults.standard.synchronize()
                return ChannelType(rawValue: UserDefaults.standard.string(forKey: "ChannelType")!)!
                
            }
            return ChannelType(rawValue: value!)!
        }
        set(v) {
            UserDefaults.standard.set(v.rawValue, forKey: "ChannelType")
            UserDefaults.standard.synchronize()
            
            self.updateSelectedChannel()
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
        self.updateSelectedChannel()
    }
    
    //MARK: Setup
    
    private func setupCoreDataStack() {
        guard let modelURL = Bundle.main.url(forResource: "NN", withExtension: "momd") else {
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
        
        let storeURL = docURL.appendingPathComponent("NN.sqlite")
        
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
        report.app = "NN"
        return report
    }
    
    //MARK: Private Methods
    
    private func updateSelectedChannel() {
        let fileName : String = String(format: "%@_%@", self.selectedChannelType.rawValue.lowercased(), self.selectedAppLanguage.rawValue.lowercased())
        let file = Bundle.main.url(forResource: fileName, withExtension: "json")
        let data = try! Data(contentsOf: file!)
        let json = try! JSON(data: data)
        
        let channel : Channel = Channel(dictionary: json)
        self.selectedChannel = channel
    }
    
    private(set) var selectedChannel : Channel?
}
