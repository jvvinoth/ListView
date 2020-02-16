//
//  ListTableViewCell.swift
//  ListView
//
//  Created by Vinoth Varatharajan on 09/02/2020.
//  Copyright © 2020 Vin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel      : UILabel!
    @IBOutlet weak var nameLabel    : UILabel!
    @IBOutlet weak var titleLabel   : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
