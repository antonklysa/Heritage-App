//
//  Question.swift
//  Generations App
//
//  Created by Anton Klysa on 3/10/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import Mantle

class Question: MTLModel, MTLJSONSerializing {
    
    @objc var id: NSNumber?
    @objc var imageNameString: String?
    @objc var isRightAnswer: NSNumber?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "id": "id",
            "imageNameString": "image",
            "isRightAnswer": "is_right_answer"]
    }
}
