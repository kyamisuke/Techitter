
//
//  CustumnTableViewCell.swift
//  Techitter
//
//  Created by 村上航輔 on 2019/09/28.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit

class CustumnTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellInformation(userName: String, post: String) {
        self.userNameLabel.text = userName
        self.postLabel.text = post
    }
}
