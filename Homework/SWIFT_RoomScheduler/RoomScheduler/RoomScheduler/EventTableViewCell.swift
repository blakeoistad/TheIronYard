//
//  EventTableViewCell.swift
//  RoomScheduler
//
//  Created by Blake Oistad on 10/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel :UILabel!
    @IBOutlet weak var eventStartLabel :UILabel!
    @IBOutlet weak var eventEndLabel :UILabel!
    
    
    
    //MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
