//
//  AdminWeeklyScheduleTableViewCell.swift
//  MyGYM
//
//  Created by  Deema on 17/01/1440 AH.
//  Copyright © 1440 Aseel Mohimeed. All rights reserved.
//

import UIKit

class AdminWeeklyScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classNameLable: UILabel!
    @IBOutlet weak var classTimeLable: UILabel!
    @IBOutlet weak var classCapacityLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
