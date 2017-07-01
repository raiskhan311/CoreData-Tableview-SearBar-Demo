//
//  TableViewCell.swift
//  CoreData-Tableview-SearBar-Demo
//
//  Created by mac on 01/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_ImageView: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!

    @IBOutlet weak var lbl_By: UILabel!
    
    @IBOutlet weak var lbl_Year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
