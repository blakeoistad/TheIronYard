//
//  RepairTableViewCell.swift
//  Maintain_Tennant
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class RepairTableViewCell: UITableViewCell {

    
    @IBOutlet var repairTitleLabel: UILabel!
    @IBOutlet var repairDescLabel: UILabel!
    @IBOutlet var repairSubmittedDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
