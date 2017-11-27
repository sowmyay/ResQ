//
//  NotifCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/29/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class NotifCell: UITableViewCell {

    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var reqType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
