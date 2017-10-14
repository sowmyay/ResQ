//
//  RequestNotifCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/13/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestNotifCell: UITableViewCell {

    @IBOutlet weak var reqImage: UIImageView!
    @IBOutlet weak var reqTitleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func closeTouch(_ sender: Any) {
    }
    
    @IBAction func findHelpTouch(_ sender: Any) {
    }
}
