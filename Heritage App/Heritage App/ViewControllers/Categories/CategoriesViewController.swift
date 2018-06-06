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

class CategoriesViewController: ReportViewController {
    
    @IBOutlet weak var musicCategoryButton: UIButton!
    @IBOutlet weak var foodCategoryButton: UIButton!
    @IBOutlet weak var clothesCategoryButton: UIButton!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var rulesImageView: UIImageView!
    
    private var selectedType: CategoryButtonType!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    
    @IBAction private func buttonAction(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.musicCategoryButton.alpha = 0.0
            self.foodCategoryButton.alpha = 0.0
            self.clothesCategoryButton.alpha = 0.0
            self.titleImageView.alpha = 0.0
        }) { (flag) in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.rulesImageView.alpha = 1.0
            }, completion: { (flag) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.showGame(sender)
                }
            })
        }
    }
    
    func showGame(_ sender: UIButton) {
        let VCIdentifier: String = GameViewController.nameOfClass
        let gameVC: GameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: VCIdentifier) as! GameViewController
        gameVC.questions = jsonObjectsArrayByButtonType(button: sender)
        gameVC.gameType = selectedType
        gameVC.report = self.report
        if sender.isEqual(musicCategoryButton) {
            self.report.themeSelected = "Instruments"
        } else if sender.isEqual(foodCategoryButton)  {
            self.report.themeSelected = "Food"
        } else if sender.isEqual(clothesCategoryButton) {
            self.report.themeSelected = "Cloathes"
        }
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
