//
//  PostWatchViewController.swift
//  Techitter
//
//  Created by 村上航輔 on 2019/09/25.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PostWatchViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    var IDName: String!
    @IBOutlet weak var IDNameLabel: UILabel!
    @IBOutlet weak var PostTextField: UITextField!
    
    @IBOutlet var table: UITableView!
    
    var ref: DatabaseReference!
    var PostText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        IDNameLabel.text = IDName
        table.dataSource = self
        PostTextField.delegate = self
        ref = Database.database().reference()
        
    }
    
    // Firebaseへ書き込み
    @IBAction func send(_ sender: Any) {
        PostText
            = PostTextField.text
        if PostText == "" {
            // アラート処理
            let alert = UIAlertController(title: "空欄のままです", message: "テキストを入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("press OK")
                })
            )
            
            present(alert, animated: true, completion: nil)
        } else {
            self.ref.child("userData").childByAutoId().setValue(["username": IDName, "Post" : PostText])
            PostTextField.text = ""
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "test"
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
