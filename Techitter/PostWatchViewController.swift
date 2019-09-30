//
//  PostWatchViewController.swift
//  Techitter
//
//  Created by 村上航輔 on 2019/09/25.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

// MARK: - Coding

import UIKit
import Firebase
import FirebaseAuth

class PostWatchViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {
    // 変数宣言
    var IDName: String!
    @IBOutlet weak var IDNameLabel: UILabel!
    @IBOutlet weak var PostTextField: UITextField!
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var hideView: UIView!
    
    var ref: DatabaseReference!
    var PostText: String!
    var nameArray = [String]()
    var postArray = [String]()
    var reverseNameArray = [String]()
    var reversePostArray = [String]()
    

    /* debug変数 */ var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start viewDidLoad")

        // Do any additional setup after loading the view.
        
        // variable update
        IDNameLabel.text = IDName
        ref = Database.database().reference()
        
        // table set
        table.dataSource = self
        table.delegate = self
        PostTextField.delegate = self
        table.register(UINib(nibName: "CustumnTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        /*デバッグ変数初期化*/ self.count = 0
        // rootの監視 childAddedは木構造に子が追加された時に発動するoption
        ref.child("userData").observe(.childAdded, with: { snapshot in
            print("\(self.count): start observe: viewDidload\n")
            let name = String(describing: snapshot.childSnapshot(forPath: "username").value!)
            let post = String(describing: snapshot.childSnapshot(forPath: "Post").value!)
            self.nameArray.append(name)
            self.postArray.append(post)
            
            // 配列を逆順に
            self.reverseNameArray = self.nameArray.reversed()
            self.reversePostArray = self.postArray.reversed()
            print("\(self.nameArray) + \(self.postArray)")
            self.count += 1
            self.table.reloadData()

         })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("start viewWillAppear")
        super.viewWillAppear(animated)

        // Cellの高さを調節
        table.estimatedRowHeight = 56
        table.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 画面が消えたときに、Firebaseのデータ読み取りのObserverを削除しておく
        ref.removeAllObservers()
    }
    
    // Firebaseへ書き込み
    @IBAction func send(_ sender: Any) {
        PostText = PostTextField.text
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
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("[tableView] children num... \(self.nameArray.count)")
        return nameArray.count
    }
        
    // セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // nilの処理をする必要あり
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustumnTableViewCell {
            print("index: \(indexPath.row)")
            if !self.nameArray.isEmpty && !self.postArray.isEmpty {
                let name = self.reverseNameArray[indexPath.row]
                let post = self.reversePostArray[indexPath.row]
    //          cell.updateCellInformation(userName: name, post: post)
                cell.userNameLabel.text = name
                cell.postLabel.text = post
            }
            
            return cell
        }
            
        return UITableViewCell()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            textField.center.y -= 450
            self.hideView.alpha = 0.7
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            textField.center.y += 450
            self.hideView.alpha = 0.0
        }
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
