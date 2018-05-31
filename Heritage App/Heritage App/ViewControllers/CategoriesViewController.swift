//
//  CategoriesViewController.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import Mantle

enum CategoryButtonType: String {
    case typeMusic = "music"
    case typeFood = "food"
    case typeClothes = "clothes"
}

class CategoriesViewController: BaseViewController {
    
    @IBOutlet weak var musicCategoryButton: UIButton!
    @IBOutlet weak var foodCategoryButton: UIButton!
    @IBOutlet weak var clothesCategoryButton: UIButton!
    
    private var selectedType: CategoryButtonType!
    
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: IBactions
    
    @IBAction private func buttonAction(sender: UIButton) {
        
        let VCIdentifier: String = GameViewController.nameOfClass
        let gameVC: GameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: VCIdentifier) as! GameViewController
        gameVC.questions = jsonObjectsArrayByButtonType(button: sender)
        gameVC.gameType = selectedType
        navigationController?.pushViewController( gameVC, animated: true)
    }
    
    
    //MARK: private funcs
    
    fileprivate func jsonObjectsArrayByButtonType(button: UIButton) -> [Question]? {
        
        //parsing json into array
        let path: String = Bundle.main.path(forResource: "package_json", ofType: "json")!
        let url: URL = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let jsonDict: [String: AnyObject] = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
        print(jsonDict)
        if button.isEqual(musicCategoryButton) {
            selectedType = CategoryButtonType.typeMusic
            return try! MTLJSONAdapter.models(of: Question.self, fromJSONArray: jsonDict[selectedType.rawValue] as! [Any]) as! [Question]
        } else if button.isEqual(foodCategoryButton)  {
            selectedType = CategoryButtonType.typeFood
            return try! MTLJSONAdapter.models(of: Question.self, fromJSONArray: jsonDict[selectedType.rawValue] as! [Any]) as! [Question]
        } else if button.isEqual(clothesCategoryButton) {
            selectedType = CategoryButtonType.typeClothes
            return try! MTLJSONAdapter.models(of: Question.self, fromJSONArray: jsonDict[selectedType.rawValue] as! [Any]) as! [Question]
        }
        
        return nil
    }
}
