//
//  PMISessionManager.swift
//  PMI
//
//  Created by Yaroslav Brekhunchenko on 11/17/17.
//  Copyright © 2017 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON
import CHCSVParser
import Firebase
import FirebaseCore


class PMISessionManager: NSObject {

    static let sharedInstance = PMISessionManager()
    
    var storageRef : StorageReference?
    var ref : DatabaseReference?
    
    override init() {
        super.init()
        
        self.storageRef = Storage.storage().reference()
        self.ref = Database.database().reference()
    }
    
    func syncReports(completion:@escaping(Error?) -> ()) {
        let listOfAllReports : [Report] = Report.listOfAllReports()
        if (listOfAllReports.count == 0) {
            return
        }
        
        let stream : OutputStream = OutputStream.toMemory()
        let writer : CHCSVWriter = CHCSVWriter(outputStream: stream, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
        var data : [[String : Any]] = []
        for report in listOfAllReports {
            if report.isValidReport() {
                let userDict : [String : Any] = report.dictFromReport()
                data.append(userDict)
            }
        }
        
        let keys = Array(data.first!.keys)
        writer.writeLine(ofFields: keys as NSFastEnumeration)
        for dict in data {
            for key in keys {
                let value = dict[key]
                writer.writeField(value)
            }
            writer.finishLine()
        }
        writer.closeStream()
        
        let contents = stream.property(forKey: .dataWrittenToMemoryStreamKey)
        let csvString = String(data: contents as! Data, encoding: String.Encoding.utf8)
        
        let file = "Report.csv"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            do {
                try csvString?.write(to: fileURL, atomically: false, encoding: .utf8)
                
                Auth.auth().signInAnonymously(completion: { (user, authError) in
                    if (authError == nil) {
                        let child : String = String(format : "Report_%@.csv", Auth.auth().currentUser!.uid)
                        self.storageRef?.child(child).putFile(from: fileURL, metadata: nil, completion: { (metadata, uploadingError) in
                            completion(uploadingError)
                            DataStoreManager.sharedInstance.syncDate = NSDate()
                        })
                    } else {
                        completion(authError)
                    }
                })
            }
            catch {}
        }
        
    }
    
}
