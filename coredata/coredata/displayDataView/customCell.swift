//
//  customCell.swift
//  coredataProject
//
//  Created by sachin shinde on 04/01/20.
//  Copyright © 2020 sachin shinde. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet var lblPassword: UILabel!
    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
