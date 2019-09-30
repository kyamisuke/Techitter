//
//  ViewController.swift
//  Techitter
//
//  Created by 村上航輔 on 2019/09/23.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var IDTextField: UITextField!
    var ref: DatabaseReference!
    var contentNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    // 値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostView" {
            let postWatchViewController = segue.destination as! PostWatchViewController
            let IDName: String = IDTextField.text!
            
            if IDName != "" {
                postWatchViewController.IDName = IDTextField.text
            } else {
                // 匿名処理
                postWatchViewController.IDName =  "匿メンター"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

