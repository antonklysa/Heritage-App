//
//  CredentianlsViewController.swift
//  MusicApp
//
//  Created by Yaroslav Brekhunchenko on 5/22/18.
//  Copyright © 2018 Yaroslav Brekhunchenko. All rights reserved.
//

import UIKit
import Mantle

class CredentialObject: MTLModel, MTLJSONSerializing {
    @objc var originalImageViewName: String?
    @objc var credentialURL: String?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "originalImageViewName": "originalImageViewName",
            "credentialURL": "credentialURL"]
    }
    
    @objc class func questionsJSONTransformer() -> ValueTransformer {
        return MTLJSONAdapter.arrayTransformer(withModelClass: GAQuestion.self)
    }
    
}

class CredentianlsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var credentials: [CredentialObject] = []
    
    //MARK: UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String = Bundle.main.path(forResource: "music_app_credentials", ofType: "json")!
        let url: URL = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let jsonDict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let credentials = try! MTLJSONAdapter.models(of: CredentialObject.self, fromJSONArray: jsonDict as! [Any]) as! [CredentialObject]
        self.credentials = credentials
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CredentialsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CredentialsCell.self)) as! CredentialsCell
        let credential: CredentialObject = self.credentials[indexPath.row]
        cell.originalImageView.image = UIImage(named: credential.originalImageViewName!)
        cell.credentialsButton.setTitle(credential.credentialURL, for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124.0
    }
    
    //MARK: Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
