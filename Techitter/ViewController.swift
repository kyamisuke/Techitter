//
//  ViewController.swift
//  Techitter
//
//  Created by 村上航輔 on 2019/09/23.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var IDTextField: UITextField!
    
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
                postWatchViewController.IDName =  "匿メンター"
            }
        }
    }
}

