//
//  CustomTableViewCell.swift
//  Proficiency_iOS
//
//  Created by Prince Gupta on 17/02/20.
//  Copyright © 2020 Prince Gupta. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
